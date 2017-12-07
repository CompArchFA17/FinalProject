

module MainAlgorithm(

input [127:0] SecretKey, 
input [127:0] PlainText,
input clk,
output [127:0] CipherText
);

wire [1407:0] StateMatrix;
wire [1407:0] ARKOut;
wire [1407:0] RoundKey;
wire [1407:0] SBOut;
wire [1407:0] SROut;
wire [1407:0] MCOut;

reg [7:0] iterate = 8'b1;


assign StateMatrix[127:0] = PlainText;
assign RoundKey[127:0] = SecretKey;

genvar i;
generate
	for (i = 2; i <11; i = i + 1) begin
		//iterate = iterate+1;	
		KeyExp128 Keytest(RoundKey[((128*(i-1))-1):((i-2)*128)], iterate, RoundKey[((128*i)-1):((i-1)*128)]);
		
		AddRoundKey ARKtest(RoundKey[((128*i)-1):((i-1)*128)], StateMatrix[((128*i)-1):((i-1)*128)], ARKOut[((128*i)-1):((i-1)*128)]); 
 
		SubBytes SBtest(ARKOut[((128*i)-1):((i-1)*128)], SBOut[((128*i)-1):((i-1)*128)]);
		ShiftRows SRtest(SBOut[((128*i)-1):((i-1)*128)], clk, SROut[((128*i)-1):((i-1)*128)]);
		MixColumns MCtest(SROut[((128*i)-1):((i-1)*128)], clk, MCOut[((128*i)-1):((i-1)*128)]);
		
		assign StateMatrix[((128*(i+1))-1):((i)*128)] = MCOut[((128*i)-1):((i-1)*128)];
	end
endgenerate

assign CipherText = MCOut[127:0];

endmodule


module testMain();
reg [127:0] SecretKey;
reg [127:0] PlainText;
reg clk;
wire [127:0] CipherText;



MainAlgorithm testall(SecretKey, PlainText, clk, CipherText);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock  

initial begin

SecretKey = 128'b1; PlainText = 128'b0; #500000
$display("%b", CipherText);

SecretKey = 128'b1; PlainText = 128'b01111100011111000100001001011101011000110110001101100011011000110110001101100011011000110110001101100011011000110110001101100011; #500000
$display("%b", CipherText);

$finish;
end

endmodule








