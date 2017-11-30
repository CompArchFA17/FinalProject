// unclear if we need macros here either, since we're not actually moving things around.

`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module MixColumns(
input [7:0] inarray, // [7:0] is a two column, four row matrix
input clk,
output reg [7:0] outarray
);


always @(posedge clk) begin
// THIS STUFF BELOW IS FALSE
// if row = 1, then do x2 (shift left 1, then xor with 1b)
// if row = 2, then do 3x
// if row = 3, then do x
// if row = 4, then do x
	column = column + 1;
	if (column == 1) begin
		if (row == 1) begin
			X(row, column) <= `STATE(
			`OUT(row, column) <= `
		end
	end

end



endmodule
