`include "RoundA.v"
`include "decoder.v"
`include "DFF128.v"

module Encrypt(
input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText,
output [127:0] EncryptKey

);

wire [127:0] NewState;
wire [127:0] NewRoundKey;
wire [1:0] Ctrl;
wire OUTCtrl;
wire [127:0] RoundAStateOut;
wire [127:0] RoundBStateOut;
wire [127:0] RoundEStateOut;
wire [127:0] RoundAKeyOut;
wire [127:0] RoundBKeyOut;

wire [127:0] MuxKeyOut; 
wire [127:0] MuxStateOut;

wire [7:0] newiterate;

DFF flipflopKey(NewRoundKey, MuxKeyOut, clk); // out, in, clk
DFF flipflopState(NewState, MuxStateOut, clk); // out, in, clk


FSM controls(clk, Ctrl, OUTCtrl, newiterate);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, SecretKey, SecretKey, MuxKeyOut); // control, inA, inB, initial key, out
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, PlainText, RoundEStateOut, MuxStateOut);

RoundA options1_9(NewRoundKey, NewState, newiterate, RoundAKeyOut, RoundAStateOut);
RoundB option10(NewRoundKey, NewState, newiterate, RoundBKeyOut, RoundBStateOut);
RoundE option0(NewRoundKey, NewState, RoundEStateOut);//key, state in, state out

smallmux OUTmux(OUTCtrl, MuxStateOut, CipherText);
smallmux OUTkeymux(OUTCtrl, MuxKeyOut, EncryptKey);



endmodule


module testEncrypt();


reg [127:0] SecretKey;
reg [127:0] PlainText;
reg clk;
wire [127:0] CipherText;
wire [127:0] EncryptKey;

Encrypt testing(SecretKey, PlainText, clk, CipherText, EncryptKey);

initial clk=0;
always #10 clk=!clk;

initial begin

$dumpfile("encrypt.vcd");
$dumpvars();

SecretKey = 128'b101010; PlainText = 128'b110011; #280
$display("%b ", CipherText);

$finish;
end
endmodule












