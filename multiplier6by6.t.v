/*
Test bench for the full 6 by 6 multiplier
*/

`include "multiplier6by6.v"

module multiplier6by6_TEST();
	`define CLK_DELAY #50
	parameter NUM_TESTS = 1;

	reg clk;

	reg[5:0] success_count;

	multiplier6by6 dut (.clk(clk));

	initial begin
		$dumpfile("multiplier6by6.vcd");
		$dumpvars();
		clk = 0; `CLK_DELAY
		clk = 0; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY
		clk = !clk; `CLK_DELAY

		$finish();
	end
endmodule