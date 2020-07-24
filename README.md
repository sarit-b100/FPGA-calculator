# FPGA-calculator
This is a simple 4 function(ADD,SUB,MUL,DIV) calculator implemented on an FPGA.The inputs can be as long as 7-bits and the output register can hold as long as 13-bit data.But the product of 2 7-bit operands can exceed 13-bits.Therefore, input should be restricted to 90 to prevent the overflow of the "result" register. 
