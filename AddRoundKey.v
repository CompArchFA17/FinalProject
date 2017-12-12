// it actually makes no sense to use macros on ARK, so we won't!
//`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]
//`define ROUNDKEY(r,c) keyarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]
//`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module AddRoundKey(
// each byte (entry) of the state is combined with a block of the round key using bitwise xor
input [127:0] inarray,
input [127:0] keyarray,
output [127:0] outarray
);

//parameter dimension = 4;

genvar entry;
generate
	for (entry = 0; entry < 128; entry = entry+1) begin
			xor(outarray[entry], inarray[entry], keyarray[entry]);
	end
endgenerate


endmodule

/*
module testARK();

reg [127:0] rk;
reg [127:0] s;
wire [127:0] ao;

AddRoundKey test1(rk, s, ao);

initial begin

$display("AOut | RK | S");
rk = 128'b00001011000011111010110010011001000010110000111110101100100110010000101100001111101011001001100101101100000011111010110011001001; s = 128'b00011111010010011110101000101000000111110100100101011010010001000001111100110010111010100100010000111101010010011110101000010100; #20
$display("%b ", ao);



end

endmodule*/ 
