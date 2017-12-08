//`include "Encrypt.v"
`include "Decrypt.v"

module MainAlgorithm(

input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText
);

wire [127:0] IntState;

Encrypt coding(SecretKey, PlainText, clk, IntState);
Decrypt decoding(SecretKey, IntState, clk, CipherText);

endmodule


























module testMain();

reg [127:0] SecretKey;
reg [127:0] PlainText;
reg clk;
wire [127:0] CipherText;

MainAlgorithm main(SecretKey, PlainText, clk, CipherText);

initial clk=0;
always #10 clk=!clk;

initial begin
$dumpfile("main.vcd");
$dumpvars();
$display("Main Algorithm");
SecretKey = 128'b1010; PlainText = 128'b0110; #4000
$display("%b | %b ", CipherText[7:0], PlainText[7:0]);

$finish;
end


endmodule





