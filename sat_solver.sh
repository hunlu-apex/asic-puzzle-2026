SAT_CONSTRAINTS='-set rst_n 1 -set enable 0 -set clk 0'

for STEP_NUM in 1 2 3; do
  SAT_CONSTRAINTS="$SAT_CONSTRAINTS -set-at $STEP_NUM rst_n 0"
done

for STEP_NUM in $(seq 5 125); do
  SAT_CONSTRAINTS="$SAT_CONSTRAINTS -set-at $STEP_NUM enable 1"
done

yosys -Q -p "read_verilog puzzle_compact.v; prep -top puzzle; async2sync; opt_clean; sat -seq 127 -set-init-zero $SAT_CONSTRAINTS -set-at 127 success 1 -show I -show success -dump_vcd puzzle_success_sat.vcd"