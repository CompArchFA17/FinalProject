module RConLookup(in, out);
input [7:0] in;
output [7:0] out;
reg [7:0] out;

always @(in)
case(in)
8'b1 	: out = 8'b1;
8'b10	: out = 8'b10;
8'b11	: out = 8'b100;
8'b100	: out = 8'b1000;
8'b101	: out = 8'b10000;
8'b110	: out = 8'b100000;
8'b111	: out = 8'b1000000;
8'b1000	: out = 8'b10000000;
8'b1001	: out = 8'b00011011;
8'b1010	: out = 8'b00110110;
endcase

endmodule
