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

wire [7:0] newiterate;

// need to initialize with SecretKey and PlainText



DFF flipflopKey(NewRoundKey, MuxKeyOut, clk); // out, in, clk
DFF flipflopState(NewState, MuxStateOut, clk); // out, in, clk


FSM controls(clk, Ctrl, newiterate);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, MuxKeyOut); // control, inA, inB, out
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, NewState);

RoundA options1_9(NewRoundKey, NewState, newiterate, RoundAKeyOut, RoundAStateOut);
RoundB option10(NewRoundKey, NewState, newiterate, RoundBKeyOut, RoundBStateOut);

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












