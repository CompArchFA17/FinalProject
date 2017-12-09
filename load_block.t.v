`include "load_block.v"
`include "data_memory.v"

// TODO(arianaolson419): create a test memory file with matrices. Add to testing script
module load_block_TEST();
	parameter ADDRESS_WIDTH = 32;
	reg[ADDRESS_WIDTH - 1:0] addr_initial;
	reg[ADDRESS_WIDTH - 1:0] columns;
	wire[ADDRESS_WIDTH - 1:0] addr0, addr1, addr2, addr3;
	wire[ADDRESS_WIDTH - 1:0] addr4, addr5, addr6, addr7, addr8;

	address3by3block #(.MEM_ADDRESS_WIDTH(ADDRESS_WIDTH)) dut (
		.addr_initial(addr_initial),
		.columns     (columns),
		.addr0       (addr0),
		.addr1       (addr1),
		.addr2       (addr2),
		.addr3       (addr3),
		.addr4       (addr4),
		.addr5       (addr5),
		.addr6       (addr6),
		.addr7       (addr7),
		.addr8       (addr8),
	);

	initial begin
		// tests
	end
endmodule