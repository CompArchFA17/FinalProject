// unclear if we need macros here either, since we're not actually moving things around.

`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module MixColumns(
input [63:0] inarray, // [7:0] is a two column, four row matrix
input clk,
output [63:0] outarray
);
parameter length = 63;

wire [length:0] d0b0OUT;
wire [length:0] d0b1OUT;
wire [length:0] d0b2OUT;
wire [length:0] d0b3OUT;
wire [length:0] d0OUT;

wire [length:0] d1b0OUT;
wire [length:0] d1b1OUT;
wire [length:0] d1b2OUT;
wire [length:0] d1b3OUT;
wire [length:0] d1OUT;

wire [length:0] d2b0OUT;
wire [length:0] d2b1OUT;
wire [length:0] d2b2OUT;
wire [length:0] d2b3OUT;
wire [length:0] d2OUT;

wire [length:0] d3b0OUT;
wire [length:0] d3b1OUT;
wire [length:0] d3b2OUT;
wire [length:0] d3b3OUT;
wire [length:0] d3OUT;

//parameter c = 1;

genvar c;
generate 
	for (c = 1; c < 3; c = c + 1) begin

		
		Mult2 d0b0(inarray[((c-1)*32+31):(c-1)*32+24], clk, d0b0OUT);
		
		Mult3 d0b1(inarray[((c-1)*32+23):(c-1)*32+16], clk, d0b1OUT);
		
		assign d0b2OUT = inarray[((c-1)*32+15):(c-1)*32+8];
		
		assign d0b3OUT = inarray[(((c-1)*32)+7):((c-1)*32)];
		
		BigXOR d0xor(d0b0OUT, d0b1OUT, d0b2OUT, d0b3OUT, d0OUT);

		assign d1b0OUT = inarray[((c-1)*32+31):(c-1)*32+24];
		Mult2 d1b1(inarray[((c-1)*32+23):(c-1)*32+16], clk, d1b1OUT);
		Mult3 d1b2(inarray[((c-1)*32+15):(c-1)*32+8], clk, d1b2OUT);
		assign d1b3OUT = inarray[((c-1)*32+7):(c-1)*32];
		BigXOR d1xor(d1b0OUT, d1b1OUT, d1b2OUT, d1b3OUT, d1OUT);
		
		assign d2b0OUT = inarray[((c-1)*32+31):(c-1)*32+24];
		assign d2b1OUT = inarray[((c-1)*32+23):(c-1)*32+16];
		Mult2 d2b2(inarray[((c-1)*32+15):(c-1)*32+8], clk, d2b2OUT;
		Mult3 d2b3(inarray[((c-1)*32+7):(c-1)*32], clk, d2b3OUT);
		BigXOR d2xor(d2b0OUT, d2b1OUT, d2b2OUT, d2b3OUT, d2OUT);
		
		Mult3 d3b0(inarray[((c-1)*32+31):(c-1)*32+24], clk, d3b0OUT);
		assign d3b1OUT = inarray[((c-1)*32+23):(c-1)*32+16];
		assign d3b2OUT = inarray[((c-1)*32+15):(c-1)*32+8];
		Mult2 d3b3(inarray[((c-1)*32+7):(c-1)*32], clk, d3b3OUT);
		BigXOR d3xor(d3b0OUT, d3b1OUT, d3b2OUT, d3b3OUT, d3OUT);
		
		//assign d0d1 = {d0OUT, d1OUT};
		//assign d2d3 = {d2OUT, d3OUT};
		
		assign outarray[(32*(c-1)+31):(32*(c-1))] = {d0d1, d2d3};
		//assign outarray = d1b1OUT;
	end
	
endgenerate

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

reg [63:0] inmix;
wire [63:0] outmix;

MixColumns mix(inmix, clk, outmix);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock  

initial begin
inm2 = 8'b10111111; #40
$display("%b | %b ", outm2, inm2);
inm3 = 8'b00000000; #60
$display("%b | %b", outm3, inm3);
A = 8'b10101010; B = 8'b01010101; C = 8'b00010001; D = 8'b10001000; #40
$display("%b", Z);
inmix = 64'b1101010010111111000000000000000010111111110101000000000000000000;  #20000
//inmix = 8'b11010100; #2000

$display("%b", outmix);

$finish;
end

endmodule










