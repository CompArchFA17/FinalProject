/*`include "AddRoundKey.v"

`include "ShiftRows.v"

`include "KeyExpansion.v"*/

`include "InvMixColumns.v"
`include "InvSubBytes.v"
`include "InvKeyExpansion.v"
module RoundC(
	input [127:0] KeyIn,
	input [127:0] StateIn,
	input [7:0] iterate,
	output [127:0] KeyOut,
	output [127:0] StateOut
);
wire [127:0] RoundKey;
wire [127:0] ARKOut;
wire [127:0] SBOut;
wire [127:0] SROut;
wire [127:0] MCOut;

InvKeyExp128 CKeytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

ShiftRows CShift(StateIn, SROut);

InvSubBytes CBytes(SROut, SBOut);

AddRoundKey CARK(SBOut, RoundKey, ARKOut);

InvMixColumns CMC(ARKOut, MCOut);

assign KeyOut = RoundKey;
assign StateOut = MCOut;

endmodule

module RoundD(
	input [127:0] KeyIn,
	input [127:0] StateIn,
	input [7:0] iterate,
	output [127:0] KeyOut,
	output [127:0] StateOut
);
wire [127:0] RoundKey;
wire [127:0] ARKOut;
wire [127:0] SBOut;
wire [127:0] SROut;
wire [127:0] MCOut;

InvKeyExp128 CKeytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

ShiftRows CShift(StateIn, SROut);

InvSubBytes CBytes(SROut, SBOut);

AddRoundKey CARK(SBOut, RoundKey, ARKOut);

assign KeyOut = RoundKey;
assign StateOut = ARKOut;

endmodule



module RoundF(	
	input [127:0] KeyIn,
	input [127:0] StateIn,
	output [127:0] StateOut
);

AddRoundKey ARKtest(StateIn, KeyIn, StateOut); // takes in In, Key, gives

endmodule



module InvFSM(
input clk,
output reg [1:0] DCtrl, 
output reg OUTCtrl,
output reg [7:0] iterate
);

reg [7:0] counter; // counting is a little messed up (which is only problematic for iterate), so changing it to 9

initial counter = 8'b0;
initial iterate = 8'b1100;
initial DCtrl = 2'b11;
initial OUTCtrl = 1'b0;

always @(posedge clk) begin
	counter <= counter + 1;
	iterate <= iterate - 1;
	if (counter == 0) begin
		DCtrl <= 2'b11;
		OUTCtrl = 1'b0;
	end
/*	if (counter == 1) begin
		DCtrl <= 2'b11;
		OUTCtrl = 1'b0;
	end	*/
	if (counter > 0 && counter < 10) begin
		DCtrl <= 2'b00;
		OUTCtrl = 1'b0;
	end
	else if (counter == 10) begin
		DCtrl <= 2'b01;
		OUTCtrl = 1'b1;
	end
	else if (counter > 10)begin
		counter <= 1;
		DCtrl <= 2'b00;
		iterate <= 8'b1011;
		OUTCtrl = 1'b0;
	end
end
endmodule





