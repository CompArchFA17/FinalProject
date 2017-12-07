`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"
`include "KeyExpansion.v"


module RoundA(
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

KeyExp128 Keytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

AddRoundKey ARKtest(StateIn, RoundKey, ARKOut); // takes in In, Key, gives out Out
		
SubBytes SBtest(ARKOut, SBOut);

ShiftRows SRtest(SBOut, SROut);
		
MixColumns MCtest(SROut, MCOut); 

assign KeyOut = RoundKey;
assign StateOut = MCOut;

endmodule

module RoundB(
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

KeyExp128 Keytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

AddRoundKey ARKtest(StateIn, RoundKey, ARKOut); // takes in In, Key, gives out Out
		
SubBytes SBtest(ARKOut, SBOut);

ShiftRows SRtest(SBOut, SROut);

assign KeyOut = RoundKey;
assign StateOut = SROut;

endmodule

module FSM(
input clk,
output reg DCtrl, 
output [7:0] iterate
);

reg [7:0] counter;

always @(posedge clk) begin
	counter = counter + 1;
	//iterate = iterate + 1;
	if (counter > 0 && counter < 10) begin
		DCtrl <= 0;
	end
	else if (counter == 10) begin
		DCtrl <= 1;
	end
	else if (counter > 10)begin
		counter <= 0;
		DCtrl <= 0;
	end
end
endmodule
