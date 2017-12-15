`include "tis100.v"
module tis100Test();

reg clk;
wire signed[10:0] accOutLeft;
wire signed[10:0] accOutRight;
reg[32:0] i;

wire[14:0] L2R;
wire[14:0] R2L;

tis100 #("left.dat")  left( .clk(clk), .accOut(accOutLeft),  .rightOut(L2R), .right(R2L));
tis100 #("right.dat") right(.clk(clk), .accOut(accOutRight), .left(L2R),     .leftOut(R2L));

initial begin
  i = 0;
  for( i = 0; i<10; i=i+1) begin
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    $display("accLeft = %d \naccRight= %d\n",accOutLeft,accOutRight);
  end
end

endmodule
