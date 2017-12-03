//`include "GFieldAddition.v"

module GFieldMultiplyFourv3(
input clk, 
input [0:7] a, 
input [0:7] b, 
output [0:7] prod4
);
reg [0:7] product = 8'b00000000; 
wire [0:7] p; 
reg [0:7] counter;
reg [0:7] c = 8'b00011011;
reg [0:7] a2 ; 
reg [0:7] b2 ; 

//initial a2[0:3] <= a[0:3];
//initial b2[0:3] <= b[0:3];
//initial a2 = a; 
//initial b2 = b; 
initial counter = 0; 

always @(posedge clk) begin 

if (counter == 0) begin
	assign a2[0:7] = a[0:7];
	assign b2[0:7] = b[0:7];
	counter = counter+1; 
end 	

if (counter < 9)begin 

	if(b[0] == 1) begin
		//product <= product ^ a ;
		assign product = product ^ a2 ;
	end  // if b end 
	
	if(a2[7] == 1) begin
		assign a2[0:7] = {a2[0:6], 1'b0} ;
		assign a2 = a2 ^ c ;
	end  
	
	if (a2[7] == 0)
		assign a2[0:7] = {a2[0:6], 1'b0} ;		
			
	assign b2[0:7] = {1'b0 , b2[0:6]} ;	

	$display(counter, "  ", a, " ",b,  "  ", a2, " ", b2, "  ", product);


counter = counter+1 ;
//product <= prod4;

end   //if counter end

end   // always end 
	
endmodule


module GFieldMultiplyFour_test();
reg clock; 
reg [0:7]x ; 
reg [0:7]y;
wire [0:7]p; 

//GFieldMultiplyFour test10(clock, x, y, p);
GFieldMultiplyFourv3 potato(clock, x, y, p);

    initial clock=0;
    always #10 clock=!clock;    // 50MHz Clock  

initial begin
//$display("  x  |  y   |  p  " );
x = 8'b00000111; y = 8'b0000011; #100
//$display("%b | %b | %b ", x, y, p);
//x = 4'b0001; y = 4'b0000; #100
//$display("%b | %b | %b ", x, y, p);
//x = 4'b1111; y = 4'b0010; #100
//$display("%b | %b | %b ", x, y, p);




$finish;
end
endmodule



