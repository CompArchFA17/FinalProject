/*
A block containing a 3 by 3 matrix multiplier and registers
holding the data for both the operands and the result.
*/

`include "registers.v"
`include "matrixmultiplication.v"

module multiplier
#(
	parameter ENTRY_SIZE = 5,
	parameter RESENTRY_SIZE = 5
)(
	input clk,
	input a_wrenable,
	input b_wrenable,
	input [ENTRY_SIZE - 1:0] a0_in, a1_in, a2_in, a3_in,
	input [ENTRY_SIZE - 1:0] a4_in, a5_in, a6_in, a7_in, a8_in,
	input [ENTRY_SIZE - 1:0] b0_in, b1_in, b2_in, b3_in,
	input [ENTRY_SIZE - 1:0] b4_in, b5_in, b6_in, b7_in, b8_in,
	output [RESENTRY_SIZE - 1:0] c0_out, c1_out, c2_out, c3_out,
	output [RESENTRY_SIZE - 1:0] c4_out, c5_out, c6_out, c7_out, c8_out
);
	wire [ENTRY_SIZE - 1:0] a0_out, a1_out, a2_out, a3_out;
	wire [ENTRY_SIZE - 1:0] a4_out, a5_out, a6_out, a7_out, a8_out;
	wire [ENTRY_SIZE - 1:0] b0_out, b1_out, b2_out, b3_out;
	wire [ENTRY_SIZE - 1:0] b4_out, b5_out, b6_out, b7_out, b8_out;
	wire [RESENTRY_SIZE - 1:0] c0_in, c1_in, c2_in, c3_in;
	wire [RESENTRY_SIZE - 1:0] c4_in, c5_in, c6_in, c7_in, c8_in;

	regfile #(.width(ENTRY_SIZE)) registers (
		.a_wrenable(a_wrenable), .b_wrenable(b_wrenable), .c_wrenable(1'b1), .a0_in(a0_in), .a1_in(a1_in), .a2_in(a2_in),
		.a3_in(a3_in), .a4_in(a4_in), .a5_in(a5_in), .a6_in(a6_in), .a7_in(a7_in), .a8_in(a8_in),
		.b0_in(b0_in), .b1_in(b1_in), .b2_in(b2_in), .b3_in(b3_in), .b4_in(b4_in), .b5_in(b5_in),
		.b6_in(b6_in), .b7_in(b7_in), .b8_in(b8_in), .c0_in(c0_in), .c1_in(c1_in), .c2_in(c2_in), .c3_in(c3_in),
		.c4_in(c4_in), .c5_in(c5_in), .c6_in(c6_in), .c7_in(c7_in), .c8_in(c8_in), .a0_out(a0_out), .a1_out(a1_out),
		.a2_out(a2_out), .a3_out(a3_out), .a4_out(a4_out), .a5_out(a5_out), .a6_out(a6_out), .a7_out(a7_out), .a8_out(a8_out),
		.b0_out(b0_out), .b1_out(b1_out), .b2_out(b2_out), .b3_out(b3_out), .b4_out(b4_out), .b5_out(b5_out),
		.b6_out(b6_out), .b7_out(b7_out), .b8_out(b8_out), .c0_out(c0_out), .c1_out(c1_out), .c2_out(c2_out), .c3_out(c3_out),
		.c4_out(c4_out), .c5_out(c5_out), .c6_out(c6_out), .c7_out(c7_out), .c8_out(c8_out), .clk(clk)
	);

	matrixmultiplication3by3 #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) mult (
		.matrixAv1({{a0_out}, {a1_out}, {a2_out}}), .matrixAv2({{a3_out}, {a4_out}, {a5_out}}), .matrixAv3({{a6_out}, {a7_out}, {a8_out}}),
		.matrixBv1({{b0_out}, {b1_out}, {b2_out}}), .matrixBv2({{b3_out}, {b4_out}, {b5_out}}), .matrixBv3({{b6_out}, {b7_out}, {b8_out}}),
		.matrixCv1({{c0_in}, {c1_in}, {c2_in}}), .matrixCv2({{c3_in}, {c4_in}, {c5_in}}), .matrixCv3({{c6_in}, {c7_in}, {c8_in}})
	);
endmodule