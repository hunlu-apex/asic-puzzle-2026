#!/usr/bin/env python3

import re
import sys
import collections

# ============================================================
# Usage:
#
#   python3 compatify.py puzzle_extracted.v puzzle_compact.v
#
# ============================================================

if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} input.v [output.v]")
    sys.exit(1)

srcfile = sys.argv[1]
outfile = sys.argv[2] if len(sys.argv) > 2 else "puzzle_compact.v"

with open(srcfile) as f:
    src = f.read()


# ============================================================
# Parse SKY130 instances
# ============================================================

inst_re = re.compile(
    r'(?ms)^\s*'
    r'(sky130_fd_sc_hd__[A-Za-z0-9_]+)\s+'
    r'([A-Za-z0-9_$]+)\s*'
    r'\((.*?)\);\s*'
)

conn_re = re.compile(
    r'\.([A-Za-z0-9_]+)\s*\(\s*([^)]+?)\s*\)'
)

instances = []

for m in inst_re.finditer(src):
    cell, inst, body = m.groups()
    con = dict(conn_re.findall(body))
    instances.append((cell, inst, con))

if not instances:
    raise SystemExit("ERROR: No SKY130 instances found.")


# Keep everything before the first SKY130 instance.
# This includes module header, IO declarations and wire declarations.

first_instance = inst_re.search(src).start()
prefix = src[:first_instance].rstrip() + "\n\n"


# ============================================================
# SKY130 cell helper
# ============================================================

def base_name(cell):
    """
    Examples:

      sky130_fd_sc_hd__nand3b_2 -> nand3b
      sky130_fd_sc_hd__clkbuf_16 -> clkbuf
      sky130_fd_sc_hd__mux2_1 -> mux2
    """

    name = cell.split("__", 1)[1]
    return re.sub(r'_\d+$', '', name)


# ============================================================
# First pass: identify all flip-flop Q nets and give them
# human-readable *_reg names.
# ============================================================

FF_TYPES = {
    "dfxtp",
    "dfrtp",
    "dfstp",
}

q_to_reg = {}
used_reg_names = set()


def make_reg_name(qnet):
    """
    Examples:

      success -> success_reg
      n206    -> n206_reg
      O[3]    -> O_3_reg
    """

    name = re.sub(r'[^A-Za-z0-9_$]+', '_', qnet)
    name = name.strip('_')

    if not name:
        name = "state"

    if not re.match(r'[A-Za-z_]', name):
        name = "state_" + name

    candidate = name + "_reg"
    original = candidate

    i = 1

    while candidate in used_reg_names:
        candidate = f"{original}_{i}"
        i += 1

    used_reg_names.add(candidate)
    return candidate


for cell, inst, con in instances:
    base = base_name(cell)

    if base in FF_TYPES:
        if "Q" not in con:
            raise RuntimeError(
                f"{inst} ({cell}) has no Q connection"
            )

        qnet = con["Q"]

        if qnet not in q_to_reg:
            q_to_reg[qnet] = make_reg_name(qnet)


# ============================================================
# Net naming
#
# All references to a FF Q net are changed to its *_reg name.
# ============================================================

def net_name(net):
    return q_to_reg.get(net, net)


# ============================================================
# Build identity-buffer driver map.
#
# This lets us turn:
#
#   clk -> clkbuf -> clkbuf -> n210 -> FF.CLK
#
# back into:
#
#   always @(posedge clk)
#
# ============================================================

buffer_driver = {}

for cell, inst, con in instances:
    base = base_name(cell)

    if base in ("buf", "clkbuf"):

        if "A" not in con:
            continue

        if "X" in con:
            buffer_driver[con["X"]] = con["A"]

        elif "Y" in con:
            buffer_driver[con["Y"]] = con["A"]


def trace_buffer_root(net):
    """
    Follow only pure buffer/clock-buffer chains backwards.
    """

    seen = set()
    cur = net

    while cur in buffer_driver:

        if cur in seen:
            break

        seen.add(cur)
        cur = buffer_driver[cur]

    return cur


def clock_name(net):
    """
    Collapse buffer-only clock trees.

      n210 <- clkbuf <- clkbuf <- clk

    becomes:

      clk

    If this is a genuinely generated/gated clock, tracing stops
    at the combinational source instead.
    """

    root = trace_buffer_root(net)

    return net_name(root)


# ============================================================
# Signal helper
#
# SKY130 pin names ending in _N are logically inverted inputs.
#
# Examples:
#
#   A_N  -> ~(signal)
#   B1_N -> ~(signal)
# ============================================================

def signal(pin, con):

    value = net_name(con[pin])

    if pin.endswith("_N"):
        return f"~({value})"

    return value


def output_pin(con):

    if "X" in con:
        return "X"

    if "Y" in con:
        return "Y"

    raise ValueError("Cell has no X/Y output")


# ============================================================
# Combinational SKY130 -> Boolean expression
# ============================================================

def logic_expression(base, con):

    # --------------------------------------------------------
    # inverter
    # --------------------------------------------------------

    if base == "inv":
        return "Y", f"~({net_name(con['A'])})"


    # --------------------------------------------------------
    # buffers
    # --------------------------------------------------------

    if base in ("buf", "clkbuf"):
        return "X", net_name(con["A"])


    # --------------------------------------------------------
    # mux
    # --------------------------------------------------------

    if base == "mux2":

        return "X", (
            f"({net_name(con['S'])} ? "
            f"{net_name(con['A1'])} : "
            f"{net_name(con['A0'])})"
        )


    # --------------------------------------------------------
    # XOR / XNOR
    # --------------------------------------------------------

    if base == "xor2":

        return "X", (
            f"({net_name(con['A'])} ^ "
            f"{net_name(con['B'])})"
        )


    if base == "xnor2":

        return "Y", (
            f"~({net_name(con['A'])} ^ "
            f"{net_name(con['B'])})"
        )


    power_pins = {
        "VPWR",
        "VGND",
        "VPB",
        "VNB",
    }

    output_pins = {
        "X",
        "Y",
        "Q",
        "Q_N",
        "HI",
        "LO",
    }

    pins = [
        p
        for p in con
        if p not in power_pins
        and p not in output_pins
    ]


    # --------------------------------------------------------
    # NAND
    # --------------------------------------------------------

    if base.startswith("nand"):

        expr = " & ".join(
            signal(p, con)
            for p in pins
        )

        return "Y", f"~({expr})"


    # --------------------------------------------------------
    # AND
    # --------------------------------------------------------

    if base.startswith("and"):

        expr = " & ".join(
            signal(p, con)
            for p in pins
        )

        return "X", f"({expr})"


    # --------------------------------------------------------
    # NOR
    # --------------------------------------------------------

    if base.startswith("nor"):

        expr = " | ".join(
            signal(p, con)
            for p in pins
        )

        return "Y", f"~({expr})"


    # --------------------------------------------------------
    # OR
    # --------------------------------------------------------

    if base.startswith("or"):

        expr = " | ".join(
            signal(p, con)
            for p in pins
        )

        return "X", f"({expr})"


    # --------------------------------------------------------
    # AO / AOI
    #
    # a21o:
    #
    #   (A1 & A2) | B1
    #
    # a221oi:
    #
    #   ~((A1 & A2) | (B1 & B2) | C1)
    #
    # --------------------------------------------------------
    #
    # OA / OAI
    #
    # o21a:
    #
    #   (A1 | A2) & B1
    #
    # o32ai:
    #
    #   ~((A1 | A2 | A3) & (B1 | B2))
    #
    # --------------------------------------------------------

    if base.startswith("a") or base.startswith("o"):

        groups = collections.OrderedDict()

        for pin in pins:

            m = re.match(r'([A-Z])', pin)

            if not m:
                raise ValueError(
                    f"{base}: unexpected pin '{pin}'"
                )

            group = m.group(1)

            groups.setdefault(group, []).append(pin)


        terms = []


        # AND groups, then OR together
        if base.startswith("a"):

            for gpins in groups.values():

                term = " & ".join(
                    signal(p, con)
                    for p in gpins
                )

                terms.append(f"({term})")

            expr = "(" + " | ".join(terms) + ")"


        # OR groups, then AND together
        else:

            for gpins in groups.values():

                term = " | ".join(
                    signal(p, con)
                    for p in gpins
                )

                terms.append(f"({term})")

            expr = "(" + " & ".join(terms) + ")"


        # AOI / OAI
        if base.endswith("i"):
            expr = "~" + expr

        return output_pin(con), expr


    raise ValueError(
        f"Unsupported combinational cell: {base}"
    )


# ============================================================
# Determine which FF Q nets are top-level outputs.
#
# For this puzzle:
#
#   O[7:0]
#   success
#
# Internal Q nets don't need alias wires.
# ============================================================

def is_top_output(net):

    if net == "success":
        return True

    if re.fullmatch(r'O\[\d+\]', net):
        return True

    return False


# ============================================================
# Convert
# ============================================================

logic = []
unsupported = []

ff_regs = list(q_to_reg.values())


for cell, inst, con in instances:

    base = base_name(cell)

    try:

        # ----------------------------------------------------
        # constant generator
        # ----------------------------------------------------

        if base == "conb":

            if "HI" in con:
                logic.append(
                    f"assign {net_name(con['HI'])} = 1'b1;"
                    f" // {inst} ({base})"
                )

            if "LO" in con:
                logic.append(
                    f"assign {net_name(con['LO'])} = 1'b0;"
                    f" // {inst} ({base})"
                )

            continue


        # ----------------------------------------------------
        # Flip flops
        # ----------------------------------------------------

        if base in FF_TYPES:

            qnet = con["Q"]
            qreg = q_to_reg[qnet]

            clk = clock_name(con["CLK"])
            d = net_name(con["D"])


            # If Q is a top-level output, connect the reg to it.
            #
            # Internal FF outputs are referenced directly by
            # their *_reg names everywhere else.

            if is_top_output(qnet):

                logic.append(
                    f"assign {qnet} = {qreg};"
                    f" // {inst}"
                )


            # ------------------------------------------------
            # dfxtp:
            #
            # positive-edge DFF
            # ------------------------------------------------

            if base == "dfxtp":

                logic.append(
                    f"always @(posedge {clk}) begin"
                )

                logic.append(
                    f"    {qreg} <= {d};"
                )

                logic.append("end")


            # ------------------------------------------------
            # dfrtp:
            #
            # positive-edge DFF
            # active-low asynchronous reset
            # ------------------------------------------------

            elif base == "dfrtp":

                reset = net_name(con["RESET_B"])

                logic.append(
                    f"always @(posedge {clk} "
                    f"or negedge {reset}) begin"
                )

                logic.append(
                    f"    if (!{reset})"
                )

                logic.append(
                    f"        {qreg} <= 1'b0;"
                )

                logic.append(
                    f"    else"
                )

                logic.append(
                    f"        {qreg} <= {d};"
                )

                logic.append("end")


            # ------------------------------------------------
            # dfstp:
            #
            # positive-edge DFF
            # active-low asynchronous set
            # ------------------------------------------------

            elif base == "dfstp":

                set_b = net_name(con["SET_B"])

                logic.append(
                    f"always @(posedge {clk} "
                    f"or negedge {set_b}) begin"
                )

                logic.append(
                    f"    if (!{set_b})"
                )

                logic.append(
                    f"        {qreg} <= 1'b1;"
                )

                logic.append(
                    f"    else"
                )

                logic.append(
                    f"        {qreg} <= {d};"
                )

                logic.append("end")


            logic.append("")

            continue


        # ----------------------------------------------------
        # combinational cell
        # ----------------------------------------------------

        outpin, expr = logic_expression(base, con)

        outnet = net_name(con[outpin])

        logic.append(
            f"assign {outnet} = {expr};"
            f" // {inst} ({base})"
        )


    except Exception as e:

        unsupported.append(
            (cell, inst, str(e))
        )


# ============================================================
# Don't silently create wrong Verilog
# ============================================================

if unsupported:

    print(
        "\nERROR: Unsupported cells/instances:",
        file=sys.stderr
    )

    for cell, inst, err in unsupported:

        print(
            f"  {cell} {inst}: {err}",
            file=sys.stderr
        )

    raise SystemExit(
        f"\n{len(unsupported)} unsupported instances."
        "\nNo output generated."
    )


# ============================================================
# Clock report
# ============================================================

clock_roots = collections.Counter()

for cell, inst, con in instances:

    base = base_name(cell)

    if base in FF_TYPES:

        raw_clock = con["CLK"]
        root = trace_buffer_root(raw_clock)

        clock_roots[net_name(root)] += 1


print("\nFlip-flop clock roots:")

for root, count in sorted(clock_roots.items()):
    print(f"  {root}: {count} FFs")


# ============================================================
# Write output
# ============================================================

with open(outfile, "w") as f:

    f.write(prefix)

    if ff_regs:

        f.write("// Recovered state registers\n")

        for reg in ff_regs:
            f.write(f"reg {reg};\n")

        f.write("\n")

    f.write("// Recovered logic\n\n")

    f.write("\n".join(logic))

    f.write("\nendmodule\n")


print()
print(f"Wrote: {outfile}")
print(f"Converted instances: {len(instances)}")
print(f"Flip-flops: {len(ff_regs)}")
print(f"Combinational cells: {len(instances) - len(ff_regs)}")