/*
Address the entries of a 3 by 3 block of memory within a matrix stored in
the data memory. Matrices are stored in the data memory such that
each word is an entry of the matrix, and entries are stored one row at a time.

Example: 
3 by 3 Matrix        Data Memory
-------------		 -----------
a11	a12	a13          a11
a21	a22	a23    =>    a12
a31	a32 a33          a13
					 a21
					 a22
					 a23
					 a31
					 a32
					 a33

Inputs:
	- addr_initial: the address of the first entry of the block.
	- columns: the number of columns of the entire matrix stored in memory.
Outputs:
	- addr<x>: the address of the xth element of the block in data memory.
Parameters:
	- MEM_ADDRESS_WIDTH: the number of bits of the addressees given to the data memory.
*/

module address3by3block
#(parameter MEM_ADDRESS_WIDTH = 32)
(
	input[MEM_ADDRESS_WIDTH - 1:0] addr_initial,
	input[MEM_ADDRESS_WIDTH - 1:0] columns,
	output[MEM_ADDRESS_WIDTH - 1:0] addr0, addr1, addr2, addr3, addr4,
	output[MEM_ADDRESS_WIDTH - 1:0] addr5, addr6, addr7, addr8
);
	assign addr0 = addr_initial;
	assign addr1 = addr_initial + 1;
	assign addr2 = addr_initial + 2;
	assign addr3 = addr_initial + columns;
	assign addr4 = addr_initial + columns + 1;
	assign addr5 = addr_initial + columns + 2;
	assign addr6 = addr_initial + (2 * columns);
	assign addr7 = addr_initial + (2 * columns) + 1;
	assign addr8 = addr_initial + (2 * columns) + 2;
endmodule