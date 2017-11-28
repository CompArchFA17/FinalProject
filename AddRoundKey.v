module AddRoundKey(

input [4:4] RoundKey; 
input [4:4] State;
output [4:4] ARKOut;

);


// each byte (entry) of the state is combined with a block of the round key using bitwise xor

	for (column = 0; column < 4; column = column + 1) begin
		
		for (row = 0; row < 4; row = row + 1) begin
			
			xor(ARKOut(row, column), RoundKey(row, column), State(row, column)); // this almost definitely won't work
			
		end
		
	end

endmodule

