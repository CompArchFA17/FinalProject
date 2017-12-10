/*
Test bench for 3 by 3 matrix adder
*/

`include "add3by3.v"

module add3by3_TEST();
	parameter ENTRY_SIZE = 9;

	reg[ENTRY_SIZE - 1:0] a0, a1, a2, a3, a4;
	reg[ENTRY_SIZE - 1:0] a5, a6, a7, a8;
	reg[ENTRY_SIZE - 1:0] b0, b1, b2, b3, b4;
	reg[ENTRY_SIZE - 1:0] b5, b6, b7, b8;
	wire[ENTRY_SIZE - 1:0] c0, c1, c2, c3, c4;
	wire[ENTRY_SIZE - 1:0] c5, c6, c7, c8;

	add3by3 #(.ENTRY_SIZE(ENTRY_SIZE)) dut (
		.a0(a0), .a1(a1), .a2(a2), .a3(a3), .a4(a4),
		.a5(a5), .a6(a6), .a7(a7), .a8(a8), .b0(b0),
		.b1(b1), .b2(b2), .b3(b3), .b4(b4), .b5(b5),
		.b6(b6), .b7(b7), .b8(b8), .c0(c0), .c1(c1),
		.c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6),
		.c7(c7), .c8(c8)
	);

	initial begin
	 	// Add two matrices
		a0 = 1; a1 = 2; a2 = 3; a3 = 4; a4 = 5; a5 = 6; a6 = 7; a7 = 8; a8 = 9;
	  	b0 = 30; b1 = 29; b2 = 28; b3 = 27; b4 = 26; b5 = 25; b6 = 24; b7 = 23; b8 = 22;

	  	#50

		if (c0 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c0: %b\tActual value of c0: %b", a0 + b0, c0);
		end
		if (c1 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c1: %b\tActual value of c1: %b", a1 + b1, c1);
		end
		if (c2 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c2: %b\tActual value of c2: %b", a2 + b2, c2);
		end
		if (c3 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c3: %b\tActual value of c3: %b", a3 + b3, c3);
		end
		if (c4 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c4: %b\tActual value of c4: %b", a4 + b4, c4);
		end
		if (c5 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c5: %b\tActual value of c5: %b", a5 + b5, c5);
		end
		if (c6 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c6: %b\tActual value of c6: %b", a6 + b6, c6);
		end
		if (c7 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c7: %b\tActual value of c7: %b", a7 + b7, c7);
		end
		if (c8 !== 5'd31) begin
			$display("Test case failed.\nExpected value of c8: %b\tActual value of c8: %b", a8 + b8, c8);
		end
	end
endmodule