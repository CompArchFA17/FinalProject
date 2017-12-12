/*
The full 6 by 6 multiplier.

Inputs:
	-clk: the system clock
*/

`include "controller.v"
`include "matrix_manager.v"
`include "multiplier_network.v"

module multiplier6by6(
	input clk
);
	wire data_we;
	wire weA, weB, weC, weD, weE, weF, weG, weH;
	wire[1:0] jklm_select;
	wire next_row, column;

	wire[4:0] dataOut0, dataOut1, dataOut2, dataOut3, dataOut4, dataOut5, dataOut6, dataOut7, dataOut8;

	wire[44:0] result;

	controller control (.clk(clk), .data_we(data_we), .weA(weA),
		.weB(weB), .weC(weC), .weD(weD), .weE(weE), .weF(weF),
		.weG(weG), .weH(weH), .jklm_select(jklm_select),
		.next_row(next_row), .column(column));

	multiplier_network network (
		.clk(clk),.res_sel(jklm_select), .a_wrenable(weA), .b_wrenable(weB),
		.c_wrenable(weC), .d_wrenable(weD), .e_wrenable(weE), .f_wrenable(weF), .g_wrenable(weG), .h_wrenable(weH),
		.ae0_in(dataOut0), .ae1_in(dataOut1), .ae2_in(dataOut2), .ae3_in(dataOut3), .ae4_in(dataOut4), .ae5_in(dataOut5), 
		.ae6_in(dataOut6), .ae7_in(dataOut7), .ae8_in(dataOut8),
		.af0_in(dataOut0), .af1_in(dataOut1), .af2_in(dataOut2), .af3_in(dataOut3), .af4_in(dataOut4), .af5_in(dataOut5), 
		.af6_in(dataOut6), .af7_in(dataOut7), .af8_in(dataOut8),
		.bg0_in(dataOut0), .bg1_in(dataOut1), .bg2_in(dataOut2), .bg3_in(dataOut3), .bg4_in(dataOut4), .bg5_in(dataOut5), 
		.bg6_in(dataOut6), .bg7_in(dataOut7), .bg8_in(dataOut8),
		.bh0_in(dataOut0), .bh1_in(dataOut1), .bh2_in(dataOut2), .bh3_in(dataOut3), .bh4_in(dataOut4), .bh5_in(dataOut5), 
		.bh6_in(dataOut6), .bh7_in(dataOut7), .bh8_in(dataOut8),
		.ce0_in(dataOut0), .ce1_in(dataOut1), .ce2_in(dataOut2), .ce3_in(dataOut3), .ce4_in(dataOut4), .ce5_in(dataOut5), 
		.ce6_in(dataOut6), .ce7_in(dataOut7), .ce8_in(dataOut8),
		.cf0_in(dataOut0), .cf1_in(dataOut1), .cf2_in(dataOut2), .cf3_in(dataOut3), .cf4_in(dataOut4), .cf5_in(dataOut5), 
		.cf6_in(dataOut6), .cf7_in(dataOut7), .cf8_in(dataOut8),
		.dg0_in(dataOut0), .dg1_in(dataOut1), .dg2_in(dataOut2), .dg3_in(dataOut3), .dg4_in(dataOut4), .dg5_in(dataOut5), 
		.dg6_in(dataOut6), .dg7_in(dataOut7), .dg8_in(dataOut8),
		.dh0_in(dataOut0), .dh1_in(dataOut1), .dh2_in(dataOut2), .dh3_in(dataOut3), .dh4_in(dataOut4), .dh5_in(dataOut5), 
		.dh6_in(dataOut6), .dh7_in(dataOut7), .dh8_in(dataOut8), .res(result)
		);

	matrix_manager #(.ADDR_WIDTH(32)) manager (.clk(clk), .dm_we(data_we),
		.next_row(next_row), .column(column), .n(6), .m(6), .p(6), .dataIn0 (result[44:40]), .dataIn1 (result[39:35]),
		.dataIn2 (result[34:30]), .dataIn3 (result[29:25]), .dataIn4 (result[24:20]), .dataIn5 (result[19:15]), .dataIn6 (result[14:10]),
		.dataIn7 (result[9:5]), .dataIn8 (result[4:0]), .dataOut0(dataOut0), .dataOut1(dataOut1),
		.dataOut2(dataOut2), .dataOut3(dataOut3), .dataOut4(dataOut4), .dataOut5(dataOut5),
		.dataOut6(dataOut6), .dataOut7(dataOut7), .dataOut8(dataOut8));
endmodule