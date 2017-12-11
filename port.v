module port(input clk,
            input[11:0] leftIn, input rightIn[11:0], output leftOut[11:0], output rightOut[11:0],
            input leftWrite, output reg rightDataReady, input r2lAckIn, output r2lAckOut,
            input rightWrite, output reg leftDataReady, input l2rAckIn, output l2rAckOut);
  reg[11:0] buffer;
  always @(posedge clk) begin
    if(leftWrite) begin
      buffer <= leftIn;
      rightDataReady <= 1;
    end else if(rightWrite) begin
      buffer <= rightIn;
      leftDataReady <= 1;
    end
    if(r2lAckIn) begin
      leftDataReady <= 0;
    end
    if(l2rAckIn) begin
      leftDataReady <= 0;
    end
  end
  assign r2lAckOut = r2lAckIn;
  assign l2rAckOut = l2rAckIn;
endmodule
