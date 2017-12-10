/*
Manages the control signals throught the matrix multiplier based on an input command

commad structure:
	|type|block|
	| 0 0|0 0 0|

type selects between load (00)  and store (01)
block selects the block matrix to either load from or store to
	000 = A ... 111 = H
	x00 = J ... x11 = M

Inputs:
	- command: the command from program memory, structure explained above
Outputs:
	- data_we: write enable for the data memory
	- weA-weH: write enables for each input to the computation blocks
	- jklm_select: select bits for mux on the output matricies
*/

module fsm
#(
parameter TYPE_LEN = 2,
parameter BLOCK_LEN = 3
)
(
	input[TYPE_LEN+BLOCK_LEN-1:0] command,
	output data_we,
	output weA, weB, weC, weD, weE, weF, weG, weH,
	output[1:0] jklm_select
);

	wire[TYPE_LEN-1:0] type;
	assign type = command[TYPE_LEN+BLOCK_LEN-1:BLOCK_LEN];
	assign data_we = type[0]; // modify if we need more types

	wire[BLOCK_LEN-1:0] block;
	assign block = command[BLOCK_LEN-1:0];

	assign jklm_select = block[1:0]; // last two bits of block select which matrix to store

	// decoder to enable loading of selected block
 	assign {weA, weB, weC, weD, weE, weF, weG, weH} = 
		( block == 3'b000 & type==0) ? 8'b10000000 :
		( block == 3'b001 & type==0) ? 8'b01000000 :
		( block == 3'b010 & type==0) ? 8'b00100000 :
		( block == 3'b011 & type==0) ? 8'b00010000 :
		( block == 3'b100 & type==0) ? 8'b00001000 :
		( block == 3'b101 & type==0) ? 8'b00000100 :
		( block == 3'b110 & type==0) ? 8'b00000010 :
		( block == 3'b111 & type==0) ? 8'b00000001 :
					8'b00000000;
endmodule
