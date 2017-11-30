// it actually makes no sense to use macros on ARK, so we won't!
`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]
`define ROUNDKEY(r,c) keyarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]
`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module AddRoundKey(
// each byte (entry) of the state is combined with a block of the round key using bitwise xor
input [3:0][1:0] inarray,
input [3:0][1:0] keyarray,
output [3:0][1:0] outarray
);

parameter dimension = 2;

genvar r, c;
generate
	for (r = 0; r < 4; r = r+1) begin
		for (c = 0; c < 2; c = c + 1) begin		
			xor(outarray[r][c], inarray[r][c], keyarray[r][c]);
		end
	end
endgenerate


endmodule

module testARK();

reg [3:0][1:0] rk;
reg [3:0][1:0] s;
wire [3:0][1:0] ao;

AddRoundKey test1(rk, s, ao);

initial begin

$display("AOut | RK | S");
rk = 8'b00011111; s = 8'b11111011; #20
$display("%b | %b | %b", ao, rk, s);



end

endmodule
