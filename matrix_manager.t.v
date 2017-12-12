`include "matrix_manager.v"

/*
Since I dont' have direect access to the contents of memory, I can't adequately test writing data.
*/

module matrixmanagertest();

reg clk;

reg dm_we, next_row, column;
reg[9:0] n, m, p;

reg[4:0] dataIn0, dataIn1, dataIn2, dataIn3, dataIn4, dataIn5, dataIn6, dataIn7, dataIn8;
wire[4:0] dataOut0, dataOut1, dataOut2, dataOut3, dataOut4, dataOut5, dataOut6, dataOut7, dataOut8;


matrix_manager dut (.clk(clk), .dm_we(dm_we), .next_row(next_row), .column(column),
.n(n), .m(m), .p(p),
.dataIn0(dataIn0), .dataIn1(dataIn1), .dataIn2(dataIn2), .dataIn3(dataIn3), .dataIn4(dataIn4), .dataIn5(dataIn5), .dataIn6(dataIn6), .dataIn7(dataIn7), .dataIn8(dataIn8),
.dataOut0(dataOut0), .dataOut1(dataOut1), .dataOut2(dataOut2), .dataOut3(dataOut3), .dataOut4(dataOut4), .dataOut5(dataOut5), .dataOut6(dataOut6), .dataOut7(dataOut7), .dataOut8(dataOut8));

always #10 clk = !clk;

initial begin

$dumpfile("matrix_manager.vcd");
$dumpvars();

clk = 1'b0;

next_row = 1'b1;
column = 1'b0;
n = 10'd6;
m = 10'd3;
p = 10'd6;

// A * C D = E F
// B         G H

dm_we = 1'b0;

#20

// A
if (dataOut0 !== 5'd0 || dataOut1 !== 5'd1 || dataOut2 !== 5'd2 ||
	dataOut3 !== 5'd3 || dataOut4 !== 5'd4 || dataOut5 !== 5'd5 ||
	dataOut6 !== 5'd6 || dataOut7 !== 5'd7 || dataOut8 !== 5'd8) begin
	$display("test 1 FAILED: matrix manager did not output first matrix correctly");
end

next_row = 1'b1;

#20

// B
if (dataOut0 !== 5'd9 || dataOut1 !== 5'd10 || dataOut2 !== 5'd11 ||
	dataOut3 !== 5'd12 || dataOut4 !== 5'd13 || dataOut5 !== 5'd14 ||
	dataOut6 !== 5'd15 || dataOut7 !== 5'd16 || dataOut8 !== 5'd17) begin
	$display("test 2 FAILED: matrix manager did not output first matrix correctly");
end

column = 1'b1;

#20

// C
if (dataOut0 !== 5'd18 || dataOut1 !== 5'd19 || dataOut2 !== 5'd20 ||
	dataOut3 !== 5'd24 || dataOut4 !== 5'd25 || dataOut5 !== 5'd26 ||
	dataOut6 !== 5'd30 || dataOut7 !== 5'd31 || dataOut8 !== 5'd0) begin
	$display("test 3 FAILED: matrix manager did not output second matrix correctly");
end

next_row = 1'b0;

#20

// D
if (dataOut0 !== 5'd21 || dataOut1 !== 5'd22 || dataOut2 !== 5'd23 ||
	dataOut3 !== 5'd27 || dataOut4 !== 5'd28 || dataOut5 !== 5'd29 ||
	dataOut6 !== 5'd0 || dataOut7 !== 5'd0 || dataOut8 !== 5'd0) begin
	$display("test 4 FAILED: matrix manager did not output second matrix correctly");
end

next_row = 1'b1;
dm_we = 1'b1;

dataIn0 = 5'd0;
dataIn1 = 5'd1;
dataIn2 = 5'd2;
dataIn3 = 5'd3;
dataIn4 = 5'd4;
dataIn5 = 5'd5;
dataIn6 = 5'd6;
dataIn7 = 5'd7;
dataIn8 = 5'd8;

#10 // go to negedge

//E
if (dataOut0 !== 5'd0 || dataOut1 !== 5'd1 || dataOut2 !== 5'd2 ||
	dataOut3 !== 5'd3 || dataOut4 !== 5'd4 || dataOut5 !== 5'd5 ||
	dataOut6 !== 5'd6 || dataOut7 !== 5'd7 || dataOut8 !== 5'd8) begin
	$display("test 5 FAILED: matrix manager did not write result matrix correctly");
end

next_row = 1'b0;

dataIn0 = 5'd10;
dataIn1 = 5'd11;
dataIn2 = 5'd12;
dataIn3 = 5'd13;
dataIn4 = 5'd14;
dataIn5 = 5'd15;
dataIn6 = 5'd16;
dataIn7 = 5'd17;
dataIn8 = 5'd18;

#20

if (dataOut0 !== 5'd10 || dataOut1 !== 5'd11 || dataOut2 !== 5'd12 ||
	dataOut3 !== 5'd13 || dataOut4 !== 5'd14 || dataOut5 !== 5'd15 ||
	dataOut6 !== 5'd16 || dataOut7 !== 5'd17 || dataOut8 !== 5'd18) begin
	$display("test 6 FAILED: matrix manager did not write result matrix correctly");
end





$finish;



end

endmodule