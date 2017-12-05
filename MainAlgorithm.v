`include "AddRoundKey.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "ShiftRows.v"

module MainAlgorithm(

input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText

);

reg [2:0] state;
localparam KeyExpansion = 3'b000;
localparam MainRounds = 3'b010;
localparam FinalRound = 3'b011;

reg [4:0] counter = 4'b0;
wire [127:0] StateMatrix;
wire [127:0] ARKOut;
wire [127:0] RoundKey;
wire [127:0] SBOut;
wire [127:0] SROut;
wire [127:0] MCOut;

//do keyexpansion


genvar i;
generate
	for (i = 1; i < 10; i = i + 1) begin
		AddRoundKey ARKtest(RoundKey, StateMatrix, ARKOut);  
		SubBytes SBtest(ARKOut, SBOut);
		ShiftRows SRtest(SBOut, clk, SROut);
		MixColumns MCtest(SROut, clk, CipherText);
	end
endgenerate



endmodule


module testMain();
reg [127:0] SecretKey;
reg [127:0] PlainText;
reg clk;
wire [127:0] CipherText;

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock  

initial begin

SecretKey = 128'b1; PlainText = 128'b0; #100
$display("%b", CipherText);

end

endmodule








