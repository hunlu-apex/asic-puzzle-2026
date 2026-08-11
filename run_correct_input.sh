iverilog -g2012 -s tb_success \
  -o success.vvp \
  puzzle_compact.v tb_success.sv

vvp success.vvp