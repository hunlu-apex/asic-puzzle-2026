#!/usr/bin/env python3

import re
import sys

SPICE = sys.argv[1]
TOP = sys.argv[2] if len(sys.argv) > 2 else "puzzle"


# ------------------------------------------------------------
# Read SPICE and join continuation lines beginning with '+'
# ------------------------------------------------------------

statements = []

with open(SPICE) as f:
    current = ""

    for raw in f:
        line = raw.strip()

        if not line:
            continue

        if line.startswith("*"):
            continue

        if line.startswith("+"):
            current += " " + line[1:].strip()
            continue

        if current:
            statements.append(current)

        current = line

    if current:
        statements.append(current)


# ------------------------------------------------------------
# Collect .subckt pin definitions
# ------------------------------------------------------------

subckts = {}
contents = {}

active = None

for line in statements:

    toks = line.split()
    if not toks:
        continue

    if toks[0].lower() == ".subckt":
        name = toks[1]
        pins = toks[2:]

        subckts[name] = pins
        contents[name] = []
        active = name
        continue

    if toks[0].lower() == ".ends":
        active = None
        continue

    if active is not None:
        contents[active].append(line)


if TOP not in subckts:
    print(f"ERROR: top '{TOP}' not found")
    sys.exit(1)


print(f"Top: {TOP}")
print(f"Top pins: {subckts[TOP]}")
print(f"Known subckts: {len(subckts)}")


# ------------------------------------------------------------
# Things that don't affect digital functionality
# ------------------------------------------------------------

IGNORE_CELL_PATTERNS = [
    "decap",
    "tapvpwrvgnd",
    "fill",
    "diode",
]


def ignore_cell(cell):
    return any(x in cell for x in IGNORE_CELL_PATTERNS)


# ------------------------------------------------------------
# Net naming
# ------------------------------------------------------------

top_net_map = {
    "I": "I",
    "clk": "clk",
    "enable": "enable",
    "rst_n": "rst_n",
    "success": "success",

    "O[0]": "O[0]",
    "O[1]": "O[1]",
    "O[2]": "O[2]",
    "O[3]": "O[3]",
    "O[4]": "O[4]",
    "O[5]": "O[5]",
    "O[6]": "O[6]",
    "O[7]": "O[7]",

    "VPWR": "VPWR",
    "VGND": "VGND",
}

net_map = dict(top_net_map)
next_net = 0


def verilog_net(n):
    global next_net

    if n in net_map:
        return net_map[n]

    name = f"n{next_net}"
    next_net += 1

    net_map[n] = name
    return name


def sanitize_instance(name):
    name = re.sub(r"[^A-Za-z0-9_$]", "_", name)

    if not re.match(r"[A-Za-z_]", name):
        name = "u_" + name

    return name


# ------------------------------------------------------------
# Decode top-level X instances
# ------------------------------------------------------------

instances = []

for line in contents[TOP]:

    toks = line.split()

    if not toks:
        continue

    if not toks[0][0].upper() == "X":
        continue

    inst = toks[0]
    cell = toks[-1]
    nets = toks[1:-1]

    if cell not in subckts:
        print(f"WARNING: no subckt definition for {cell}")
        continue

    pins = subckts[cell]

    if len(pins) != len(nets):
        print(
            f"WARNING {inst}: {cell}: "
            f"{len(nets)} nets vs {len(pins)} pins"
        )
        continue

    if ignore_cell(cell):
        continue

    connections = list(zip(pins, nets))

    instances.append(
        (
            sanitize_instance(inst),
            cell,
            connections,
        )
    )


# Force creation of all internal net names
for inst, cell, connections in instances:
    for pin, net in connections:
        verilog_net(net)


# ------------------------------------------------------------
# Write Verilog
# ------------------------------------------------------------

outfile = TOP + "_extracted.v"

with open(outfile, "w") as f:

    f.write("// Extracted from GDS via Magic\n\n")

    f.write(f"module {TOP} (\n")
    f.write("    input  wire       I,\n")
    f.write("    input  wire       clk,\n")
    f.write("    input  wire       enable,\n")
    f.write("    input  wire       rst_n,\n")
    f.write("    output wire [7:0] O,\n")
    f.write("    output wire       success\n")
    f.write(");\n\n")

    f.write("wire VPWR = 1'b1;\n")
    f.write("wire VGND = 1'b0;\n\n")

    internal = sorted(
        set(net_map.values())
        - {
            "I",
            "clk",
            "enable",
            "rst_n",
            "success",
            "VPWR",
            "VGND",
            "O[0]",
            "O[1]",
            "O[2]",
            "O[3]",
            "O[4]",
            "O[5]",
            "O[6]",
            "O[7]",
        },
        key=lambda x: int(x[1:]) if x.startswith("n") else 0,
    )

    if internal:
        f.write("wire ")
        f.write(", ".join(internal))
        f.write(";\n\n")

    for inst, cell, connections in instances:

        f.write(f"{cell} {inst} (\n")

        conn_strings = []

        for pin, net in connections:

            # Drop physical power/well pins from functional Verilog
            if pin in {"VPWR", "VGND", "VPB", "VNB"}:
                continue

            conn_strings.append(
                f"    .{pin}({verilog_net(net)})"
            )

        f.write(",\n".join(conn_strings))
        f.write("\n);\n\n")

    f.write("endmodule\n")


print()
print(f"Wrote: {outfile}")
print(f"Logic instances: {len(instances)}")
print(f"Internal nets: {next_net}")
