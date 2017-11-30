// unclear if we need macros here either, since we're not actually moving things around.

`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module MixColumns(
input [7:0] inarray, // [7:0] is a two column, four row matrix
input clk,
output reg [7:0] outarray
);
reg [1:0] counter = 2'b0;

endmodule

module Mult2(
input [7:0] inmult2,
input clk,
output reg [7:0] outmult2
);

reg isone;
reg [7:0] shiftedin;
reg [7:0] oneB = 8'b00011011;
reg [1:0] counter = 2'b0;

always @(posedge clk) begin
counter = counter + 1;

	if (counter == 1) begin
		isone <= inmult2[7];
		shiftedin <= {inmult2[6:0], 1'b0};
	end
	else if (counter == 2) begin
		if (isone == 1) begin
			outmult2 <= shiftedin^oneB;
			//xor(outmult2, 8'b00001111, 8'b11110000);
		end
		else
			outmult2 <= shiftedin;
	end
	else if (counter == 3)
		counter <= 0;
end

endmodule

module testMixCol();

reg [7:0] inm2;
reg clk;
wire [7:0] outm2;

Mult2 multiply(inm2, clk, outm2);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock  

initial begin
inm2 = 8'b11010100; #40
$display("%b | %b ", outm2, inm2);

$finish;
end

endmodule










