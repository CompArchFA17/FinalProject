/*
Performs a scalar multiplication on two numbers.
Represents the operation a * b = c.
Inputs: 
	- a and b are the two scalars being multiplied
Outputs: 
	- result is the scalar product.
Parameters:
	- ENTRY_SIZE is the size of a and b
	- RESENTRY_SIZE is the size of result
*/
module scalar_multiplication 
#(
	parameter ENTRY_SIZE = 5,
	parameter RESENTRY_SIZE = 9
)
(
	input [ENTRY_SIZE - 1:0] a, b,
	output [RESENTRY_SIZE - 1:0] result
);

assign result = a*b;

endmodule // multiplication
