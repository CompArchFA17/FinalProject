`include "AddRoundKey.v"
`include "InvSubBytes.v"
`include "ShiftRows.v"
`include "InvMixColumns.v"
`include "KeyExpansion.v"

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

KeyExp128 CKeytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

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

KeyExp128 CKeytest(KeyIn, iterate, RoundKey);  // takes in old KeyIn, gives out new Key

ShiftRows CShift(StateIn, SROut);

InvSubBytes CBytes(SROut, SBOut);

AddRoundKey CARK(SBOut, RoundKey, ARKOut);

assign KeyOut = RoundKey;
assign StateOut = ARKOut;

endmodule
