`include "RoundA.v"
`include "decoder.v"

module Encrypt(
input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText

);

wire [127:0] NewState;
wire [127:0] NewRoundKey;
wire Ctrl;
wire [127:0] RoundAStateOut;
wire [127:0] RoundBStateOut;
wire [127:0] RoundAKeyOut;
wire [127:0] RoundBKeyOut;



assign NewState = PlainText;
assign NewRoundKey = SecretKey;


wire [7:0] iteration;

FSM controls(clk, Ctrl, iteration);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, NewRoundKey);
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, NewState);

RoundA options1_9(NewRoundKey, NewState, iteration, RoundAKeyOut, RoundAStateOut);
RoundB option10(NewRoundKey, NewState, iteration, RoundBKeyOut, RoundBStateOut);


endmodule
