`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module ShiftRows (

input [3:0] inarray,
input clk,
output reg [3:0] outarray

);
parameter dimension = 2;
reg X;
reg Y;
reg [1:0] counter = 2'b0;

always @(posedge clk) begin
	counter = counter + 1;
	
	if (counter == 1) begin
		`OUT(2,2) <= `STATE(2,1) ;
		`OUT(2,1) <= `STATE(2,2) ;
	end
	/*
	if (counter == 2) begin
		//`OUT(2,1) <= Y;
		outarray[3] <= Y;
	end
*/

end

endmodule

module testSR();

reg [3:0] s;
reg clk;
wire [3:0] so;
ShiftRows shift(s, clk, so);

    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock  

initial begin

$display("ShiftOut | StateIn | X | Y");
s = 4'b1011; #200
$display("%b | %b ", so, s); // clearly our indexing is messed up, but we should be able to get these values into X and Y
//$display("%b", X); // X[0]
//$display("%b", Y); // X[1]

$finish;
end

endmodule

