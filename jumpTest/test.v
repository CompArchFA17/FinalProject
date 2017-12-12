`include "tis100.v"
module tis100Test();

reg clk;
wire signed[10:0] accOutCenter;
wire signed[10:0] accOutUp;
wire signed[10:0] accOutDown;
wire signed[10:0] accOutLeft;
wire signed[10:0] accOutRight;

reg[32:0] i;

wire[14:0] L2C;
wire[14:0] C2L;

wire[14:0] R2C;
wire[14:0] C2R;

wire[14:0] U2C;
wire[14:0] C2U;

wire[14:0] D2C;
wire[14:0] C2D;

reg dutPassed;

tis100 #("jumpTest/left.dat")   left( .clk(clk),  .rightOut(L2C), .right(C2L), .accOut(accOutLeft));
tis100 #("jumpTest/right.dat")  right( .clk(clk),  .leftOut(R2C), .left(C2R), .accOut(accOutRight));
tis100 #("jumpTest/up.dat")     up( .clk(clk),     .downOut(U2C), .down(C2U), .accOut(accOutUp));
tis100 #("jumpTest/down.dat")   down( .clk(clk),     .upOut(D2C), .up(C2D), .accOut(accOutDown));
tis100 #("jumpTest/center.dat") center(.clk(clk),
                              .upOut(C2U),    .up(U2C),
                              .downOut(C2D),  .down(D2C),
                              .leftOut(C2L),  .left(L2C),
                              .rightOut(C2R), .right(R2C),
                              .accOut(accOutCenter)
                              );

initial begin
  i = 0;
  dutPassed = 1;
  for( i = 0; i<10; i=i+1) begin
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
  end
  if(accOutUp != 1) begin
  $display("Failed on up test of jumpTest, %d", accOutUp);
  dutPassed = 0;
  end
  if(accOutLeft != 1) begin
  $display("Failed on left test of jumpTest, %d", accOutLeft);
  dutPassed = 0;
  end
  if(accOutRight != 1) begin
  $display("Failed on right test of jumpTest, %d", accOutRight);
  dutPassed = 0;
  end
  if(accOutDown != 1) begin
  $display("Failed on down test of jumpTest, %d", accOutDown);
  dutPassed = 0;
  end
  if(accOutCenter != 1) begin
  $display("Failed on center test of jumpTest, %d",accOutCenter);
  dutPassed = 0;
  end
  if(dutPassed) begin
    $display("DUT passed jumpTest");
  end
end

endmodule
