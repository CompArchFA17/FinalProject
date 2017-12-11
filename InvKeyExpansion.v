//`include "KeyExpansion.v"
//`include "InvSBoxLookup.v"


module InvKeyExp128(
input [127:0] in,
input [7:0] iterate,
output [127:0] out
);
genvar j;
generate

for (j = 1; j < 5; j = j+1) begin
	InvKeyExpansion column(in[((32*j)-1):(32*(j-1))], iterate, out[((32*j)-1):(32*(j-1))]);
end

endgenerate

endmodule


module InvKeyExpansion(
input [31:0] BiggerKey,
input [7:0] iterate, //iteration number, make it binary!
output [31:0] SmallerKey
);

wire [31:0] interimarray;
wire [31:0] interimarray2;
wire [7:0] rconval;

wire [7:0] LSB;

wire [23:0] MSB;
reg [23:0] zeros = 24'b0;

RConLookup lookupr(iterate, rconval); // get rconval

BigXOR8b xormsb(BiggerKey[31:24], rconval, interimarray[31:24]);
BigXOR24b xorlsb(BiggerKey[23:0], zeros, interimarray[23:0]);


genvar i; 
generate
for (i = 1; i < 5; i = i + 1) begin
	InvSBoxLookup assignv(interimarray[((8*i)-1):(8*(i-1))], interimarray2[((8*i)-1):(8*(i-1))]);

end
endgenerate

assign LSB = interimarray2[31:8];
assign MSB = interimarray2[7:0];

assign SmallerKey = {MSB, LSB};





endmodule
