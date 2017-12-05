module SBoxLookup(in, out); 
input [7:0] in;
output [7:0] out;
reg [7:0] out;
//wire [7:0] in;

always @(in)
case(in)
		// source fopr s box is http://www.samiam.org/s-box.html 
		// https://alteraforum.com/forum/showthread.php?t=41183 also useful
	8'b000 		: out = 01100011; //63		// did Logan count in binary correctly? 
	8'b001 		: out = 01111100; //7c				// the world may never know 
	8'b010 		: out = 01110111; //77 
	8'b011 		: out = 01111011; //7b
	8'b100 		: out = 11110010; //f2
	8'b101 		: out = 01101011; //6b
	8'b110 		: out = 01101111; //6f
	8'b111 		: out = 11000101; //c5
	8'b1000 	: out = 00110000; //30
	8'b1001 	: out = 00000001; //01
	8'b1010 	: out = 01100111; //67
	8'b1011 	: out = 00101011; //2b
	8'b1100 	: out = 11111110; //fe
	8'b1101 	: out = 11010111; //d7
	8'b1110 	: out = 10101011; //ab
	8'b1111 	: out = 01110110; //76     // end of first row 
	
	8'b10000 	: out = 11001010; // ca
	8'b10001 	: out = 10000010; // 82
	8'b10010 	: out = 11001001; // c9
	8'b10011 	: out = 01111101; // 7d
	8'b10100 	: out = 11111010; // fa
	8'b10101 	: out = 01011001; // 59
	8'b10110 	: out = 01000111; // 47
	8'b10111 	: out = 11110000; // f0
	8'b11000 	: out = 10101101; // ad
	8'b11001 	: out = 11010100; // d4
	8'b11010 	: out = 10100010; // a2
	8'b11011 	: out = 10101111; // af
	8'b11100 	: out = 10011100; // 9c
	8'b11101 	: out = 10100100; // a4
	8'b11110 	: out = 01110010; // 72
	8'b11111 	: out = 11000000; // c0		// end of second row 
	
	
	8'b100000 	: out = 10110111; // b7
	8'b100001 	: out = 11111101; // fd
	8'b100010 	: out = 10010011; // 93
	8'b100011 	: out = 00100110; // 26
	8'b100100 	: out = 00110110; // 36
	8'b100101 	: out = 00111111; // 3f
	8'b100110 	: out = 11110111; // f7
	8'b100111 	: out = 11001100; // cc
	8'b101000 	: out = 00110100; // 34
	8'b101001 	: out = 10100101; // a5
	8'b101010 	: out = 11100101; // e5
	8'b101011 	: out = 11110001; // f1
	8'b101100 	: out = 01110001; // 71
	8'b101101 	: out = 11011000; // d8
	8'b101110 	: out = 00110001; // 31
	8'b101111 	: out = 00010101; // 15		// end of third row 
	
	
	8'b110000 	: out = 00000100; // 04
	8'b110001 	: out = 11000111; // c7
	8'b110010 	: out = 00100011; // 23
	8'b110011 	: out = 11000011; // c3
	8'b110100 	: out = 00011000; // 18
	8'b110101 	: out = 10010110; // 96
	8'b110110 	: out = 00000101; // 05
	8'b110111 	: out = 10011010; // 9a
	8'b111000 	: out = 00000111; // 07
	8'b111001 	: out = 00010010; // 12
	8'b111010 	: out = 10000000; // 80
	8'b111011 	: out = 11100010; // e2
	8'b111100 	: out = 11101011; // eb
	8'b111101 	: out = 00100111; // 27
	8'b111110 	: out = 10110010; // b2
	8'b111111 	: out = 01110101; // 75// 4th row
	
	
	8'b1000000 	: out = 00001001; // 09
	8'b1000001 	: out = 10000011; // 83
	8'b1000010 	: out = 00101100; // 2c
	8'b1000011 	: out = 00011010; // 1a
	8'b1000100 	: out = 00011011; // 1b
	8'b1000101 	: out = 01101110; // 6e
	8'b1000110 	: out = 01011010; // 5a
	8'b1000111 	: out = 10100000; // a0
	8'b1001000 	: out = 01010010; // 52
	8'b1001001 	: out = 00111011; // 3b
	8'b1001010 	: out = 11010110; // d6
	8'b1001011 	: out = 10110011; // b3
	8'b1001100 	: out = 00101001; // 29
	8'b1001101 	: out = 11100011; // e3
	8'b1001110 	: out = 00101111; // 2f
	8'b1001111 	: out = 10000100; // 84		/5th row
	
	
	8'b1010000 	: out = 01010011; // 53
	8'b1010001 	: out = 11010001; // d1
	8'b1010010 	: out = 00000000; // 00
	8'b1010011 	: out = 11101101; // ed
	8'b1010100 	: out = 00100000; // 20
	8'b1010101 	: out = 11111100; // fc
	8'b1010110 	: out = 10110001; // b1
	8'b1010111 	: out = 01011011; // 5b
	8'b1011000 	: out = 01101010; // 6a
	8'b1011001 	: out = 11001011; // cb
	8'b1011010 	: out = 10111110; // be
	8'b1011011 	: out = 00111001; // 39
	8'b1011100 	: out = 01001010; // 4a
	8'b1011101 	: out = 01001100; // 4c
	8'b1011110 	: out = 01011000; // 58
	8'b1011111 	: out = 11001111; // cf		// 6th row 
	
	
	8'b1100000 	: out = 11010000; // d0
	8'b1100001 	: out = 11101111; // ef
	8'b1100010 	: out = 10101010; // aa
	8'b1100011 	: out = 11111011; // fb
	8'b1100100 	: out = 01000011; // 43
	8'b1100101 	: out = 01001101; // 4d
	8'b1100110 	: out = 00110011; // 33
	8'b1100111 	: out = 10000101; // 85
	8'b1101000 	: out = 01000101; // 45
	8'b1101001 	: out = 11111001; // f9
	8'b1101010 	: out = 00000010; // 02
	8'b1101011 	: out = 01111111; // 7f
	8'b1101100 	: out = 01010000; // 50
	8'b1101101 	: out = 00111100; // 3c
	8'b1101110 	: out = 10011111; // 9f
	8'b1101111 	: out = 10101000; // a8		/7th row 
	
	
	8'b1110000 	: out = 01010001; // 51
	8'b1110001 	: out = 10100011; // a3
	8'b1110010 	: out = 01000000; // 40
	8'b1110011 	: out = 10001111; // 8f
	8'b1110100 	: out = 10010010; // 92
	8'b1110101 	: out = 10011101; // 9d
	8'b1110110 	: out = 00111000; // 38
	8'b1110111 	: out = 11110101; // f5
	8'b1111000 	: out = 10111100; // bc
	8'b1111001 	: out = 10110110; // b6
	8'b1111010 	: out = 11011010; // da
	8'b1111011 	: out = 00100001; // 21
	8'b1111100 	: out = 00010000; // 10
	8'b1111101 	: out = 11111111; // ff
	8'b1111110 	: out = 11110011; // f3
	8'b1111111 	: out = 11010010; // d2		//8th row 
		
	8'b10000000	: out = 11001101; // cd
	8'b10000001	: out = 00001100; // 0c
	8'b10000010	: out = 00010011; // 13
	8'b10000011	: out = 11101100; // ec
	8'b10000100	: out = 01011111; // 5f
	8'b10000101	: out = 10010111; // 97
	8'b10000110	: out = 01000100; // 44
	8'b10000111	: out = 00010111; // 17
	8'b10001000	: out = 11000100; // c4
	8'b10001001	: out = 10100111; // a7
	8'b10001010	: out = 01111110; // 7e
	8'b10001011	: out = 00111101; // 3d
	8'b10001100	: out = 01100100; // 64
	8'b10001101	: out = 01011101; // 5d
	8'b10001110	: out = 00011001; // 19
	8'b10001111	: out = 01110011; // 73		// 9th row 
	
	
	8'b10010000	: out = 01100000; // 60
	8'b10010001	: out = 10000001; // 81
	8'b10010010	: out = 01001111; // 4f
	8'b10010011	: out = 11011100; // dc
	8'b10010100	: out = 00100010; // 22
	8'b10010101	: out = 00101010; // 2a
	8'b10010110	: out = 10010000; // 90
	8'b10010111	: out = 10001000; // 88
	8'b10011000	: out = 01000110; // 46
	8'b10011001	: out = 11101110; // ee
	8'b10011010	: out = 10111000; // b8
	8'b10011011	: out = 00010100; // 14
	8'b10011100	: out = 11011110; // de
	8'b10011101	: out = 01011110; // 5e
	8'b10011110	: out = 00001011; // 0b
	8'b10111111	: out = 11011011; // db // 10th row
	
	8'b10100000	: out = 11100000; // e0
	8'b10100001	: out = 00110010; // 32
	8'b10100010	: out = 00111010; // 3a
	8'b10100011	: out = 00001010; // 0a
	8'b10100100	: out = 01001001; // 49
	8'b10100101	: out = 00000110; // 06
	8'b10100110	: out = 00100100; // 24
	8'b10100111	: out = 01011100; // 5c
	8'b10101000	: out = 11000010; // c2
	8'b10101001	: out = 11010011; // d3
	8'b10101010	: out = 10101100; // ac
	8'b10101011	: out = 01100010; // 62
	8'b10101100	: out = 10010001; // 91
	8'b10101101	: out = 10010101; // 95
	8'b10101110	: out = 11100100; // e4
	8'b10101111	: out = 01111001; // 79 // 11th row
	
	8'b10110000	: out = 11100111; // e7
	8'b10110001	: out = 11001000; // c8
	8'b10110010	: out = 00110111; // 37
	8'b10110011	: out = 01101101; // 6d
	8'b10110100	: out = 10001101; // 8d
	8'b10110101	: out = 11010101; // d5
	8'b10110110	: out = 01001110; // 4e
	8'b10110111	: out = 10101001; // a9
	8'b10111000	: out = 01101100; // 6c
	8'b10111001	: out = 01010110; // 56
	8'b10111010	: out = 11110100; // f4
	8'b10111011	: out = 11101010; // ea
	8'b10111100 : out = 01100101; // 65
	8'b10111101	: out = 01111010; // 7a
	8'b10111110	: out = 10101110; // ae
	8'b10111111	: out = 00001000; // 08 // 12th row	
	
	8'b11000000	: out = 10111010; // ba
	8'b11000001	: out = 01111000; // 78
	8'b11000010	: out = 00100101; // 25
	8'b11000011	: out = 00101110; // 2e
	8'b11000100	: out = 00011100; // 1c
	8'b11000101	: out = 10100110; // a6
	8'b11000110	: out = 10110100; // b4
	8'b11000111	: out = 11000110; // c6
	8'b11001000	: out = 11101000; // e8
	8'b11001001	: out = 11011101; // dd
	8'b11001010	: out = 01110100; // 74
	8'b11001011	: out = 00011111; // 1f
	8'b11001100 : out = 01001011; // 4b
	8'b11001101	: out = 10111101; // bd
	8'b11001110	: out = 10001011; // 8b
	8'b11001111	: out = 10001010; // 8a // 13th row	
	
	
	8'b11010000	: out = 01110000; // 70
	8'b11010001	: out = 00111110; // 3e
	8'b11010010	: out = 10110101; // b5
	8'b11010011	: out = 01100110; // 66
	8'b11010100	: out = 01001000; // 48
	8'b11010101	: out = 00000011; // 03
	8'b11010110	: out = 11110110; // f6
	8'b11010111	: out = 00001110; // 0e
	8'b11011000	: out = 01100001; // 61
	8'b11011001	: out = 00110101; // 35
	8'b11011010	: out = 01010111; // 57
	8'b11011011	: out = 10111001; // b9
	8'b11011100 : out = 10000110; // 86
	8'b11011101	: out = 11000001; // c1
	8'b11011110	: out = 00011101; // 1d
	8'b11011111	: out = 10011110; // 9e // 14th row	
	
	8'b11100000	: out = 11100001; // e1
	8'b11100001	: out = 11111000; // f8
	8'b11100010	: out = 10011000; // 98
	8'b11100011	: out = 00010001; // 11
	8'b11100100	: out = 01101001; // 69
	8'b11100101	: out = 11011001; // d9
	8'b11100110	: out = 10001110; // 8e
	8'b11100111	: out = 10010100; // 94
	8'b11101000	: out = 10011011; // 9b
	8'b11101001	: out = 00011110; // 1e
	8'b11101010	: out = 10000111; // 87
	8'b11101011	: out = 11101001; // e9
	8'b11101100 : out = 11001110; // ce
	8'b11101101	: out = 01010101; // 55
	8'b11101110	: out = 00101000; // 28
	8'b11101111	: out = 11011111; // df // 15th row	
	
	8'b11110000	: out = 10001100; // 8c
	8'b11110001	: out = 10100001; // a1
	8'b11110010	: out = 10001001; // 89
	8'b11110011	: out = 00001101; // 0d
	8'b11110100	: out = 10111111; // bf
	8'b11110101	: out = 11100110; // e6
	8'b11110110	: out = 01000010; // 42
	8'b11110111	: out = 01101000; // 68
	8'b11111000	: out = 01000001; // 41
	8'b11111001	: out = 10011001; // 99
	8'b11111010	: out = 00101101; // 2d
	8'b11111011	: out = 00001111; // 0f
	8'b11111100 : out = 10110000; // b0
	8'b11111101	: out = 01010100; // 54
	8'b11111110	: out = 8'b10111011; // bb
	8'b11111111	: out = 00010110; // 16 // 16th row		
	
default: out=8'b0; //default 0
endcase

endmodule 

module lut(count_out, angle);
input [2:0] count_out;
output [11:0] angle;
reg [11:0] angle;

always @(count_out)
case (count_out)
3'b000: angle=12'b001000000000;	//0	45	45
3'b001: angle=12'b000100101110;	//1	26.54	26.57
3'b010: angle=12'b000010100000;	//2	14.06	14.036
3'b011: angle=12'b000001010001;	//3	7.12	7.13
3'b100: angle=12'b000000101001;	//4	3.604	3.576
3'b101: angle=12'b000000010100;	//5	1.76	1.79
3'b110: angle=12'b000000001010;	//6	0.88	0.9
3'b111: angle=12'b000000000101;	//7	0.44	0.45
default: angle=12'b001000000000; //default 0
endcase

endmodule

module testlut();
reg [2:0] co;
wire [11:0] a;

lut look(co, a);

initial begin
co = 3'b010; #20
$display("%b | %b ", co, a);

co = 3'b111; #20
$display("%b | %b ", co, a);
end

endmodule


module testSBox();
reg [7:0] innum;
wire [7:0] outnum;

SBoxLookup testing(innum, outnum);


initial begin

innum = 8'b11111110; #200
$display("%b |  00010110| %b ", outnum, innum);

innum = 8'b10100011; #200
$display("%b | 00001010 | %b", outnum, innum);

innum = 8'b0; #40
$display("%b", outnum);

end

endmodule
