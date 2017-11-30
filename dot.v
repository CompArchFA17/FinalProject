`include "arithmetic.v"

module dot (

	input[4:0] a0, a1, a2, b0, b1, b2,
	output[8:0] product
);

assign product = (a0*b0) + (a1*b1) + (a2*b2);

endmodule