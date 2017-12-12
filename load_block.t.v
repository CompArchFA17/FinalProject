`include "load_block.v"
`include "data_memory.v"

// TODO(arianaolson419): create a test memory file with matrices. Add to testing script
module load_block_TEST();
	parameter ADDRESS_WIDTH = 32;
	parameter ENTRY_SIZE = 5;
	parameter NUM_TESTS = 4;

	reg[ADDRESS_WIDTH - 1:0] addr_initial;
	reg[ADDRESS_WIDTH - 1:0] columns;
	wire[ADDRESS_WIDTH - 1:0] addrOut0, addrOut1, addrOut2, addrOut3;
	wire[ADDRESS_WIDTH - 1:0] addrOut4, addrOut5, addrOut6, addrOut7, addrOut8;

	address3by3block #(.MEM_ADDRESS_WIDTH(ADDRESS_WIDTH)) dut (
		.addr_initial(addr_initial),
		.columns     (columns),
		.addr0       (addrOut0),
		.addr1       (addrOut1),
		.addr2       (addrOut2),
		.addr3       (addrOut3),
		.addr4       (addrOut4),
		.addr5       (addrOut5),
		.addr6       (addrOut6),
		.addr7       (addrOut7),
		.addr8       (addrOut8)
	);

	reg clk;
	reg [ADDRESS_WIDTH - 1:0] addr0, addr1, addr2, addr3, addr4;
	reg [ADDRESS_WIDTH - 1:0] addr5, addr6, addr7, addr8;
	reg writeEnable;
	reg [ENTRY_SIZE - 1:0] dataIn0, dataIn1, dataIn2, dataIn3, dataIn4;
	reg [ENTRY_SIZE - 1:0] dataIn5, dataIn6, dataIn7, dataIn8;

	wire [ENTRY_SIZE - 1:0] data0, data1, data2, data3, data4;
	wire [ENTRY_SIZE - 1:0] data5, data6, data7, data8;

	data_memory #(.width(ENTRY_SIZE), .addresswidth(ADDRESS_WIDTH)) mem (
		.clk(clk), .data0(data0), .data1(data1), .data2(data2),
		.data3(data3), .data4(data4), .data5(data5), .data6(data6),
		.data7(data7), .data8(data8), .addr0(addr0), .addr1(addr1),
		.addr2(addr2), .addr3(addr3), .addr4(addr4), .addr5(addr5),
		.addr6(addr6), .addr7(addr7), .addr8(addr8), .writeEnable(writeEnable),
		.dataIn0(dataIn0), .dataIn1(dataIn1), .dataIn2(dataIn2),
		.dataIn3(dataIn3), .dataIn4(dataIn4), .dataIn5(dataIn5),
		.dataIn6(dataIn6), .dataIn7(dataIn7), .dataIn8(dataIn8)
	);

	reg[5:0] success_count = 0;

	initial begin
		$dumpfile("load_block.vcd");
		$dumpvars();
		
		// Test Case 1: read a 3x3 matrix from address zero
		addr_initial = 0;
		columns = 3;
		
		// cycle clock
		clk = 0;
		#1 clk = 1;
		#1
	
		if (addrOut0 === 0 & addrOut1 === 1 & addrOut2 === 2 & 
			addrOut3 === 3 & addrOut4 === 4 & addrOut5 === 5 & 
			addrOut6 === 6 & addrOut7 === 7 & addrOut8 === 8)
		begin
			// test passed
			success_count = success_count+1;
		end
		else begin
			$display("Test case 1 failed: 3x3 matrix at addres 0");
		end

		// Test Case 2: read top left block of 4x4 matrix from address 9
		addr_initial = 9;
		columns = 4;
		
		// cycle clock
		clk = 0;
		#1 clk = 1;
		#1
	
		if (addrOut0 === 9 & addrOut1 === 10 & addrOut2 === 11 & 
			addrOut3 === 13 & addrOut4 === 14 & addrOut5 === 15 & 
			addrOut6 === 17 & addrOut7 === 18 & addrOut8 === 19)
		begin
			// test passed
			success_count = success_count+1;
		end
		else begin
			$display("Test case 2 failed: 4x4 matrix at address 9");
		end

		// Test Case 3: read bottom right block of 4x4 matrix
		//				(starting at address 14)
		addr_initial = 14;
		columns = 4;
		
		// cycle clock
		clk = 0;
		#1 clk = 1;
		#1
	
		if (addrOut0 === 14 & addrOut1 === 15 & addrOut2 === 16 & 
			addrOut3 === 18 & addrOut4 === 19 & addrOut5 === 20 & 
			addrOut6 === 22 & addrOut7 === 23 & addrOut8 === 24)
		begin
			// test passed
			success_count = success_count+1;
		end
		else begin
			$display("Test case 3 failed: 4x4 matrix at address 14");
		end

		// Test Case 4: 7 column matrix at address 25
		addr_initial = 25;
		columns = 7;
		
		// cycle clock
		clk = 0;
		#1 clk = 1;
		#1
	
		if (addrOut0 === 25 & addrOut1 === 26 & addrOut2 === 27 & 
			addrOut3 === 32 & addrOut4 === 33 & addrOut5 === 34 & 
			addrOut6 === 39 & addrOut7 === 40 & addrOut8 === 41)
		begin
			// test passed
			success_count = success_count+1;
		end
		else begin
			$display("Test case 3 failed: 4x4 matrix at address 14");
		end

		if (success_count < NUM_TESTS) begin
			$display("\nLoad Block Failed %d Tests\n",(NUM_TESTS-success_count));
		end
		else begin
			$display("Load Block Passed All %d tests", NUM_TESTS);
		end

	end
endmodule
