`define TopByte(c) inarray[((c-1)*32+31):(c-1)*32+24]
`define SecByte(c) inarray[((c-1)*32+23):(c-1)*32+16]
`define ThiByte(c) inarray[((c-1)*32+15):(c-1)*32+8]
`define FouByte(c) inarray[((c-1)*32+7):(c-1)*32]


//`include "MixColumns.v"
module InvMixColumns(
input [127:0] inarray, 
output [127:0] outarray
);

parameter length = 32;

wire [length - 1:0] d0b0OUT;
wire [length - 1:0] d0b1OUT;
wire [length - 1:0] d0b2OUT;
wire [length - 1:0] d0b3OUT;
wire [length - 1:0] d0OUT;

wire [length - 1:0] d1b0OUT;
wire [length - 1:0] d1b1OUT;
wire [length - 1:0] d1b2OUT;
wire [length - 1:0] d1b3OUT;
wire [length - 1:0] d1OUT;

wire [length - 1:0] d2b0OUT;
wire [length - 1:0] d2b1OUT;
wire [length - 1:0] d2b2OUT;
wire [length - 1:0] d2b3OUT;
wire [length - 1:0] d2OUT;

wire [length - 1:0] d3b0OUT;
wire [length - 1:0] d3b1OUT;
wire [length - 1:0] d3b2OUT;
wire [length - 1:0] d3b3OUT;
wire [length - 1:0] d3OUT;


genvar c;
generate 
	for (c = 1; c < 5; c = c + 1) begin

	Multe d0b0(`TopByte(c), d0b0OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multb d0b1(`SecByte(c), d0b1OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multd d0b2(`ThiByte(c), d0b2OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Mult9 d0b3(`FouByte(c), d0b3OUT[(32-(8*(c-1))-1):(32-8*c)]);
	BigXOR d0xor(d0b0OUT[(32-(8*(c-1))-1):(32-8*c)], d0b1OUT[(32-(8*(c-1))-1):(32-8*c)], d0b2OUT[(32-(8*(c-1))-1):(32-8*c)], d0b3OUT[(32-(8*(c-1))-1):(32-8*c)], d0OUT[(32-(8*(c-1))-1):(32-8*c)]);
	
	Mult9 d1b0(`TopByte(c), d1b0OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multe d1b1(`SecByte(c), d1b1OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multb d1b2(`ThiByte(c), d1b2OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multd d1b3(`FouByte(c), d1b3OUT[(32-(8*(c-1))-1):(32-8*c)]);
	BigXOR d1xor(d1b0OUT[(32-(8*(c-1))-1):(32-8*c)], d1b1OUT[(32-(8*(c-1))-1):(32-8*c)], d1b2OUT[(32-(8*(c-1))-1):(32-8*c)], d1b3OUT[(32-(8*(c-1))-1):(32-8*c)], d1OUT[(32-(8*(c-1))-1):(32-8*c)]);
	
	Multd d2b0(`TopByte(c), d2b0OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Mult9 d2b1(`SecByte(c), d2b1OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multe d2b2(`ThiByte(c), d2b2OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multb d2b3(`FouByte(c), d2b3OUT[(32-(8*(c-1))-1):(32-8*c)]);
	BigXOR d2xor(d2b0OUT[(32-(8*(c-1))-1):(32-8*c)], d2b1OUT[(32-(8*(c-1))-1):(32-8*c)], d2b2OUT[(32-(8*(c-1))-1):(32-8*c)], d2b3OUT[(32-(8*(c-1))-1):(32-8*c)], d2OUT[(32-(8*(c-1))-1):(32-8*c)]);
	
	Multb d3b0(`TopByte(c), d3b0OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multd d3b1(`SecByte(c), d3b1OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Mult9 d3b2(`ThiByte(c), d3b2OUT[(32-(8*(c-1))-1):(32-8*c)]);
	Multe d3b3(`FouByte(c), d3b3OUT[(32-(8*(c-1))-1):(32-8*c)]);
	BigXOR d3xor(d3b0OUT[(32-(8*(c-1))-1):(32-8*c)], d3b1OUT[(32-(8*(c-1))-1):(32-8*c)], d3b2OUT[(32-(8*(c-1))-1):(32-8*c)], d3b3OUT[(32-(8*(c-1))-1):(32-8*c)], d3OUT[(32-(8*(c-1))-1):(32-8*c)]);

	assign outarray[(32*(c-1)+31):(32*(c-1))] = {d0OUT[(32-(8*(c-1))-1):(32-8*c)], d1OUT[(32-(8*(c-1))-1):(32-8*c)],d2OUT[(32-(8*(c-1))-1):(32-8*c)], d3OUT[(32-(8*(c-1))-1):(32-8*c)]};
	end
endgenerate

endmodule


module Mult9(
input [7:0] inmult9,
output [7:0] outmult9
);

wire [7:0] mult2;
wire [7:0] mult4;
wire [7:0] mult8;

Mult2 t1(inmult9, mult2);
Mult2 t2(mult2, mult4);
Mult2 t3(mult4, mult8);
XOR8b t4(mult8, inmult9, outmult9);

endmodule

module Multb(
input [7:0] inmultb,
output [7:0] outmultb
);

wire [7:0] mult2;
wire [7:0] mult4;
wire [7:0] m4xor;
wire [7:0] m8xor;

Mult2 b1(inmultb, mult2);
Mult2 b2(mult2, mult4);
XOR8b b3(mult4, inmultb, m4xor);
Mult2 b4(m4xor, m8xor);
XOR8b b5(m8xor, inmultb, outmultb);

endmodule

module Multd(
input [7:0] inmultd,
output [7:0] outmultd
);
wire [7:0] mult2;
wire [7:0] m2xor;
wire [7:0] m4xor;
wire [7:0] m8xor;

Mult2 d1(inmultd, mult2);
XOR8b d2(mult2, inmultd, m2xor);
Mult2 d3(m2xor, m4xor);
Mult2 d4(m4xor, m8xor);
XOR8b d5(m8xor, inmultd, outmultd);

endmodule

module Multe(
input [7:0] inmulte,
output [7:0] outmulte
);
wire [7:0] mult2;
wire [7:0] m2xor;
wire [7:0] m4xor;
wire [7:0] m4xxor;

Mult2 e1(inmulte, mult2);
XOR8b e2(mult2, inmulte, m2xor);
Mult2 e3(m2xor, m4xor);
XOR8b e4(m4xor, inmulte, m4xxor);
Mult2 e5(m4xxor, outmulte);

endmodule

module XOR8b(
input [7:0] V,
input [7:0] W,
output [7:0] Z
);

assign Z = V^W;

endmodule

/*
module testInvMix();

reg [127:0] inmix;
wire [127:0] outmix;

InvMixColumns mix(inmix, outmix);


initial begin

inmix = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100010001000000110011101000111
;  #200
$display("inverse output");
$display("%b", outmix);


end


endmodule

*/
