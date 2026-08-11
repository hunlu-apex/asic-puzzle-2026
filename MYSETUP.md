GDS to Human-Readable Verilog
1. Inspect the GDS hierarchy with KLayout

First determine whether standard-cell names are preserved in the GDS.

Create cells.py:

import pya

layout = pya.Layout()
layout.read(input)

for cell in layout.each_cell():
    print(cell.name)

Run:

klayout -b -r cells.py -rd input=puzzle.gds

Filter for SKY130 cells:

klayout -b -r cells.py -rd input=puzzle.gds | grep sky130

We found cells such as:

sky130_fd_sc_hd__nand3b_2
sky130_fd_sc_hd__dfxtp_2
sky130_fd_sc_hd__mux2_1
sky130_fd_sc_hd__xor2_2
sky130_fd_sc_hd__inv_2
...

This was important because it showed that the standard-cell hierarchy survived in the GDS.

Therefore we did not need transistor-pattern matching like ReGDS.

2. Find the top-level GDS cell

Change cells.py to:

import pya

layout = pya.Layout()
layout.read(input)

for cell in layout.top_cells():
    print(cell.name)

Run:

klayout -b -r cells.py -rd input=puzzle.gds

For this design the top cell was:

puzzle
3. Install SKY130A

The OSS CAD Suite Magic installation did not have the SKY130 technology loaded initially.

Install ciel:

pip install ciel

List available SKY130 packages:

ciel ls-remote --pdk-family sky130

Enable/download a SKY130 build:

ciel enable --pdk-family sky130 <HASH>

The installed PDK ended up under:

~/.ciel/sky130A

Find the Magic RC file:

find ~/.ciel -name sky130A.magicrc

Set:

RC="$HOME/.ciel/sky130A/libs.tech/magic/sky130A.magicrc"

Check:

ls "$RC"
4. Upgrade Magic

The OSS CAD Suite version was:

Magic 8.3.105

The SKY130 technology file required at least:

Magic 8.3.411

So build a current Magic locally.

cd /tmp

git clone --depth 1 -b magic-8.3 \
    https://github.com/RTimothyEdwards/magic.git

cd magic

Configure:

./configure --prefix=$HOME/.local

Build:

make modules
make

Install:

make install

We initially encountered:

No rule to make target '../bplane/libbplane.o'

The fix was:

make -C bplane module

or, preferably, before installation:

make modules
make
make install

Verify the new Magic explicitly:

$HOME/.local/bin/magic --version

Our successful version was:

Magic 8.3 revision 681

Optionally put it first in PATH:

export PATH="$HOME/.local/bin:$PATH"
hash -r

Check:

which magic
magic --version
5. Verify that Magic can load SKY130A

Run:

RC="$HOME/.ciel/sky130A/libs.tech/magic/sky130A.magicrc"

$HOME/.local/bin/magic \
    -dnull \
    -noconsole \
    -rcfile "$RC" <<'EOF'

puts "TECH = [tech name]"
quit -noprompt

EOF

Successful output included:

Using technology "sky130A"
TECH = sky130A

At this point the SKY130 extraction setup was working.

6. Extract the GDS into hierarchical SPICE

Go to the puzzle directory:

cd ~/apexcompute/asic-puzzle-2026

Set variables:

RC="$HOME/.ciel/sky130A/libs.tech/magic/sky130A.magicrc"
GDS="$(readlink -f puzzle.gds)"

Run Magic:

$HOME/.local/bin/magic \
    -dnull \
    -noconsole \
    -rcfile "$RC" <<EOF

drc off

gds read $GDS
load puzzle

select top cell

extract all

ext2spice lvs
ext2spice hierarchy on
ext2spice blackbox off
ext2spice -o puzzle.spice

quit -noprompt

EOF

Successful completion looked like:

Processing puzzle
Total of 3 warnings.
exttospice finished.
7. Inspect the extracted SPICE

Check file size:

ls -lh puzzle.spice

Count hierarchical instances:

grep -c '^X' puzzle.spice

Result:

1893

Count transistor lines:

grep -c '^M' puzzle.spice

Result:

0

Count subcircuits:

grep -c '^.subckt' puzzle.spice

Result:

69

This was actually ideal:

1893 X instances
0    explicit transistor statements
69   subcircuits

Magic preserved the SKY130 cell hierarchy.

8. Find the top-level SPICE interface

Run:

grep -n '^.subckt puzzle' puzzle.spice

We recovered:

.subckt puzzle I O[0] O[1] O[2] O[3] O[4] O[5] O[6] O[7] clk enable rst_n success

So the design interface is:

Inputs:
    I
    clk
    enable
    rst_n

Outputs:
    O[7:0]
    success

Inspect the top-level instances:

grep -A50 '^.subckt puzzle' puzzle.spice | head -60

Inspect SKY130 subcircuits:

grep 'sky130_fd_sc_hd__' puzzle.spice | head -20

This showed pin orders such as:

.subckt sky130_fd_sc_hd__xnor2_2 Y A B VGND VPWR VPB VNB
.subckt sky130_fd_sc_hd__mux2_1 S A1 A0 X VGND VPWR VPB VNB
...

That gave us everything needed to reconstruct structural Verilog.

9. Convert SPICE into structural gate-level Verilog

We created:

spice2verilog.py

It:

parses the .subckt definitions,
learns each SKY130 cell's pin order,
parses the top-level X... instances,
emits named-pin Verilog,
removes physical-only power pins,
ignores decap/tap/filler/diode cells.

Run:

python3 spice2verilog.py puzzle.spice puzzle

Output:

puzzle_extracted.v

We then checked:

grep -c 'sky130_fd_sc_hd__df' puzzle_extracted.v

Result:

92

And:

grep -c 'sky130_fd_sc_hd__' puzzle_extracted.v

Result:

728

So the recovered functional design contained:

728 functional standard-cell instances
92 flip-flops
10. Inspect success

Find all references:

grep -n 'success' puzzle_extracted.v | head -20

We discovered that success was directly driven by a DFF:

grep -B10 -A5 '\.Q(success)' puzzle_extracted.v

Result:

sky130_fd_sc_hd__dfrtp_2 Xsky130_fd_sc_hd__dfrtp_2_81 (
    .Q(success),
    .RESET_B(rst_n),
    .D(n209),
    .CLK(n210)
);

So:

success_next = n209

at the corresponding clock edge.

To find the driver of n209:

grep -nE '\.(Y|X|Q|Q_N)\(n209\)' \
    -B10 -A10 puzzle_extracted.v

And to trace the clock:

grep -nE '\.(Y|X|Q|Q_N)\(n210\)' \
    -B8 -A8 puzzle_extracted.v
11. List every standard-cell type actually used

Run:

grep -E '^sky130_fd_sc_hd__' puzzle_extracted.v \
    | awk '{print $1}' \
    | sort -u

The design uses approximately 66 logical cell types, including:

a2111oi
a211o
a211oi
a21bo
a21boi
a21o
a21oi
a221o
a221oi
a22o
a22oi
a311o
a31o
a31oi
a32o
a41oi

and2
and2b
and3
and3b
and4
and4b
and4bb

nand2
nand2b
nand3
nand3b
nand4

nor2
nor3
nor3b
nor4
nor4b

or2
or3
or3b
or4
or4b
or4bb

o211a
o211ai
o21a
o21ai
o21ba
o21bai
o221a
o22a
o22ai
o2bb2a
o311a
o31a
o31ai
o32a
o32ai

xor2
xnor2
mux2

buf
clkbuf
inv
conb

dfxtp
dfrtp
dfstp
12. Attempted Yosys flattening

We initially tried converting the SKY130 library to generic Verilog using Yosys.

Find functional library:

CELLV="$HOME/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

Initial attempt:

yosys -p "
    read_verilog -D FUNCTIONAL $CELLV;
    read_verilog puzzle_extracted.v;
    hierarchy -check -top puzzle;
    flatten;
    proc;
    opt_clean;
    write_verilog -noattr puzzle_readable.v
"

This failed first because of:

UNIT_DELAY

So we tried:

yosys -p "
    verilog_defines -DUNIT_DELAY=;
    read_verilog -D FUNCTIONAL $CELLV;
    read_verilog puzzle_extracted.v;
    hierarchy -check -top puzzle;
    flatten;
    proc;
    opt_clean;
    write_verilog -noattr puzzle_readable.v
"
13. Yosys compatibility primitives

The SKY130 simulation library also used unsupported simulation primitives.

We created:

yosys_compat.v

with replacements for:

pullup
pulldown

sky130_fd_sc_hd__udp_mux_2to1

sky130_fd_sc_hd__udp_dff$P
sky130_fd_sc_hd__udp_dff$PR
sky130_fd_sc_hd__udp_dff$PS

Then:

yosys -p "
    read_verilog yosys_compat.v;
    read_verilog -D FUNCTIONAL -D UNIT_DELAY= $CELLV;
    read_verilog puzzle_extracted.v;

    hierarchy -check -top puzzle;

    flatten;
    proc;
    opt_clean;
    check;

    write_verilog -noattr puzzle_readable.v
"

We validated:

yosys -p "
    read_verilog puzzle_readable.v;
    hierarchy -check -top puzzle;
    check;
"

Result:

Found and reported 0 problems.

However, this approach was abandoned because flattening the entire SKY130 implementation made the Verilog much larger and less readable than the original gate-level netlist.

14. Final approach: directly compact the SKY130 cells

Instead of flattening the cell internals, directly convert:

one standard cell
       ↓
one Boolean expression

For example:

sky130_fd_sc_hd__nand2_2 ...

becomes:

assign n25 = ~(n10 & n11);

And:

sky130_fd_sc_hd__a21oi_2 ...

becomes:

assign n50 = ~((n1 & n2) | n3);

A mux becomes:

assign n50 = S ? A1 : A0;

A reset flip-flop becomes:

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state_reg <= 1'b0;
    else
        state_reg <= next_state;
end

We created:

compatify.py

Run:

python3 compatify.py \
    puzzle_extracted.v \
    puzzle_compact.v
15. Collapse the physical clock tree

compatify.py traces through:

clkbuf
buf

chains.

For example:

clk
 ↓
clkbuf
 ↓
n83
 ↓
clkbuf
 ↓
n210
 ↓
DFF

is reconstructed as simply:

always @(posedge clk)

instead of:

always @(posedge n210)

The script reports clock roots.

Expected:

Flip-flop clock roots:
  clk: 92 FFs

This confirms that all physical clock-tree nets belong to the same logical clock.

16. Rename recovered state

Instead of anonymous:

reg ff_81;

the compact converter uses the original Q net name:

success → success_reg
n206    → n206_reg
O[3]    → O_3_reg

So:

sky130_fd_sc_hd__dfrtp_2 ... (
    .Q(success),
    .RESET_B(rst_n),
    .D(n209),
    .CLK(n210)
);

becomes approximately:

reg success_reg;

assign success = success_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        success_reg <= 1'b0;
    else
        success_reg <= n209;
end

Internal FF Q nets are used directly as _reg names.

For example:

reg n206_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n206_reg <= 1'b0;
    else
        n206_reg <= n207;
end
17. Validate the final compact Verilog

Run:

yosys -p "
    read_verilog puzzle_compact.v;
    hierarchy -check -top puzzle;
    check;
"

The required result is:

Found and reported 0 problems.
Final working pipeline

The complete successful flow is:

puzzle.gds
    │
    │  KLayout
    ▼
inspect hierarchy
    │
    │  standard-cell names preserved
    ▼
Magic + SKY130A
    │
    ▼
puzzle.spice
    │
    │  parse hierarchical X instances
    ▼
puzzle_extracted.v
    │
    │  compatify.py
    │  SKY130 gates → Boolean equations
    │  clock tree → clk
    │  FF Q → *_reg
    ▼
puzzle_compact.v
    │
    │  Yosys check
    ▼
validated reconstructed RTL

The important files to keep are:

puzzle.gds             original layout

cells.py               GDS hierarchy inspection

puzzle.spice           Magic extracted connectivity

spice2verilog.py       SPICE → structural Verilog

puzzle_extracted.v     recovered SKY130 gate-level netlist

compatify.py           gates → compact Boolean/sequential RTL

puzzle_compact.v       final human-readable reconstruction

The puzzle_readable.v generated by flattening the complete SKY130 functional library is not part of the preferred final flow. It was useful as an experiment and structural cross-check, but it expanded the design rather than decompiling it cleanly.