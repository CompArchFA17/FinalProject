`define STATE(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

module ShiftRows (

input [15:0] inarray,
input clk,
output reg [15:0] outarray

);
parameter dimension = 4;
reg X;
reg Y;
reg [1:0] counter = 2'b0;

always @(posedge clk) begin
	counter = counter + 1;
	
	if (counter == 1) begin
		`OUT(1,1) <= `STATE(1,1) ;
		`OUT(1,2) <= `STATE(1,2) ;
		`OUT(1,3) <= `STATE(1,3) ;
		`OUT(1,4) <= `STATE(1,4) ;
	
		`OUT(2,4) <= `STATE(2,1) ;
		`OUT(2,1) <= `STATE(2,2) ;
		`OUT(2,2) <= `STATE(2,3) ;
		`OUT(2,3) <= `STATE(2,4) ;
		
		`OUT(3,3) <= `STATE(3,1) ;
		`OUT(3,4) <= `STATE(3,2) ;
		`OUT(3,1) <= `STATE(3,3) ;
		`OUT(3,2) <= `STATE(3,4) ;
		
		`OUT(4,2) <= `STATE(4,1) ;
		`OUT(4,3) <= `STATE(4,2) ;
		`OUT(4,4) <= `STATE(4,3) ;
		`OUT(4,1) <= `STATE(4,4) ;
		
	end
	else if (counter == 2) begin
		counter <= 0;
	end

end

endmodule

module testSR();

reg [15:0] s;
reg clk;
wire [15:0] so;
ShiftRows shift(s, clk, so);

    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock  

initial begin

$display("ShiftOut | StateIn | X | Y");
s = 16'b1011001000001111; #200
$display("%b | %b ", so, s); // clearly our indexing is messed up, but we should be able to get these values into 
$finish;
end

endmodule

