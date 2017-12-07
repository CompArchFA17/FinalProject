/*
Multiply two square 3x3 matrices.
Represents the operation A * B = C
Inputs: 
	- matrixAv1, ..., v3 and matrixBv1, ..., v3 represent the rows of A and B.
Outputs: 
	- matrixCv1, ..., v3 repreents the rows of C.
Parameters: 
	- ENTRY_SIZE is the size of each individual entry of A and B.
	- RESENTRY_SIZE is the size of each individual entry in the result C.
	- VECTOR_SIZE is the size of each row vector in A and B.
	- RESVECTOR_SIZE is the size of each row vector in the result C.
*/

`include "dot.v"

module matrixmultiplication3by3
#(
	parameter ENTRY_SIZE = 5,
	parameter RESENTRY_SIZE = 9,
	parameter VECTOR_SIZE = 3 * ENTRY_SIZE,
	parameter RESVECTOR_SIZE = 3 * RESENTRY_SIZE
)
(
	input[VECTOR_SIZE - 1: 0] matrixAv1, matrixAv2, matrixAv3, 
	input[VECTOR_SIZE - 1: 0] matrixBv1, matrixBv2, matrixBv3,
	output [RESVECTOR_SIZE - 1: 0] matrixCv1, matrixCv2, matrixCv3
);

wire[RESENTRY_SIZE - 1:0] c11, c12, c13;
wire[RESENTRY_SIZE - 1:0] c21, c22, c23;
wire[RESENTRY_SIZE - 1:0] c31, c32, c33;

// Row 1 Column 1
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r1c1 (
	.a0(matrixAv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c11));

// Row 1 Column 2
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r1c2 (
	.a0(matrixAv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c12));

// Row 1 Column 3
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r1c3 (
	.a0(matrixAv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c13));

// Row 2 Column 1
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r2c1 (
	.a0(matrixAv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c21));

// Row 2 Column 2
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r2c2 (
	.a0(matrixAv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c22));

// Row 2 Column 3
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r2c3 (
	.a0(matrixAv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c23));

// Row 3 Column 1
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r3c1 (
	.a0(matrixAv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv1[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv1[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv1[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c31));

// Row 3 Column 2
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r3c2 (
	.a0(matrixAv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv2[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv2[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv2[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c32));

// Row 3 Column 3
dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) r3c3 (
	.a0(matrixAv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.a1(matrixAv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.a2(matrixAv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.b0(matrixBv3[VECTOR_SIZE - 1:VECTOR_SIZE - ENTRY_SIZE]),
	.b1(matrixBv3[VECTOR_SIZE - ENTRY_SIZE - 1: VECTOR_SIZE - (2 * ENTRY_SIZE)]),
	.b2(matrixBv3[VECTOR_SIZE - (2 * ENTRY_SIZE) - 1: 0]),
	.product(c33));

assign matrixCv1 = {{c11}, {c12}, {c13}};
assign matrixCv2 = {{c21}, {c22}, {c23}};
assign matrixCv3 = {{c31}, {c32}, {c33}};

endmodule