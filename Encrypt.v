`include "AddRoundKey.v"
`include "SubBytes.v"
`include "MixColumns.v"
`include "ShiftRows.v"
`include "KeyExpansion.v"

module Encrypt(
input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText

);

reg [127:0] StateMatrix;
wire [127:0] ARKOut;
reg [127:0] RoundKey;
wire [127:0] SBOut;
wire [127:0] SROut;
wire [127:0] MCOut;

reg [5:0] counter = 5'b0;
/*
assign StateMatrix = PlainText;
assign RoundKey = SecretKey;
*/
always @ (posedge clk) begin

	counter = counter + 1;
	
	if (counter == 0) begin
		StateMatrix <= PlainText;
		RoundKey <= SecretKey;
	end

	else if (counter > 0 && counter < 10) begin
		KeyExp128 Keytest(RoundKey, counter, MCOut); 
		
		AddRoundKey ARKtest(RoundKey, StateMatrix, ARKOut);
		
		SubBytes SBtest(ARKOut, SBOut);
		
		ShiftRows SRtest(SBOut, SROut);
		
		MixColumns MCtest(SROut, MCOut); 
	end
	else if (counter == 11) begin
	/*
		KeyExp128 Keytest(RoundKey, counter, MCOut); 
		
		AddRoundKey ARKtest(RoundKey, StateMatrix, ARKOut);
		
		SubBytes SBtest(ARKOut, SBOut);
		
		ShiftRows SRtest(SBOut, SROut);*/
	end
	else
		counter <= 0;


end

endmodule
