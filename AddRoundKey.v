// don't actually need this for ARK. Will need for Shift Rows.
`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))];
`define ROUNDKEY(r,c) keyarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))];
`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))];

module AddRoundKey(
// each byte (entry) of the state is combined with a block of the round key using bitwise xor
input [3:0][1:0] inarray,
input [3:0][1:0] keyarray,
output [3:0][1:0] outarray
);

parameter dimension = 2;

genvar i, j;
generate
	for (i = 0; i < 4; i = i+1) begin
		for (j = 0; j < 2; j = j + 1) begin		
			xor(outarray[i][j], inarray[i][j], keyarray[i][j]);
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
