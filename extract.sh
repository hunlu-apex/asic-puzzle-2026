#!/bin/bash

RC="$HOME/.ciel/sky130A/libs.tech/magic/sky130A.magicrc"
GDS="$(readlink -f puzzle.gds)"

$HOME/.local/bin/magic \
    -dnull -noconsole \
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
