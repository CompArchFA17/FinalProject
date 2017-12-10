/*
Test bench for data memory module.
*/

`include "data_memory.v"

module memory_TEST();
	parameter ENTRY_SIZE = 5;
	parameter ADDRESS_WIDTH = 32;
	reg clk;
	reg [ADDRESS_WIDTH - 1:0] addr0, addr1, addr2, addr3, addr4;
	reg [ADDRESS_WIDTH - 1:0] addr5, addr6, addr7, addr8;
	reg writeEnable;
	reg [ENTRY_SIZE - 1:0] dataIn0, dataIn1, dataIn2, dataIn3, dataIn4;
	reg [ENTRY_SIZE - 1:0] dataIn5, dataIn6, dataIn7, dataIn8;

	wire [ENTRY_SIZE - 1:0] data0, data1, data2, data3, data4;
	wire [ENTRY_SIZE - 1:0] data5, data6, data7, data8;

	memory #(.width(ENTRY_SIZE), .addresswidth(ADDRESS_WIDTH)) dut(
		.clk(clk), .data0(data0), .data1(data1), .data2(data2),
		.data3(data3), .data4(data4), .data5(data5), .data6(data6),
		.data7(data7), .data8(data8), .addr0(addr0), .addr1(addr1),
		.addr2(addr2), .addr3(addr3), .addr4(addr4), .addr5(addr5),
		.addr6(addr6), .addr7(addr7), .addr8(addr8), .writeEnable(writeEnable),
		.dataIn0(dataIn0), .dataIn1(dataIn1), .dataIn2(dataIn2),
		.dataIn3(dataIn3), .dataIn4(dataIn4), .dataIn5(dataIn5),
		.dataIn6(dataIn6), .dataIn7(dataIn7), .dataIn8(dataIn8)
	);

	initial clk = 0;
	always #10 clk = !clk;
	initial begin
		$dumpfile("memory.vcd");
		$dumpvars(0, memory_TEST, dut.memory[0]);

		dataIn0 = 5'b00000; dataIn1 = dataIn0; dataIn2 = dataIn0;
		dataIn3 = dataIn0; dataIn4 = dataIn5; dataIn6 = dataIn0;
		dataIn7 = dataIn0; dataIn8 = dataIn0;

		addr0 = 32'd0;
		addr1 = addr0 + ADDRESS_WIDTH;
		addr2 = addr1 + ADDRESS_WIDTH;
		addr3 = addr2 + ADDRESS_WIDTH;
		addr4 = addr3 + ADDRESS_WIDTH;
		addr5 = addr4 + ADDRESS_WIDTH;
		addr6 = addr5 + ADDRESS_WIDTH;
		addr7 = addr6 + ADDRESS_WIDTH;
		addr8 = addr7 + ADDRESS_WIDTH;
		// Test Case 1: Do not write if writeEnable is low.
		writeEnable = 0; dataIn0 = 5'h1f;
		#20
		if (data0 === dataIn0) begin
			$display("Test case 1 failed: memory was written to when writeEnable was false.");
		end

		else if (data0 === 5'bx) begin
			$display("Test case 1 failed: there is no memory at the given address.");
		end

		#1000
		// Test case 2: Write to memory if writeEnable is high.
		writeEnable = 1;
		dataIn0 = 5'h1f;
		dataIn1 = 5'h1e;
		dataIn2 = 5'h1d;
		dataIn3 = 5'h1c;
		dataIn4 = 5'h1b;
		dataIn5 = 5'h1a;
		dataIn6 = 5'h19;
		dataIn7 = 5'h18;
		dataIn8 = 5'h17;

		#40
		
		if (data0 === 5'bx) begin
			$display("Test case 2 failed: there is no memory at the given address.");
		end

		if (dut.memory[0] !== dataIn0) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn");
		end

		// if (data0 !== dataIn0) begin
		// 	$display("Test case 2 failed: memory was not written to when writeEnable was true.");
		// end
		if (dut.memory[0] !== dataIn0) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn0");
		end
		if (dut.memory[1] !== dataIn1) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn1");
		end
		if (dut.memory[2] !== dataIn2) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn2");
		end
		if (dut.memory[3] !== dataIn3) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn3");
		end
		if (dut.memory[4] !== dataIn4) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn4");
		end
		if (dut.memory[5] !== dataIn5) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn5");
		end
		if (dut.memory[6] !== dataIn6) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn6");
		end
		if (dut.memory[7] !== dataIn7) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn7");
		end
		if (dut.memory[8] !== dataIn8) begin
			$display("Test case 2 failed: the memory contained at the given address does not match dataIn8");
		end


		#1000

		$finish;
	end
endmodule