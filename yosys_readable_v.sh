CELLV="$HOME/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

ls -lh "$CELLV"

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
