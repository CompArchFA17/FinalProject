/*
Add two 3 by 3 matrix blocks. 	
Performs the operation A + B = C

Entries 0 to 8
of all matrices are arranged in the following order:

	x0	x1	x2
	x3	x4	x5
	x6	x7	x8

Inputs:
	- a0, ..., a8: the entries of matrix A
	- b0, ..., a8: the entries of matrix B
Outputs:
	- c0, ..., c8: the entries of matrix C
Parameters:
	- ENTRY_SIZE: the number of bits of each matrix entry
*/

module add3by3
#(
	parameter ENTRY_SIZE = 5
)(
	input[ENTRY_SIZE - 1:0] a0, a1, a2, a3,
	input[ENTRY_SIZE - 1:0] a4, a5, a6, a7, a8,
	input[ENTRY_SIZE - 1:0] b0, b1, b2, b3,
	input[ENTRY_SIZE - 1:0] b4, b5, b6, b7, b8,
	output[ENTRY_SIZE - 1:0] c0, c1, c2, c3,
	output[ENTRY_SIZE - 1:0] c4, c5, c6, c7, c8
);
	assign c0 = a0 + b0;
	assign c1 = a1 + b1;
	assign c2 = a2 + b2;
	assign c3 = a3 + b3;
	assign c4 = a4 + b4;
	assign c5 = a5 + b5;
	assign c6 = a6 + b6;
	assign c7 = a7 + b7;
	assign c8 = a8 + b8;
endmodule