/*
Test bench for 4 to 1 multiplexer
*/

`include "multiplexer.v"

module multiplexer4to1_TEST();
	parameter ENTRY_SIZE = 5;

	reg [1:0] res_sel;
	reg[(ENTRY_SIZE * 9) - 1:0] A, B, C, D;
	wire [(ENTRY_SIZE * 9) - 1:0] result;

	multiplexer4to1 #(.ENTRY_SIZE(ENTRY_SIZE)) dut (
		.res_sel(res_sel), .AEplusBG(A), .AFplusBH(B), .CEplusDG(C), .CFplusDH(D), .result(result)
	);

	initial begin
		A = {9{5'b00001}}; B = {9{5'b00010}}; C = {9{5'b00100}}; D = {9{5'b01000}};
		res_sel = 2'b00; #50

		if (result !== A) begin
			$display("Test failed: input 0 not selected");
		end

		res_sel = 2'b01; #50

		if (result !== B) begin
			$display("Test failed: input 1 not selected");
		end

		res_sel = 2'b10; #50

		if (result !== C) begin
			$display("Test failed: input 2 not selected");
		end

		res_sel = 2'b11; #50

		if (result !== D) begin
			$display("Test failed: input 3 not selected");
		end
	end
endmodule // multiplexer4to1_TEST