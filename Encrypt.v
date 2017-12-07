`include "RoundA.v"
`include "decoder.v"
`include "DFF128.v"

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

wire [127:0] MuxKeyOut; 
wire [127:0] MuxStateOut;

DFF128 flipflopKey(NewRoundKey, MuxKeyOut, clk); // out, in, clk
DFF128 flipflopState(NewState, MuxStateOut, clk); // out, in, clk


wire [7:0] iteration;

FSM controls(clk, Ctrl, iteration);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, MuxKeyOut); // control, inA, inB, out
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, NewState);

RoundA options1_9(MuxKeyOut, MuxStateOut, iteration, RoundAKeyOut, RoundAStateOut);
RoundB option10(MuxKeyOut, MuxStateOut, iteration, RoundBKeyOut, RoundBStateOut);

assign CipherText = MuxStateOut;


endmodule


module testEncrypt();


reg [127:0] SecretKey;
reg [127:0] PlainText;
reg clk;
wire [127:0] CipherText;

Encrypt testing(SecretKey, PlainText, clk, CipherText);

initial clk=0;
always #10 clk=!clk;

initial begin
SecretKey = 128'b101010; PlainText = 128'b110011; #400
$display("%b ", CipherText);

$finish;
end





endmodule












