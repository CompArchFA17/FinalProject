`include "RoundC.v"
//`include "RoundA.v"
`include "Encrypt.v"

module Decrypt(
input [127:0] SecretKey,
input [127:0] CipheredText,
input clk,
output [127:0] DecryptedText
);

wire [127:0] NewState;
wire [127:0] NewRoundKey;
wire [1:0] Ctrl;
wire OUTCtrl;
wire [127:0] RoundAStateOut;
wire [127:0] RoundBStateOut;
wire [127:0] RoundAKeyOut;
wire [127:0] RoundBKeyOut;

wire [127:0] MuxKeyOut; 
wire [127:0] MuxStateOut;

wire [7:0] newiterate;


DFF flipflopKey(NewRoundKey, MuxKeyOut, clk); // out, in, clk
DFF flipflopState(NewState, MuxStateOut, clk); // out, in, clk


FSM controls(clk, Ctrl, OUTCtrl, newiterate);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, SecretKey, MuxKeyOut); // control, inA, inB, initial key, out
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, CipheredText, MuxStateOut);

RoundC Invoptions1_9(NewRoundKey, NewState, newiterate, RoundAKeyOut, RoundAStateOut);
RoundD Invoption10(NewRoundKey, NewState, newiterate, RoundBKeyOut, RoundBStateOut);

smallmux OUTmux(OUTCtrl, MuxStateOut, DecryptedText);



endmodule










