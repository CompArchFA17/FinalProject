`define STATE(r,c) inarray[(elements*(c-1))+(r-1)];
`define OUT(r,c) outarray[(elements*(c-1))+(r-1)];


module ShiftRows(

input [3:0] inarray,
input clk,
output [3:0] outarray,
output X,
output Y
);
parameter elements = 2;

reg [1:0] counter = 2'b0;

always @(posedge clk) begin
	counter = counter + 1;
	
	if (counter == 1) begin
		X <= `STATE(2,1);
		Y <= `STATE(2,2);
	end
	/*if (counter == 2) begin
		`STATE(2,1) <= Y;
	end*/


end

/*
	genvar j; 
	generate
		for (j = 0; j < 2; j = j + 1) begin
			assign X[1][j][3] = State[1][j][3]; // clearly something is going wrong here. Nothing is being assigned.
			assign Y[0][j][3] = State[0][j][3]; 
		end
	endgenerate
	*/
	/*
	always @(*) begin
		if (j < 2) begin
			X[j] <= State[1][j][3];
			Y[j] <= State[0][j][3];
			j <= j + 1;
		end
	end*/

endmodule

module testSR();

reg [3:0] s;
reg clk;
wire [3:0] so;
wire X;
wire Y;

ShiftRows shift(s, clk, so, X, Y);

initial begin

$display("ShiftOut | StateIn | X | Y");
s = 4'b0101;
$display("%b | %b ", so, s); // clearly our indexing is messed up, but we should be able to get these values into X and Y
$display("%b", X); // X[0]
$display("%b", Y); // X[1]

end

endmodule


