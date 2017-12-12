`include "tis100.v"
module tis100Test();

reg clk;
wire signed[10:0] accOutCenter;
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

tis100 #("anyRead/left.dat")   left( .clk(clk),  .rightOut(L2C), .right(C2L));
tis100 #("anyRead/right.dat")  right( .clk(clk),  .leftOut(R2C), .left(C2R));
tis100 #("anyRead/up.dat")     up( .clk(clk),     .downOut(U2C), .down(C2U));
tis100 #("anyRead/down.dat")   down( .clk(clk),     .upOut(D2C), .up(C2D));
tis100 #("anyRead/center.dat") center(.clk(clk),
                              .upOut(C2U),    .up(U2C),
                              .downOut(C2D),  .down(D2C),
                              .leftOut(C2L),  .left(L2C),
                              .rightOut(C2R), .right(R2C),
                              .accOut(accOutCenter)
                              );

reg signed[10:0] expected[0:6];

initial begin
  i = 0;
  dutPassed = 1;
  expected[0] = 0;
  expected[1] = 1;
  expected[2] = 2;
  expected[3] = 3;
  expected[4] = 4;
  expected[5] = 4;
  expected[6] = 5;
  for( i = 0; i<7; i=i+1) begin
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    $display("acc = %d",accOutCenter);
    if(accOutCenter != expected[i]) begin
      $display("anyRead failed on test %d",i);
      dutPassed = 0;
    end
  end
  if(dutPassed) begin
  $display("DUT passed anyRead");
  end
end

endmodule
