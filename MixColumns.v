// unclear if we need macros here either, since we're not actually moving things around.

module MixColumns(
input [7:0] inarray, // [7:0] is a two column, four row matrix
input clk,
output reg [7:0] outarray
);


// for each column 
// if row = 1, then do x2
// if row = 2, then do 3x
// if row = 3, then do x
// if row = 4, then do x





endmodule
