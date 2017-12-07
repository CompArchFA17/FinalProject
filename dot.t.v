"""Test bench for the 3 dimensional vector dot product."""

`include "dot.v"

module dot_TEST();

	parameter ENTRY_SIZE = 5;
	parameter RESENTRY_SIZE = 9;

	reg[ENTRY_SIZE - 1:0] a0, a1, a2, b0, b1, b2;
	wire[RESENTRY_SIZE - 1:0] product;

	dot #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) dut (a0, a1, a2, b0, b1, b2, product);
	initial begin
		a0 = 5'd0; a1 = 5'd0; a2 = 5'd0; b0 = 5'd0; b1 = 5'd0; b2 = 5'd0;
		#50
		if (product !== 9'd0) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd0, product);
		end

		a0 = 5'd1; a1 = 5'd0; a2 = 5'd0; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd2) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd2, product);
		end

		a0 = 5'd0; a1 = 5'd1; a2 = 5'd0; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd3) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd3, product);
		end

		a0 = 5'd0; a1 = 5'd0; a2 = 5'd1; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd4) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd4, product);
		end

		a0 = 5'd1; a1 = 5'd1; a2 = 5'd0; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd5) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd5, product);
		end

		a0 = 5'd1; a1 = 5'd0; a2 = 5'd1; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd6) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd6, product);
		end

		a0 = 5'd0; a1 = 5'd1; a2 = 5'd1; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd7) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd7, product);
		end

		a0 = 5'd1; a1 = 5'd1; a2 = 5'd1; b0 = 5'd2; b1 = 5'd3; b2 = 5'd4;
		#50
		if (product !== 9'd9) begin
			$display("Test failed. Expected: %d. Actual: %d.", 9'd9, product);
		end
	end
endmodule // dot_TEST

