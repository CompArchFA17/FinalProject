module ShiftRowsInt(
input [3:0] inarray,
input clk,
output reg [3:0] outarray
);

parameter dimension = 2;
reg [1:0] counter = 2'b0;

always @(posedge clk) begin
	counter = counter + 1;
	
	if (counter == 1) begin
		outarray[(dimension*dimension-1)-((dimension*(2-1))+(2-1))] <= inarray[(dimension*dimension-1)-((dimension*(1-1))+(2-1))];
		outarray[(dimension*dimension-1)-((dimension*(1-1))+(2-1))] <= inarray[(dimension*dimension-1)-((dimension*(2-1))+(2-1))];
	end

end

endmodule

module testSRI();

reg [3:0] s;
reg clk;
wire [3:0] so;

ShiftRowsInt shifts(s,clk,so);

    initial clk=0;
    always #10 clk=!clk;  
    
    initial begin
    s=4'b1011; #20
    $display("%b %b ", so, s);
    
    
    $finish;
    end

endmodule
