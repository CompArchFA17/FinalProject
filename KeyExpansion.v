`include "SBoxLookup.v"
`include "RConLookup.v"

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

BigXOR8b bxor(outarray[31:24], interimarray2[31:24], rconval);


endmodule


module BigXOR8b(
input [7:0] V,
input [7:0] W,
output [7:0] Z
);

assign Z = V^W;

endmodule
