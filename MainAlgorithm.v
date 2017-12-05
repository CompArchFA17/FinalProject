`include "AddRoundKey.v"
//`include "SubBytes.v"
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


genvar i;
generate
	for (i = i; i < 10; i = i + 1) begin
		AddRoundKey ARKtest(RoundKey, StateMatrix, ARKOut);  
		SubBytes SBtest(ARKOut, SBOut);
	end
endgenerate
//always @(posedge clk) begin



	//counter = counter + 1;
	
	// Key Expansion Algorithm goes here
	//KeyExpansionAlgorithm //outputs new roundkey for this counter. Might need to initialize first roundkey as the secretkey. 
	/*
	if (counter > 0 && counter < 10) begin
		state <= MainRounds;
	end
	
	if (counter == 10) begin
		state <= FinalRound;
	end
	


case(state)

	MainRounds: begin
		// if we do all these things at once, will they all happen at once (in a bad way)?
		AddRoundKey ARKtest(RoundKey, StateMatrix, ARKOut);   
		//SubBytes SB();
		//ShiftRows
		//MixColumns
	
	end

	FinalRound: begin
		//AddRoundKey // do this with round key for this round
		//SubBytes
		//ShiftRows
	end
	
endcase*/

//end 
endmodule

