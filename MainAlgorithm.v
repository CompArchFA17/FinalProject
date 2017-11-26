`include "A module that has stuff for main rounds and final round"
module MainAlgorithm(

);

reg [2:0] state;
localparam KeyExpansion = 3'b000;
localparam MainRounds = 3'b010;
localparam FinalRound = 3'b011;

reg [4:0] counter = 4'b0;

// Key Expansion Algorithm goes here


// Next - count. Do 9 rounds. 


// Finally, final round!

always @(*) begin

	counter = counter + 1;
	
	if (counter > 0 && counter < 9) begin
		state <= MainRounds;
	end
	
	if (counter == 9) begin
		state <= FinalRound;
	end
	
end

case (state)

	MainRounds: begin
		
		AddRoundKey // do this with round key for this round
		SubBytes
		Shift Rows
		MixColumns
	
	end

	FinalRound: begin
		AddRoundKey // do this with round key for this round
		SubBytes
		Shift Rows
	end
	
endcase

endmodule

