//`include "SBoxLookup.v"
`include "RConLookup.v"

module KeyExp128(
input [127:0] in,
input [7:0] iterate,
output [127:0] out
);
genvar j;
generate

for (j = 1; j < 5; j = j+1) begin
	KeyExpansion column(in[((32*j)-1):(32*(j-1))], iterate, out[((32*j)-1):(32*(j-1))]);
end

endgenerate

endmodule


module KeyExpansion(
input [31:0] inarray,
input [7:0] iterate, //iteration number, make it binary!
output [31:0] outarray
);

wire [31:0] interimarray;
wire [31:0] interimarray2;
wire [7:0] rconval;

wire [7:0] LSB;
wire [23:0] MSB;
assign LSB = inarray[31:24];
assign MSB = inarray[23:0];

assign interimarray = {MSB, LSB}; // rotate

RConLookup lookupr(iterate, rconval); // get rconval

genvar i; 
generate
for (i = 1; i < 5; i = i + 1) begin
	SBoxLookup assignv(interimarray[((8*i)-1):(8*(i-1))], interimarray2[((8*i)-1):(8*(i-1))]);

end
endgenerate

reg [23:0] zeros = 24'b0;

BigXOR8b bxor(interimarray2[31:24], rconval, outarray[31:24]);
BigXOR24b bxor24(interimarray2[23:0], zeros, outarray[23:0]);

endmodule

module testKE();

reg [31:0] inarray;
reg[7:0] iterate;
wire [31:0] outarray;

KeyExpansion key(inarray, iterate, outarray);

initial begin

inarray = 32'b00101011011111100001010100010110; iterate = 8'b1000; #40
$display("%b | %b ", outarray, inarray);
end

endmodule


module BigXOR8b(
input [7:0] V,
input [7:0] W,
output [7:0] Z
);

assign Z = V^W;

endmodule

module BigXOR24b(
input [23:0] V,
input [23:0] W,
output [23:0] Z
);

assign Z = V^W;

endmodule

