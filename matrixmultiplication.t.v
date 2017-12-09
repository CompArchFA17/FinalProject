/*
Test bench for the 3x3 matrix multiplication module.
*/

`include "matrixmultiplication.v"

module matrixmultiplication3by3_TEST();
	parameter ENTRY_SIZE = 5;
	parameter RESENTRY_SIZE = 9;
	parameter VECTOR_SIZE = 3 * ENTRY_SIZE;
	parameter RESVECTOR_SIZE = 3 * RESENTRY_SIZE;

	reg[VECTOR_SIZE - 1:0] matrixAv1, matrixAv2, matrixAv3;
	reg[VECTOR_SIZE - 1:0] matrixBv1, matrixBv2, matrixBv3;

	wire[RESVECTOR_SIZE - 1:0] matrixCv1, matrixCv2, matrixCv3;

	matrixmultiplication3by3 #(
		.ENTRY_SIZE(ENTRY_SIZE),
		.RESENTRY_SIZE(RESENTRY_SIZE)
		) dut (
		.matrixAv1(matrixAv1), .matrixAv2(matrixAv2), .matrixAv3(matrixAv3),
		.matrixBv1(matrixBv1), .matrixBv2(matrixBv2), .matrixBv3(matrixBv3),
		.matrixCv1(matrixCv1), .matrixCv2(matrixCv2), .matrixCv3(matrixCv3)
		);

	initial begin
		$dumpfile("matmul.vcd");
		$dumpvars();

		// Multiply by zero matrix.
		matrixAv1 = {{5'd0}, {5'd0}, {5'd0}}; matrixAv2 = {{5'd0}, {5'd0}, {5'd0}}; matrixAv3 = {{5'd0}, {5'd0}, {5'd0}};
		matrixBv1 = {{5'd0}, {5'd0}, {5'd0}}; matrixBv2 = {{5'd0}, {5'd0}, {5'd0}}; matrixBv3 = {{5'd0}, {5'd2}, {5'd1}};
		#50
		if (matrixCv1 !== 27'b0 || matrixCv2 !== 27'b0 || matrixCv3 !== 27'b0) begin
			$display("Test failed. Expected 0 matrix, received: \n%d\t%d\t%d\n%d\t%d\t%d\n%d\t%d\t%d",
			matrixCv1[26:18], matrixCv1[17:9], matrixCv1[8:0], 
			matrixCv2[26:18], matrixCv2[17:9], matrixCv2[8:0],
			matrixCv3[26:18], matrixCv3[17:9], matrixCv3[8:0]);
		end

		// Multiply by identity matrix.
		matrixAv1 = {{5'd1}, {5'd0}, {5'd0}}; matrixAv2 = {{5'd0}, {5'd1}, {5'd0}}; matrixAv3 = {{5'd0}, {5'd0}, {5'd1}};
		matrixBv1 = {{5'd1}, {5'd2}, {5'd3}}; matrixBv2 = {{5'd2}, {5'd3}, {5'd5}}; matrixBv3 = {{5'd3}, {5'd1}, {5'd2}};
		#50
		if (matrixCv1 !== {{9'd1}, {9'd2}, {9'd3}} || matrixCv2 !== {{9'd2}, {9'd3}, {9'd5}} || matrixCv3 !== {{9'd3}, {9'd1}, {9'd2}}) begin
			$display("Test failed. Expected: \n%d\t%d\t%d\n%d\t%d\t%d\n%d\t%d\t%d\n Actual: \n%d\t%d\t%d\n%d\t%d\t%d\n%d\t%d\t%d",
				9'd1, 9'd2, 9'd3, 
				9'd2, 9'd3, 9'd5,
				9'd3, 9'd1, 9'd2,
				matrixCv1[26:18], matrixCv1[17:9], matrixCv1[8:0], 
				matrixCv2[26:18], matrixCv2[17:9], matrixCv2[8:0],
				matrixCv3[26:18], matrixCv3[17:9], matrixCv3[8:0]);
		end

		$finish();
	end
endmodule