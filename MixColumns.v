// unclear if we need macros here either, since we're not actually moving things around.

`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module MixColumns(
input [31:0] inarray, // [7:0] is a two column, four row matrix
input clk,
output reg [31:0] outarray
);
reg [1:0] counter = 2'b0;

always @(posedge clk) begin

genvar col, row;
generate



endgenerate

end

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

module Mult3(
input[7:0] inmult3,
input clk,
output [7:0] outmult3
);
wire [7:0] shiftedin3;

Mult2 mult2(inmult3, clk, shiftedin3);
assign outmult3 = shiftedin3^inmult3;

endmodule

module BigXOR(
input [7:0] V,
input [7:0] W,
input [7:0] X,
input [7:0] Y,
output [7:0] Z
);

wire [7:0] A;
wire [7:0] B;

assign A = V^W;
assign B = X^Y;
assign Z = A^B;

endmodule

module testMixCol();

reg [7:0] inm2;
reg clk;
wire [7:0] outm2;
reg [7:0] inm3;
wire [7:0] outm3;

Mult2 multiply(inm2, clk, outm2);
Mult3 multiply3(inm3, clk, outm3);

reg [7:0] A;
reg [7:0] B;
reg [7:0] C;
reg [7:0] D;
wire [7:0] Z;

BigXOR bigx(A, B, C, D, Z);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock  

initial begin
inm2 = 8'b11010100; #40
$display("%b | %b ", outm2, inm2);
inm3 = 8'b10111111; #60
$display("%b | %b", outm3, inm3);
A = 8'b10101010; B = 8'b01010101; C = 8'b00010001; D = 8'b10001000; #40
$display("%b", Z);

$finish;
end

endmodule










