module AddRoundKey(

input [1:0][3:0] RoundKey,
input [1:0][3:0] State,
output [1:0][3:0] ARKOut

);


// each byte (entry) of the state is combined with a block of the round key using bitwise xor
	genvar i, j; 
	generate 
	
	for (i = 0; i < 4; i = i + 1) begin
		
		for (j = 0; j < 2; j = j + 1) begin
			
			xor(ARKOut[j][i], RoundKey[j][i], State[j][i]); // this almost definitely won't work
			
		end
		
	end
	endgenerate

endmodule


module testARK();


reg [1:0][3:0] rk;
reg [1:0][3:0] s;
wire [1:0][3:0] ao;

AddRoundKey test1(rk, s, ao);

initial begin

$display("AOut | RK | S");
rk = 4'b0101; s = 4'b0100; #20
$display("%b | %b | %b", ao, rk, s);


end

endmodule
