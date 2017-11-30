`include "arithmetic.v"

module testMult();

reg[4:0] a, b;
wire[4:0] out;

multiplication dut (a, b, out);

initial begin
a = 4'd4;
b = 4'd6;
#10

$display("%d",out);

end

endmodule // testMult