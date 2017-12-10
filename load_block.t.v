`include "load_block.v"
`include "data_memory.v"

// TODO(arianaolson419): create a test memory file with matrices. Add to testing script
module load_block_TEST();
	parameter ADDRESS_WIDTH = 32;
	parameter ENTRY_SIZE = 5;

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

	memory #(.width(ENTRY_SIZE), .addresswidth(ADDRESS_WIDTH)) mem (
		.clk(clk), .data0(data0), .data1(data1), .data2(data2),
		.data3(data3), .data4(data4), .data5(data5), .data6(data6),
		.data7(data7), .data8(data8), .addr0(addr0), .addr1(addr1),
		.addr2(addr2), .addr3(addr3), .addr4(addr4), .addr5(addr5),
		.addr6(addr6), .addr7(addr7), .addr8(addr8), .writeEnable(writeEnable),
		.dataIn0(dataIn0), .dataIn1(dataIn1), .dataIn2(dataIn2),
		.dataIn3(dataIn3), .dataIn4(dataIn4), .dataIn5(dataIn5),
		.dataIn6(dataIn6), .dataIn7(dataIn7), .dataIn8(dataIn8)
	);

	initial begin
		// TODO(rocco): tests!
	end
endmodule