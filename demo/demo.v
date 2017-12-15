`include "tis100.v"
`include "stackmemory.v"
module tis100Test();

reg clk;
reg[32:0] i;

wire[14:0] inToOne;
wire[14:0] oneToIn;

wire[14:0] oneToThree;
wire[14:0] threeToOne;

wire[14:0] twoToFive;
wire[14:0] fiveToTwo;

wire[14:0] threeToFour;
wire[14:0] fourToThree;

wire[14:0] fourToFive;
wire[14:0] fiveToFour;

wire[14:0] sixToSeven;
wire[14:0] sevenToSix;

wire[14:0] sevenToFive;
wire[14:0] fiveToSeven;

wire[14:0] sixToOut;
wire[14:0] outToSix;

reg dutPassed;

tis100 #("demo/one.dat")       one(.clk(clk),
                                   .downOut(oneToThree), .down(threeToOne),
                                   .upOut(oneToIn),      .up(inToOne));

tis100 #("demo/two.dat")      two(.clk(clk),
                                  .downOut(twoToFive),  .down(fiveToTwo));

tis100 #("demo/three.dat")    three(.clk(clk),
                                    .rightOut(threeToFour),  .right(fourToThree),
                                    .upOut(threeToOne),      .up(oneToThree));

tis100 #("demo/four.dat")    four(.clk(clk),
                                    .leftOut(fourToThree),  .left(threeToFour),
                                    .rightOut(fourToFive),  .right(fiveToFour));

tis100 #("demo/five.dat")    five(.clk(clk),
                                    .leftOut(fiveToFour),  .left(fourToFive),
                                    .upOut(fiveToTwo),      .up(twoToFive),
                                    .downOut(fiveToSeven),  .down(sevenToFive));

tis100 #("demo/six.dat")    six(.clk(clk),
                                    .rightOut(sixToSeven),  .right(sevenToSix),
                                    .downOut(sixToOut),     .down(outToSix));

tis100 #("demo/seven.dat")    seven(.clk(clk),
                                    .leftOut(sevenToSix),   .left(sixToSeven),
                                    .upOut(sevenToFive),    .up(fiveToSeven));

tis100 #("demo/in.dat")            in(.clk(clk), .down(oneToIn), .downOut(inToOne));
tis100 #("demo/out.dat",1)           out(.clk(clk), .up(sixToOut), .upOut(outToSix));

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
  for( i = 0; i<50000; i=i+1) begin
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
    clk = 0; #1;
    clk = 1; #1;
  end
end

endmodule
