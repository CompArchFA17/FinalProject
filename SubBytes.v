`include "SBoxLookup.v" 

module SubBytes(
reg [127:0] ARKOut,
wire [127:0] SBOut

);
genvar i;
generate
for (i = 1; i < 17; i = i + 1) begin
	SBoxLookup assignvalues(ARKOut[i, SBOut);
	
end

endgenerate

endmodule

