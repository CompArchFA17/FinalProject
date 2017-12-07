"""
Perform the dot product on two 3 dimensional vectors.
Represents the operation dot(a, b) = c
Inputs: 
	- a0, ..., a2 and b0, ..., b2 represent the entries of the vectors a and b.
Outputs: 
	- product represents the scalar c.
Parameters: 
	- ENTRY_SIZE is the size of each individual entry of a and b.
	- RESENTRY_SIZE is the size of the product c.
"""

`include "arithmetic.v"

module dot 
#(
	parameter ENTRY_SIZE = 5,
	parameter RESENTRY_SIZE = 9
)
(
	input[ENTRY_SIZE - 1:0] a0, a1, a2, b0, b1, b2,
	output[RESENTRY_SIZE - 1:0] product
);

wire[RESENTRY_SIZE - 1:0] multres0;
wire[RESENTRY_SIZE - 1:0] multres1;
wire[RESENTRY_SIZE - 1:0] multres2;

scalar_multiplication #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) multop0 (.a(a0), .b(b0), .result(multres0));
scalar_multiplication #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) multop1 (.a(a1), .b(b1), .result(multres1));
scalar_multiplication #(.ENTRY_SIZE(ENTRY_SIZE), .RESENTRY_SIZE(RESENTRY_SIZE)) multop2 (.a(a2), .b(b2), .result(multres2));

assign product = multres0 + multres1 + multres2;

endmodule