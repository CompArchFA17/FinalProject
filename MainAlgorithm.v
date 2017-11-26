`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"

module MainAlgorithm(

reg [4:4] SecretKey; // All of these things should be 4x4 matrices but I have no idea how to do that so I put [4:4]. Alas!
reg [4:4] PlainText;
wire[4:4] CipherText;

);

reg [2:0] command;
localparam KeyExpansion = 3'b000;
localparam MainRounds = 3'b010;
localparam FinalRound = 3'b011;

reg [4:0] counter = 4'b0;
reg[4:4] StateMatrix;
wire [4:4] ARKOut;

initial begin
	StateMatrix = PlainText; // initialize StateMatrix to PlainText. this is definitely not how it will actually occur
end

// might want a clock. unclear.
always @(*) begin

	counter = counter + 1;
	
	// Key Expansion Algorithm goes here
	KeyExpansionAlgorithm //outputs new roundkey for this counter. Might need to initialize first roundkey as the secretkey. 
	
	if (counter > 0 && counter < 10) begin
		command <= MainRounds;
	end
	
	if (counter == 10) begin
		command <= FinalRound;
	end
	
end

case (command)

	MainRounds: begin
		// if we do all these things at once, will they all happen at once (in a bad way)?
		AddRoundKey ARK(RoundKey(counter), StateMatrix(counter), ARKOut(counter));   // do this with round key for this round // takes in RoundKey, State, outputs ARKOut // Also concerned about using 
		SubBytes SB();
		ShiftRows
		MixColumns
	
	end

	FinalRound: begin
		AddRoundKey // do this with round key for this round
		SubBytes
		ShiftRows
	end
	
endcase

endmodule

