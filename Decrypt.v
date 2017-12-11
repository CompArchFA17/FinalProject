`include "RoundC.v"
//`include "RoundA.v"
`include "Encrypt.v"

module Decrypt(
input [127:0] SecretKey,
input [127:0] CipheredText,
input clk,
output [127:0] DecryptedText,
output [127:0] OriginalKey
);

wire [127:0] NewState;
wire [127:0] NewRoundKey;
wire [1:0] Ctrl;
wire OUTCtrl;
wire [127:0] RoundAStateOut;
wire [127:0] RoundBStateOut;
wire [127:0] RoundFStateOut;
wire [127:0] RoundAKeyOut;
wire [127:0] RoundBKeyOut;

wire [127:0] MuxKeyOut; 
wire [127:0] MuxStateOut;

wire [7:0] newiterate;


DFF flipflopKey(NewRoundKey, MuxKeyOut, clk); // out, in, clk
DFF flipflopState(NewState, MuxStateOut, clk); // out, in, clk


InvFSM controls(clk, Ctrl, OUTCtrl, newiterate);

mux RKmux(Ctrl, RoundAKeyOut, RoundBKeyOut, SecretKey, SecretKey, MuxKeyOut); // control, inA, inB, initial key, out
mux SMmux(Ctrl, RoundAStateOut, RoundBStateOut, CipheredText, RoundFStateOut, MuxStateOut);

RoundC Invoptions1_9(NewRoundKey, NewState, newiterate, RoundAKeyOut, RoundAStateOut);
RoundD Invoption10(NewRoundKey, NewState, newiterate, RoundBKeyOut, RoundBStateOut);
RoundF Invoption0(NewRoundKey, NewState, RoundFStateOut);


smallmux OUTmux(OUTCtrl, MuxStateOut, DecryptedText);
smallmux OUTkeymux(OUTCtrl, MuxKeyOut, OriginalKey);

endmodule

module testDecrypt();


reg [127:0] SecretKey;
reg [127:0] CipherText;
reg clk;
wire [127:0] PlainText;
wire [127:0] OrigKey;

Decrypt testing(SecretKey, CipherText, clk, PlainText, OrigKey);

initial clk=0;
always #10 clk=!clk;

initial begin

$dumpfile("decrypt.vcd");
$dumpvars();

SecretKey = 128'h7715D9597715D9597715D9597731D959; CipherText = 128'h23ECBEB923EC4DAF2323BEAF5BC8BEAF; #500
$display("%b ", PlainText);

$finish;
end
endmodule









