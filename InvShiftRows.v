`define STATE2(r,c) inarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define OUT2(r,c) outarray[(dimension*dimension-1)-((dimension*(c-1))+(r-1))]

`define STATE(r, c) inarray[((4*c)+(8*r)+7):((4*c)+(8*r))]
`define OUT(r, c) outarray[((4*c)+(8*r)+7):((4*c)+(8*r))]

module InvShiftRows (

input [127:0] inarray,
output [127:0] outarray

);
parameter dimension = 4;


		assign `OUT(3, 0) = `STATE(3, 0) ;
		assign `OUT(3, 8) = `STATE(3, 8) ;
		assign `OUT(3, 16) = `STATE(3, 16) ;
		assign `OUT(3, 24) = `STATE(3, 24) ;
		
		assign `OUT(2, 24) = `STATE(2, 0) ;
		assign `OUT(2, 0) = `STATE(2, 8) ;
		assign `OUT(2, 8) = `STATE(2, 16) ;
		assign `OUT(2, 16) = `STATE(2, 24) ;
		
		assign `OUT(1, 16) = `STATE(1, 0) ;
		assign `OUT(1, 24) = `STATE(1, 8) ;
		assign `OUT(1, 0) = `STATE(1, 16) ;
		assign `OUT(1, 8) = `STATE(1, 24) ;		
		
		
		assign `OUT(0, 8) = `STATE(0, 0) ;
		assign `OUT(0, 16) = `STATE(0, 8) ;
		assign `OUT(0, 24) = `STATE(0, 16) ;
		assign `OUT(0, 0) = `STATE(0, 24) ;	
		


endmodule

/*
module testInvSR();

reg [127:0] s;

wire [127:0] so;
InvShiftRows shift(s, so);



initial begin

$display("InvShiftOut ");
s = 128'b00000000000000000000000010111100000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000 
; #200
$display("%b ", so); 

end

endmodule
*/
