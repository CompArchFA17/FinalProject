`include "prog_memory.v"
`include "fsm.v"

/*
The controller runs through commands from program memory, changing commands
every clock cycle, and outputs the control signals for the various pieces
of the multiplier

inputs: clk
outputs: same as fsm
*/

module controller
#(
	parameter CMD_WIDTH = 5,
	parameter ADDR_WIDTH = 32
)
(
	input clk,
	output data_we,
	output weA, weB, weC, weD, weE, weF, weG, weH,
	output[1:0] jklm_select,
	output next_row, column
);
	
	wire[CMD_WIDTH-1:0] cmd;
	reg [ADDR_WIDTH-1:0] prog_count;
	
	// run program counter
	initial prog_count = 0;
	always @(posedge clk) begin
		prog_count = prog_count + 1;
	end
	
	prog_memory prog_mem (clk, cmd, prog_count);
	
	fsm state_machine (cmd, data_we, weA, weB, weC, weD, weE, weF, weG, weH,
				jklm_select, next_row, column);

endmodule
