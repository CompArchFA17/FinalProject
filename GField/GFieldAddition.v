// modules here: 

// GFieldAddOne
// GFieldAddTwo
// GFiledAddFour
// GFieldAddEiwght



module GFieldAddOne(
input a, 
input b, 
output sum
);
	xor sum1(sum, a, b);	
endmodule


module GFieledAddOne_test();
reg x; 
reg y; 
wire s;

GFieldAddOne test1(x, y, s);
/*
initial begin
$display("A | B | sum");
x = 0; y=0; #10
$display("%b | %b | %b ", x, y, s);
x = 0; y=1; #10
$display("%b | %b | %b ", x, y, s);
x = 1; y=0; #10
$display("%b | %b | %b ", x, y, s);
x = 1; y=1; #10
$display("%b | %b | %b ", x, y, s);
$finish;
end
*/
endmodule



module GFieldAddTwo(
input [0:1] c, 
input [0:1] d, 
output [0:1] sum2
);
	xor sum2a(sum2[0], c[0], d[0]);
	xor sum2b(sum2[1], c[1], d[1]);	
endmodule

module GFieledAddTwo_test();
reg [0:1] e; 
reg [0:1] f; 
wire [0:1] g;

GFieldAddTwo test2(e, f, g[0:1]);
/*
initial begin
$display("A2 | B2 | sum");
e = 00; f=00; #10
$display("%b | %b | %b ", e, f, g[0:1]);
e = 01; f=00; #10
$display("%b | %b | %b ", e, f, g[0:1]);
e = 00; f=01; #10
$display("%b | %b | %b ", e, f, g[0:1]);
e = 11; f=00; #10
$display("%b | %b | %b ", e, f, g[0:1]);
e = 11; f=10; #10
$display("%b | %b | %b ", e, f, g[0:1]);

$finish;
end
*/
endmodule



module GFieldAddFour(
input [0:3] m, 
input [0:3] n, 
output [0:3] sum4
);
	xor sum4a(sum4[0], m[0], n[0]);
	xor sum4b(sum4[1], m[1], n[1]);	
	xor sum4c(sum4[2], m[2], n[2]);
	xor sum4d(sum4[3], m[3], n[3]);	
endmodule

module GFieldAddFour_test();
reg [0:3] p; 
reg [0:3] q; 
wire [0:3] r;

GFieldAddFour Test4(p, q, r[0:3]);
/*
initial begin
$display("A4 | B4 | sum");
p = 0001; q = 1000; #10
$display("%b | %b | %b ", p, q, r[0:3]);
p = 0001; q = 1111; #10
$display("%b | %b | %b ", p, q, r[0:3]);
p = 0001; q = 1001; #10
$display("%b | %b | %b ", p, q, r[0:3]);
p = 1101; q = 1001; #10
$display("%b | %b | %b ", p, q, r[0:3]);
p = 0000; q = 1111; #10
$display("%b | %b | %b ", p, q, r[0:3]);
$finish;
end
*/ 
endmodule




module GFieldAddEight(
input [0:7] t, 
input [0:7] u, 
output [0:7] sum8
);
	xor sum8a(sum8[0], t[0], u[0]);
	xor sum8b(sum8[1], t[1], u[1]);	
	xor sum8c(sum8[2], t[2], u[2]);
	xor sum8d(sum8[3], t[3], u[3]);
	xor sum8e(sum8[4], t[4], u[4]);
	xor sum8f(sum8[5], t[5], u[5]);	
	xor sum8g(sum8[6], t[6], u[6]);
	xor sum8h(sum8[7], t[7], u[7]);		
endmodule

module GFieledAddEight_test();
reg [0:7] v; 
reg [0:7] w; 
wire [0:7] rx;

GFieldAddEight Test8(v, w, rx[0:7]);

initial begin
$display("A8 | B8 | sum8");
v = 00000001; w = 10000000; #10
$display("%b | %b | %b ", v, w, rx[0:7]);
v = 00100001; w = 11100000; #10
$display("%b | %b | %b ", v, w, rx[0:7]);

$finish;
end
endmodule







