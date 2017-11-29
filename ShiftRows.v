module ShiftRows(

input [1:0][1:0][3:0] State,
output [1:0][1:0][3:0] SROut,
output[1:0][1:0][3:0]X,
output [1:0][1:0][3:0]Y
);



assign SROut = State;

	genvar j; 
	generate
		for (j = 0; j < 2; j = j + 1) begin
			assign X[1][j][3] = State[1][j][3]; // clearly something is going wrong here. Nothing is being assigned.
			assign Y[0][j][3] = State[0][j][3]; 
		end
	endgenerate
	
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

reg [1:0][1:0][3:0] s;
wire [1:0][1:0][3:0] so;
wire[1:0][1:0][3:0]X;
wire [1:0][1:0][3:0]Y;

ShiftRows shift(s, so,X,Y);

initial begin

$display("ShiftOut | StateIn | X | Y");
s = 16'b0000001100000000;
$display("%b | %b ", so, s); // clearly our indexing is messed up, but we should be able to get these values into X and Y
$display("%b", X[1][0][3]); // X[0]
$display("%b", X[1][1][3]); // X[1]
$display("%b", Y[0][0][3]); // Y[0]
$display("%b", Y[0][1][3]); // Y[1]
end

endmodule


