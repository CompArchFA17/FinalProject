`include "data_memory.v"
`include "registers.v"
`include "load_block.v"
/*
The Matrix Manager loads or writes matrices using 3x3 matrices at a time. Starting from (0,0),
the matrix manager iterates through the addresses of all the matrices in row major order, according 
to the control signals given as input that tell when to move to the next row, and how long the rows are.
The control signals also control whether we write to memory or save to memory.

Inputs:
	- clk
	- dm_we: whether we should write to memory
	- next_row: signals whether we should address from the next row of 3x3 matrices
	- column: signals which column size to use - the column size of the first matrix, 
		or the column size of the second and result matrices.
	- n: number of rows on the first array
	- m: number of columns on the first matrix, and number of rows on the second matrix
	- p: number of columns on the second matrix
	- dataIn0...dataIn8: input 3x3 array

Outputs:
	- dataOut0...dataOut8: output 3x3 array

*/


module matrix_manager #(parameter ADDR_WIDTH=10, parameter DATA_WIDTH=5)
(
	input clk, dm_we, next_row, column,
	input[ADDR_WIDTH-1:0] n, m, p,
	input[DATA_WIDTH-1:0] dataIn0, dataIn1, dataIn2, dataIn3, dataIn4, dataIn5, dataIn6, dataIn7, dataIn8,
	output[DATA_WIDTH-1:0] dataOut0, dataOut1, dataOut2, dataOut3, dataOut4, dataOut5, dataOut6, dataOut7, dataOut8
);

wire[ADDR_WIDTH-1:0] addr0, addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8;

memory #(
		.width(DATA_WIDTH),
		.addresswidth(ADDR_WIDTH)
	)
	data_mem (	
		.clk(clk),
		.data0(dataOut0), .data1(dataOut1), .data2(dataOut2), .data3(dataOut3), .data4(dataOut4),
		.data5(dataOut5), .data6(dataOut6), .data7(dataOut7), .data8(dataOut8),
		.addr0(addr0), .addr1(addr1), .addr2(addr2), .addr3(addr3), .addr4(addr4),
		.addr5(addr5), .addr6(addr6), .addr7(addr7), .addr8(addr8),
		.writeEnable(dm_we),
		.dataIn0(dataIn0), .dataIn1(dataIn1), .dataIn2(dataIn2), .dataIn3(dataIn3), .dataIn4(dataIn4),
		.dataIn5(dataIn5), .dataIn6(dataIn6), .dataIn7(dataIn7), .dataIn8(dataIn8)
	);

reg[ADDR_WIDTH-1:0] next_addr;
reg                                                                                                                                             [ADDR_WIDTH-1:0] curr_addr;

reg[ADDR_WIDTH-1:0] num_columns;

address3by3block #(.MEM_ADDRESS_WIDTH(ADDR_WIDTH)) addr_loader
	(
		.addr_initial(curr_addr),
		.columns(num_columns),
		.addr0(addr0), .addr1(addr1), .addr2(addr2), .addr3(addr3), .addr4(addr4),
		.addr5(addr5), .addr6(addr6), .addr7(addr7), .addr8(addr8)
	);

initial begin
	next_addr = {ADDR_WIDTH{1'b0}};

end

always @(posedge clk) begin
	curr_addr = next_addr;

	if (next_row == 1'b1) begin
		next_addr = curr_addr + 3 + (2*num_columns);
	end
	else begin
		next_addr = curr_addr + 3;
	end

	if (column == 1'b1)
		num_columns = p;
	else
		num_columns = m;
end
endmodule