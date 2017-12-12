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


module testARK();

reg [127:0] rk;
reg [127:0] s;
wire [127:0] ao;

AddRoundKey test1(rk, s, ao);

initial begin

$display("AOut | RK | S");
rk = 128'b01100010011000110110001101100011011000100110001101100011011000110110001001100011011000110110001101100010011111000010011001100011  ; s = 128'b00000001000000000000000010111000000000010000000001001000000000000000000100000000000000000000000000000001000111110100010100000000 
; #20
$display("%b ", ao);



end

endmodule
