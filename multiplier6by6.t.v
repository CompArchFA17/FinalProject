/*
Test bench for the full 6 by 6 multiplier
*/

`include "multiplier6by6.v"

module multiplier6by6_TEST();
	`define CLK_DELAY #50

	`define EXPECTED_AEBG 45'b101011100010101100111101111001100011001110010
	`define EXPECTED_AFBH 45'b100101000101111101001001001110100100111001100
	`define EXPECTED_CEDG 45'b001110111101110100111001011000101111101010110
	`define EXPECTED_CFDH 45'b011000110000111101011000101111101111011010010
	parameter NUM_TESTS = 1;

	reg clk;

	reg[5:0] success_count;

	multiplier6by6 dut (.clk(clk));

	`define AEplusBG dut.network.chooseres.AEplusBG
	`define AFplusBH dut.network.chooseres.AFplusBH
	`define CEplusBG dut.network.chooseres.CEplusDG
	`define CFplusDH dut.network.chooseres.CFplusDH

	initial clk = 0;
	always `CLK_DELAY clk = !clk;

	initial begin
		$dumpfile("multiplier6by6.vcd");
		$dumpvars();
		
		#50
		#5000

		if (dut.network.chooseres.AEplusBG[44:40] === 5'd21) $display("success");
		$display("AE + BG %b", dut.network.chooseres.AEplusBG);
		$display("AF + BH %b", dut.network.chooseres.AFplusBH);
		$display("CE + DG %b", dut.network.chooseres.CEplusDG);
		$display("CF + DH %b", dut.network.chooseres.CFplusDH);

		$finish();
	end
endmodule