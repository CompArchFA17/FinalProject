/*
Test bench for the full 6 by 6 multiplier
*/

`include "multiplier6by6.v"

module multiplier6by6_TEST();
	`define CLK_DELAY #50

	reg clk;

	multiplier6by6 dut (.clk(clk));

	initial clk = 0;
	always `CLK_DELAY clk = !clk;

	integer mem_out, i;

	initial begin
		$dumpfile("multiplier6by6.vcd");
		$dumpvars();
		
		#5000

		mem_out = $fopen("memory_out.txt");
		for (i=0; i<1024; i=i+1) begin
			$fdisplay(mem_out, "%d", dut.manager.data_mem.memory[i]);
		end
		$fclose(mem_out);

		$finish();
	end
endmodule
