`include "InvSBoxLookup.v" 

module InvSubBytes(
input [127:0] in,
output [127:0] InvSBOut
);

genvar i;
generate
for (i = 1; i < 17; i = i + 1) begin
	InvSBoxLookup assignvalues(in[((8*i)-1):(8*(i-1))], InvSBOut[((8*i)-1):(8*(i-1))]);
end

endgenerate

endmodule
/*
module testInvSubBytes();

reg [127:0] AO;
wire [127:0] SBO;

InvSubBytes testSB(AO, SBO);
		
initial begin
$display("Output | Expect | Input ");
AO = 128'b01100011011000110110001101100011011000110110001101100011011000110110001101100011011000110110001101100011011000110110011101100101 ; #200
$display("%b ",SBO);
end


endmodule*/
