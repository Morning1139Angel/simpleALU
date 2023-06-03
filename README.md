# simpleALU
simple alu as digital systems homework for college 


to test the alu run these commands in the root floder:
```bash
iverilog -o vvp/alu.vvp alu_tb.v
vvp vvp/alu.vvp
gtkwave vcd/alu.vcd
```