/*
Test bench for the multiplication units
*/

`include "multiplier.v"

module multiplier_TEST();
	parameter ENTRY_SIZE = 5;
	parameter RESENTRY_SIZE = ENTRY_SIZE;

	reg clk;
	reg a_wrenable;
	reg b_wrenable;
	reg [ENTRY_SIZE - 1:0] a0_in, a1_in, a2_in, a3_in;
	reg [ENTRY_SIZE - 1:0] a4_in, a5_in, a6_in, a7_in, a8_in;
	reg [ENTRY_SIZE - 1:0] b0_in, b1_in, b2_in, b3_in;
	reg [ENTRY_SIZE - 1:0] b4_in, b5_in, b6_in, b7_in, b8_in;
	wire [RESENTRY_SIZE - 1:0] c0_out, c1_out, c2_out, c3_out;
	wire [RESENTRY_SIZE - 1:0] c4_out, c5_out, c6_out, c7_out, c8_out;

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) dut (
		.clk(clk), .a_wrenable(a_wrenable), .b_wrenable(b_wrenable), .a0_in(a0_in), .a1_in(a1_in), .a2_in(a2_in),
		.a3_in(a3_in), .a4_in(a4_in), .a5_in(a5_in), .a6_in(a6_in), .a7_in(a7_in), .a8_in(a8_in), .b0_in(b0_in), .b1_in(b1_in), .b2_in(b2_in),
		.b3_in(b3_in), .b4_in(b4_in), .b5_in(b5_in), .b6_in(b6_in), .b7_in(b7_in), .b8_in(b8_in), .c0_out(c0_out), .c1_out    (c1_out),
		.c2_out(c2_out), .c3_out(c3_out), .c4_out(c4_out), .c5_out(c5_out), .c6_out(c6_out), .c7_out(c7_out), .c8_out(c8_out)
	); 

	initial begin
		$dumpfile("multipliler.vcd");
		$dumpvars();
		clk = 0; a_wrenable = 0; b_wrenable = 0;

		a0_in = 5'd1; a1_in = 5'd0; a2_in = 5'd0;
		a3_in = 5'd0; a4_in = 5'd1; a5_in = 5'd0;
		a6_in = 5'd0; a7_in = 5'd0; a8_in = 5'd1;

		b0_in = 5'd1; b1_in = 5'd2; b2_in = 5'd3;
		b3_in = 5'd8; b4_in = 5'd9; b5_in = 5'd10;
		b6_in = 5'd15; b7_in = 5'd16; b8_in = 5'd17;

		#50

		
		a_wrenable = 1'b1; b_wrenable = 1'b1; clk = 1;

		#50 
		clk = 0; #50
		clk = 1; #50
		if (c0_out !== b0_in) begin
			$display("Test failed: c0_out is not the correct value.");
		end
		if (c1_out !== b1_in) begin
			$display("Test failed: c1_out is not the correct value.");
		end
		if (c2_out !== b2_in) begin
			$display("Test failed: c2_out is not the correct value.");
		end
		if (c3_out !== b3_in) begin
			$display("Test failed: c3_out is not the correct value.");
		end
		if (c4_out !== b4_in) begin
			$display("Test failed: c4_out is not the correct value.");
		end
		if (c5_out !== b5_in) begin
			$display("Test failed: c5_out is not the correct value.");
		end
		if (c6_out !== b6_in) begin
			$display("Test failed: c6_out is not the correct value.");
		end
		if (c7_out !== b7_in) begin
			$display("Test failed: c7_out is not the correct value.");
		end
		if (c8_out !== b8_in) begin
			$display("Test failed: c8_out is not the correct value.");
		end

		$finish();
	end
endmodule