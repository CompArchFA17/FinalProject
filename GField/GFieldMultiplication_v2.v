`include "GFieldAddition.v"

module GFieldMultiplyFour(
input clk, 
input [0:3] a, 
input [0:3] b, 
output [0:3] prod4
);
reg [0:3] product = 0000; 
//reg i = 1; 
wire [0:3] p; 
genvar i;

//GFieldAddFour xorstep(product, a, p[0:3]);  
//GFieldAddFour xorstep(product, a, p[0:3]);  
generate

	for (i = 0; i < 4; i = i+1) begin
	
	//if (i < 4)begin 
	always @* begin 
		if(b[0] == 1) begin
			GFieldAddFour xorstep(product, a, p[0:3]);
			//p = product; 
		end  // if b end 
	end   // always end 
			
//		if(a[3] == 1) begin
//			a[0:3] <= {a[0:2], 0}
//			//a << 1 ;
//			GFieldAddFour xorastep(a, 1011) ; // 00011011
//		end
//		if (a[3] == 0)
//			a << 1 ;			
//		b >> 1; 	
	

	end  // for i
endgenerate

	
endmodule


