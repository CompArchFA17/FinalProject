//`include "GFieldAddition.v"

module GFieldMultiplyFourv3(
input clk, 
input [0:3] a, 
input [0:3] b, 
output [0:3] prod4
);
reg [0:3] product = 0000; 
wire [0:3] p; 
//reg counter = 0; 
reg [0:3] counter;
reg [0:3] c = 1011;
reg [0:3] a2 ; 
reg [0:3] b2 ; 

initial a2 = a; 
initial b2 = b; 
initial counter = 0; 

always @(posedge clk) begin 

if (counter < 4)begin 

	if(b[0] == 1) begin
		product <= product ^ a ;
		//prod4 <= prod4 ^ a ;
	end  // if b end 
	
	if(a2[3] == 1) begin
		a2[0:3] = {a2[0:2], 1'b0} ;
		a2 = a2 ^ c ;
	end  
	if (a2[3] == 0)
		a2[0:3] = {a2[0:2], 1'b0} ;			
	b2[0:3] = {1'b0 , b2[0:2]} ;	

counter = counter+1 ;

product <= prod4;
 
$display(counter);
$display("product");

$display(product);
	
end   //if counter end

end   // always end 
	
endmodule


module GFieldMultiplyFour_test();
reg clock; 
reg [0:3]x ; 
reg [0:3]y;
wire [0:3]p; 

//GFieldMultiplyFour test10(clock, x, y, p);
GFieldMultiplyFourv3 potato(clock, x, y, p);

    initial clock=0;
    always #10 clock=!clock;    // 50MHz Clock  

initial begin
$display("  x  |  y   |  p  " );
x = 4'b0000; y = 4'b0000; #100
$display("%b | %b | %b ", x, y, p);
x = 4'b0001; y = 4'b0000; #100
$display("%b | %b | %b ", x, y, p);
x = 4'b1111; y = 4'b0010; #100
$display("%b | %b | %b ", x, y, p);




$finish;
end
endmodule



