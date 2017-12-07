"""Test bench for the scalar multiplication module"""

`include "arithmetic.v"
module scalar_multiplication_TEST();

parameter ENTRY_SIZE = 5;
parameter RESENTRY_SIZE = 9;

reg[ENTRY_SIZE - 1:0] a, b;
wire[RESENTRY_SIZE - 1:0] out;

scalar_multiplication #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) dut (a, b, out);

initial begin
	// Multiply by 0
	a = 5'd0; b = 5'd0; #50
	if (out !== 9'd0) begin
		$display("Test failed. Expected output: %b. Actual output: %b", 9'd0, out);
	end

	// Multiply by 1
	a = 5'd1; b = 5'd15; #50
	if (out !== 9'd15) begin
		$display("Test failed. Expected output: %b. Actual output: %b", 9'd15, out);
	end

	// Multiply two numbers that do not overflow the result size
	a = 5'd25; b = 5'd20; #50
	if (out !== 9'd500) begin
		$display("Test failed. Expected output: %b. Actual output: %b", 9'd500, out);
	end

	// Multiply two numbers that overflow the result size
	// Expect the most significant bits to be truncated
	a = 5'd31; b = 5'd25; #50
	if (out !== 9'd263) begin
		$display("Test failed. Expected output: %b. Actual output: %b", 9'd263, out);
	end
end
endmodule // testMult