/*
Test bench for multiplier network
*/

`include "multiplier_network.v"

module multiplier_network_TEST();
	parameter ENTRY_SIZE = 5;
	reg clk, a_wrenable, b_wrenable, c_wrenable, d_wrenable;
	reg e_wrenable, f_wrenable, g_wrenable, h_wrenable;
	reg [1:0] res_sel;

	reg [ENTRY_SIZE - 1:0] ae0_in, ae1_in, ae2_in;
	reg [ENTRY_SIZE - 1:0] ae3_in, ae4_in, ae5_in;
	reg [ENTRY_SIZE - 1:0] ae6_in, ae7_in, ae8_in;

	reg [ENTRY_SIZE - 1:0] af0_in, af1_in, af2_in;
	reg [ENTRY_SIZE - 1:0] af3_in, af4_in, af5_in;
	reg [ENTRY_SIZE - 1:0] af6_in, af7_in, af8_in;

	reg [ENTRY_SIZE - 1:0] bg0_in, bg1_in, bg2_in;
	reg [ENTRY_SIZE - 1:0] bg3_in, bg4_in, bg5_in;
	reg [ENTRY_SIZE - 1:0] bg6_in, bg7_in, bg8_in;

	reg [ENTRY_SIZE - 1:0] bh0_in, bh1_in, bh2_in;
	reg [ENTRY_SIZE - 1:0] bh3_in, bh4_in, bh5_in;
	reg [ENTRY_SIZE - 1:0] bh6_in, bh7_in, bh8_in;

	reg [ENTRY_SIZE - 1:0] ce0_in, ce1_in, ce2_in;
	reg [ENTRY_SIZE - 1:0] ce3_in, ce4_in, ce5_in;
	reg [ENTRY_SIZE - 1:0] ce6_in, ce7_in, ce8_in;

	reg [ENTRY_SIZE - 1:0] cf0_in, cf1_in, cf2_in;
	reg [ENTRY_SIZE - 1:0] cf3_in, cf4_in, cf5_in;
	reg [ENTRY_SIZE - 1:0] cf6_in, cf7_in, cf8_in;

	reg [ENTRY_SIZE - 1:0] dg0_in, dg1_in, dg2_in;
	reg [ENTRY_SIZE - 1:0] dg3_in, dg4_in, dg5_in;
	reg [ENTRY_SIZE - 1:0] dg6_in, dg7_in, dg8_in;

	reg [ENTRY_SIZE - 1:0] dh0_in, dh1_in, dh2_in;
	reg [ENTRY_SIZE - 1:0] dh3_in, dh4_in, dh5_in;
	reg [ENTRY_SIZE - 1:0] dh6_in, dh7_in, dh8_in;
	
	wire [(9 * ENTRY_SIZE) - 1:0] result;

	multiplier_network #(.ENTRY_SIZE(ENTRY_SIZE)) dut (
		.clk(clk), .a_wrenable(a_wrenable), .b_wrenable(b_wrenable), .c_wrenable(c_wrenable),
		.d_wrenable(d_wrenable), .e_wrenable(e_wrenable), .f_wrenable(f_wrenable),
		.g_wrenable(g_wrenable), .h_wrenable(h_wrenable), .res_sel   (res_sel), .ae0_in    (ae0_in), .ae1_in    (ae1_in),
		.ae2_in    (ae2_in), .ae3_in    (ae3_in), .ae4_in    (ae4_in), .ae5_in    (ae5_in), .ae6_in    (ae6_in), .ae7_in    (ae7_in),
		.ae8_in    (ae8_in), .af0_in    (af0_in), .af1_in    (af1_in), .af2_in    (af2_in), .af3_in    (af3_in), .af4_in    (af4_in),
		.af5_in    (af5_in), .af6_in    (af6_in), .af7_in    (af7_in), .af8_in    (af8_in), .bg0_in    (bg0_in), .bg1_in    (bg1_in),
		.bg2_in    (bg2_in), .bg3_in    (bg3_in), .bg4_in    (bg4_in), .bg5_in    (bg5_in), .bg6_in    (bg6_in), .bg7_in    (bg7_in),
		.bg8_in    (bg8_in), .bh0_in    (bh0_in), .bh1_in    (bh1_in), .bh2_in    (bh2_in), .bh3_in    (bh3_in), .bh4_in    (bh4_in),
		.bh5_in    (bh5_in), .bh6_in    (bh6_in), .bh7_in    (bh7_in), .bh8_in    (bh8_in), .ce0_in    (ce0_in), .ce1_in    (ce1_in),
		.ce2_in    (ce2_in), .ce3_in    (ce3_in), .ce4_in    (ce4_in), .ce5_in    (ce5_in), .ce6_in    (ce6_in), .ce7_in    (ce7_in),
		.ce8_in    (ce8_in), .cf0_in    (cf0_in), .cf1_in    (cf1_in), .cf2_in    (cf2_in), .cf3_in    (cf3_in), .cf4_in    (cf4_in),
		.cf5_in    (cf5_in), .cf6_in    (cf6_in), .cf7_in    (cf7_in), .cf8_in    (cf8_in), .dg0_in    (dg0_in), .dg1_in    (dg1_in),
		.dg2_in    (dg2_in), .dg3_in    (dg3_in), .dg4_in    (dg4_in), .dg5_in    (dg5_in), .dg6_in    (dg6_in), .dg7_in    (dg7_in),
		.dg8_in    (dg8_in), .dh0_in    (dh0_in), .dh1_in    (dh1_in), .dh2_in    (dh2_in), .dh3_in    (dh3_in), .dh4_in    (dh4_in),
		.dh5_in    (dh5_in), .dh6_in    (dh6_in), .dh7_in    (dh7_in), .dh8_in    (dh8_in), .res       (result)
	);

	`define FALSE 1'b0
	`define TRUE 1'b1

	`define ZERO 5'b00000
	`define ONE 5'b00001

	`define ZERO_MAT {9{`ZERO}}
	`define ONE_MAT {9{`ONE}}
	`define ID_MAT {{`ONE}, {`ZERO}, {`ZERO}, {`ZERO}, {`ONE}, {`ZERO}, {`ZERO}, {`ZERO}, {`ONE}}
	`define MIX_MAT {{`ONE}, {`ONE}, {`ZERO}, {`ZERO}, {`ONE}, {`ZERO}, {`ZERO}, {`ONE}, {`ONE}}

	`define J 2'b00
	`define K 2'b01
	`define L 2'b10
	`define M 2'b11

	initial begin
		$dumpfile("multiplier_network.vcd");
		$dumpvars();
		a_wrenable = `FALSE; b_wrenable = `FALSE; c_wrenable = `FALSE; d_wrenable = `FALSE;
		e_wrenable = `FALSE; f_wrenable = `FALSE; g_wrenable = `FALSE; h_wrenable = `FALSE;

		// Load the submatrices of matrix "A"
		clk = 0; a_wrenable = `TRUE; b_wrenable = `TRUE; c_wrenable = `TRUE; d_wrenable = `TRUE; #50

		// A
		ae0_in = `ONE; ae1_in = `ZERO; ae2_in = `ZERO;
		ae3_in = `ZERO; ae4_in = `ONE; ae5_in = `ZERO;
		ae6_in = `ZERO; ae7_in = `ZERO; ae8_in = `ONE;

		af0_in = `ONE; af1_in = `ZERO; af2_in = `ZERO;
		af3_in = `ZERO; af4_in = `ONE; af5_in = `ZERO;
		af6_in = `ZERO; af7_in = `ZERO; af8_in = `ONE;

		// B 
		bg0_in = `ZERO; bg1_in = `ZERO; bg2_in = `ZERO;
		bg3_in = `ZERO; bg4_in = `ZERO; bg5_in = `ZERO;
		bg6_in = `ZERO; bg7_in = `ZERO; bg8_in = `ZERO;

		bh0_in = `ZERO; bh1_in = `ZERO; bh2_in = `ZERO;
		bh3_in = `ZERO; bh4_in = `ZERO; bh5_in = `ZERO;
		bh6_in = `ZERO; bh7_in = `ZERO; bh8_in = `ZERO;

		// C
		ce0_in = `ZERO; ce1_in = `ZERO; ce2_in = `ZERO;
		ce3_in = `ZERO; ce4_in = `ZERO; ce5_in = `ZERO;
		ce6_in = `ZERO; ce7_in = `ZERO; ce8_in = `ZERO;

		cf0_in = `ZERO; cf1_in = `ZERO; cf2_in = `ZERO;
		cf3_in = `ZERO; cf4_in = `ZERO; cf5_in = `ZERO;
		cf6_in = `ZERO; cf7_in = `ZERO; cf8_in = `ZERO;

		// D
		dg0_in = `ONE; dg1_in = `ZERO; dg2_in = `ZERO;
		dg3_in = `ZERO; dg4_in = `ONE; dg5_in = `ZERO;
		dg6_in = `ZERO; dg7_in = `ZERO; dg8_in = `ONE;

		dh0_in = `ONE; dh1_in = `ZERO; dh2_in = `ZERO;
		dh3_in = `ZERO; dh4_in = `ONE; dh5_in = `ZERO;
		dh6_in = `ZERO; dh7_in = `ZERO; dh8_in = `ONE;
		
		clk = 1; #50

		a_wrenable = `FALSE; b_wrenable = `FALSE; c_wrenable = `FALSE; d_wrenable = `FALSE;

		// Test correct loading of A
		if (
			{{dut.AE.a0_out}, {dut.AE.a1_out}, {dut.AE.a2_out},
			{dut.AE.a3_out}, {dut.AE.a4_out}, {dut.AE.a5_out},
			{dut.AE.a6_out}, {dut.AE.a7_out}, {dut.AE.a8_out}} !== `ID_MAT
		) begin
			$display("Test failed: wrong values loaded into A of AE");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.AE.a0_out, dut.AE.a1_out, dut.AE.a2_out,
				dut.AE.a3_out, dut.AE.a4_out, dut.AE.a5_out,
				dut.AE.a6_out, dut.AE.a7_out, dut.AE.a8_out
			);
		end

		if (
			{{dut.AF.a0_out}, {dut.AF.a1_out}, {dut.AF.a2_out},
			{dut.AF.a3_out}, {dut.AF.a4_out}, {dut.AF.a5_out},
			{dut.AF.a6_out}, {dut.AF.a7_out}, {dut.AF.a8_out}} !== `ID_MAT
		) begin
			$display("Test failed: wrong values loaded into A of AF");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.AF.a0_out, dut.AF.a1_out, dut.AF.a2_out,
				dut.AF.a3_out, dut.AF.a4_out, dut.AF.a5_out,
				dut.AF.a6_out, dut.AF.a7_out, dut.AF.a8_out
			);
		end

		// Test correct loading of B
		if (
			{{dut.BG.a0_out}, {dut.BG.a1_out}, {dut.BG.a2_out},
			{dut.BG.a3_out}, {dut.BG.a4_out}, {dut.BG.a5_out},
			{dut.BG.a6_out}, {dut.BG.a7_out}, {dut.BG.a8_out}} !== `ZERO_MAT
		) begin
			$display("Test failed: wrong values loaded into B of BG");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.BG.a0_out, dut.BG.a1_out, dut.BG.a2_out,
				dut.BG.a3_out, dut.BG.a4_out, dut.BG.a5_out,
				dut.BG.a6_out, dut.BG.a7_out, dut.BG.a8_out
			);
		end

		if (
			{{dut.BH.a0_out}, {dut.BH.a1_out}, {dut.BH.a2_out},
			{dut.BH.a3_out}, {dut.BH.a4_out}, {dut.BH.a5_out},
			{dut.BH.a6_out}, {dut.BH.a7_out}, {dut.BH.a8_out}} !== `ZERO_MAT
		) begin
			$display("Test failed: wrong values loaded into B of BH");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.BH.a0_out, dut.BH.a1_out, dut.BH.a2_out,
				dut.BH.a3_out, dut.BH.a4_out, dut.BH.a5_out,
				dut.BH.a6_out, dut.BH.a7_out, dut.BH.a8_out
			);
		end

		// Test correct loading of C
		if (
			{{dut.CE.a0_out}, {dut.CE.a1_out}, {dut.CE.a2_out},
			{dut.CE.a3_out}, {dut.CE.a4_out}, {dut.CE.a5_out},
			{dut.CE.a6_out}, {dut.CE.a7_out}, {dut.CE.a8_out}} !== `ZERO_MAT
		) begin
			$display("Test failed: wrong values loaded into C of CE");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.CE.a0_out, dut.CE.a1_out, dut.CE.a2_out,
				dut.CE.a3_out, dut.CE.a4_out, dut.CE.a5_out,
				dut.CE.a6_out, dut.CE.a7_out, dut.CE.a8_out
			);
		end

		if (
			{{dut.CF.a0_out}, {dut.CF.a1_out}, {dut.CF.a2_out},
			{dut.CF.a3_out}, {dut.CF.a4_out}, {dut.CF.a5_out},
			{dut.CF.a6_out}, {dut.CF.a7_out}, {dut.CF.a8_out}} !== `ZERO_MAT
		) begin
			$display("Test failed: wrong values loaded into C of CF");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.CF.a0_out, dut.CF.a1_out, dut.CF.a2_out,
				dut.CF.a3_out, dut.CF.a4_out, dut.CF.a5_out,
				dut.CF.a6_out, dut.CF.a7_out, dut.CF.a8_out
			);
		end

		// Test correct loading of D
		if (
			{{dut.DG.a0_out}, {dut.DG.a1_out}, {dut.DG.a2_out},
			{dut.DG.a3_out}, {dut.DG.a4_out}, {dut.DG.a5_out},
			{dut.DG.a6_out}, {dut.DG.a7_out}, {dut.DG.a8_out}} !== `ID_MAT
		) begin
			$display("Test failed: wrong values loaded into D of DG");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.DG.a0_out, dut.DG.a1_out, dut.DG.a2_out,
				dut.DG.a3_out, dut.DG.a4_out, dut.DG.a5_out,
				dut.DG.a6_out, dut.DG.a7_out, dut.DG.a8_out
			);
		end

		if (
			{{dut.DH.a0_out}, {dut.DH.a1_out}, {dut.DH.a2_out},
			{dut.DH.a3_out}, {dut.DH.a4_out}, {dut.DH.a5_out},
			{dut.DH.a6_out}, {dut.DH.a7_out}, {dut.DH.a8_out}} !== `ID_MAT
		) begin
			$display("Test failed: wrong values loaded into D of DH");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.DH.a0_out, dut.DH.a1_out, dut.DH.a2_out,
				dut.DH.a3_out, dut.DH.a4_out, dut.DH.a5_out,
				dut.DH.a6_out, dut.DH.a7_out, dut.DH.a8_out
			);
		end

		// Load submatrices of matrix "B"
		clk = 0; e_wrenable = `TRUE; f_wrenable = `TRUE; g_wrenable = `TRUE; h_wrenable = `TRUE; #50

		// E
		ae0_in = `ONE; ae1_in = `ONE; ae2_in = `ZERO;
		ae3_in = `ZERO; ae4_in = `ONE; ae5_in = `ZERO;
		ae6_in = `ZERO; ae7_in = `ONE; ae8_in = `ONE;

		ce0_in = `ONE; ce1_in = `ONE; ce2_in = `ZERO;
		ce3_in = `ZERO; ce4_in = `ONE; ce5_in = `ZERO;
		ce6_in = `ZERO; ce7_in = `ONE; ce8_in = `ONE;

		// F
		af0_in = `ONE; af1_in = `ONE; af2_in = `ONE;
		af3_in = `ONE; af4_in = `ONE; af5_in = `ONE;
		af6_in = `ONE; af7_in = `ONE; af8_in = `ONE;

		cf0_in = `ONE; cf1_in = `ONE; cf2_in = `ONE;
		cf3_in = `ONE; cf4_in = `ONE; cf5_in = `ONE;
		cf6_in = `ONE; cf7_in = `ONE; cf8_in = `ONE;

		// G
		bg0_in = `ONE; bg1_in = `ONE; bg2_in = `ZERO;
		bg3_in = `ZERO; bg4_in = `ONE; bg5_in = `ZERO;
		bg6_in = `ZERO; bg7_in = `ONE; bg8_in = `ONE;

		dg0_in = `ONE; dg1_in = `ONE; dg2_in = `ZERO;
		dg3_in = `ZERO; dg4_in = `ONE; dg5_in = `ZERO;
		dg6_in = `ZERO; dg7_in = `ONE; dg8_in = `ONE;

		// H
		bh0_in = `ONE; bh1_in = `ONE; bh2_in = `ONE;
		bh3_in = `ONE; bh4_in = `ONE; bh5_in = `ONE;
		bh6_in = `ONE; bh7_in = `ONE; bh8_in = `ONE;

		dh0_in = `ONE; dh1_in = `ONE; dh2_in = `ONE;
		dh3_in = `ONE; dh4_in = `ONE; dh5_in = `ONE;
		dh6_in = `ONE; dh7_in = `ONE; dh8_in = `ONE;

		clk = 1; #50

		e_wrenable = `FALSE; f_wrenable = `FALSE; g_wrenable = `FALSE; h_wrenable = `FALSE;

		clk = 0;

		// Test correct loading of E
		if (
			{{dut.AE.b0_out}, {dut.AE.b1_out}, {dut.AE.b2_out},
			{dut.AE.b3_out}, {dut.AE.b4_out}, {dut.AE.b5_out},
			{dut.AE.b6_out}, {dut.AE.b7_out}, {dut.AE.b8_out}} !== `MIX_MAT
		) begin
			$display("Test failed: wrong values loaded into E of AE");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.AE.b0_out, dut.AE.b1_out, dut.AE.b2_out,
				dut.AE.b3_out, dut.AE.b4_out, dut.AE.b5_out,
				dut.AE.b6_out, dut.AE.b7_out, dut.AE.b8_out
			);
		end

		if (
			{{dut.CE.b0_out}, {dut.CE.b1_out}, {dut.CE.b2_out},
			{dut.CE.b3_out}, {dut.CE.b4_out}, {dut.CE.b5_out},
			{dut.CE.b6_out}, {dut.CE.b7_out}, {dut.CE.b8_out}} !== `MIX_MAT
		) begin
			$display("Test failed: wrong values loaded into E of CE");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.CE.b0_out, dut.CE.b1_out, dut.CE.b2_out,
				dut.CE.b3_out, dut.CE.b4_out, dut.CE.b5_out,
				dut.CE.b6_out, dut.CE.b7_out, dut.CE.b8_out
			);
		end

		// Test correct loading of F
		if (
			{{dut.AF.b0_out}, {dut.AF.b1_out}, {dut.AF.b2_out},
			{dut.AF.b3_out}, {dut.AF.b4_out}, {dut.AF.b5_out},
			{dut.AF.b6_out}, {dut.AF.b7_out}, {dut.AF.b8_out}} !== `ONE_MAT
		) begin
			$display("Test failed: wrong values loaded into F of AF");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.AF.b0_out, dut.AF.b1_out, dut.AF.b2_out,
				dut.AF.b3_out, dut.AF.b4_out, dut.AF.b5_out,
				dut.AF.b6_out, dut.AF.b7_out, dut.AF.b8_out
			);
		end

		if (
			{{dut.CF.b0_out}, {dut.CF.b1_out}, {dut.CF.b2_out},
			{dut.CF.b3_out}, {dut.CF.b4_out}, {dut.CF.b5_out},
			{dut.CF.b6_out}, {dut.CF.b7_out}, {dut.CF.b8_out}} !== `ONE_MAT
		) begin
			$display("Test failed: wrong values loaded into F of CF");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.CF.b0_out, dut.CF.b1_out, dut.CF.b2_out,
				dut.CF.b3_out, dut.CF.b4_out, dut.CF.b5_out,
				dut.CF.b6_out, dut.CF.b7_out, dut.CF.b8_out
			);
		end


		// Test correct loading of G
		if (
			{{dut.BG.b0_out}, {dut.BG.b1_out}, {dut.BG.b2_out},
			{dut.BG.b3_out}, {dut.BG.b4_out}, {dut.BG.b5_out},
			{dut.BG.b6_out}, {dut.BG.b7_out}, {dut.BG.b8_out}} !== `MIX_MAT
		) begin
			$display("Test failed: wrong values loaded into G of BG");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.BG.b0_out, dut.BG.b1_out, dut.BG.b2_out,
				dut.BG.b3_out, dut.BG.b4_out, dut.BG.b5_out,
				dut.BG.b6_out, dut.BG.b7_out, dut.BG.b8_out
			);
		end

		if (
			{{dut.DG.b0_out}, {dut.DG.b1_out}, {dut.DG.b2_out},
			{dut.DG.b3_out}, {dut.DG.b4_out}, {dut.DG.b5_out},
			{dut.DG.b6_out}, {dut.DG.b7_out}, {dut.DG.b8_out}} !== `MIX_MAT
		) begin
			$display("Test failed: wrong values loaded into G of DG");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.DG.b0_out, dut.DG.b1_out, dut.DG.b2_out,
				dut.DG.b3_out, dut.DG.b4_out, dut.DG.b5_out,
				dut.DG.b6_out, dut.DG.b7_out, dut.DG.b8_out
			);
		end

		// Test correct loading of H
		if (
			{{dut.BH.b0_out}, {dut.BH.b1_out}, {dut.BH.b2_out},
			{dut.BH.b3_out}, {dut.BH.b4_out}, {dut.BH.b5_out},
			{dut.BH.b6_out}, {dut.BH.b7_out}, {dut.BH.b8_out}} !== `ONE_MAT
		) begin
			$display("Test failed: wrong values loaded into H of BH");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.BH.b0_out, dut.BH.b1_out, dut.BH.b2_out,
				dut.BH.b3_out, dut.BH.b4_out, dut.BH.b5_out,
				dut.BH.b6_out, dut.BH.b7_out, dut.BH.b8_out
			);
		end

		if (
			{{dut.DH.b0_out}, {dut.DH.b1_out}, {dut.DH.b2_out},
			{dut.DH.b3_out}, {dut.DH.b4_out}, {dut.DH.b5_out},
			{dut.DH.b6_out}, {dut.DH.b7_out}, {dut.DH.b8_out}} !== `ONE_MAT
		) begin
			$display("Test failed: wrong values loaded into H of DH");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				dut.DH.b0_out, dut.DH.b1_out, dut.DH.b2_out,
				dut.DH.b3_out, dut.DH.b4_out, dut.DH.b5_out,
				dut.DH.b6_out, dut.DH.b7_out, dut.DH.b8_out
			);
		end

		clk = 0; #50
		clk = 1;
		res_sel = `J; #10
		if (result !== `MIX_MAT) begin
			$display("Test failed: submatrix J contains wrong values");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				result[(9 * ENTRY_SIZE) - 1: (8 * ENTRY_SIZE)],
				result[(8 * ENTRY_SIZE) - 1: (7 * ENTRY_SIZE)],
				result[(7 * ENTRY_SIZE) - 1: (6 * ENTRY_SIZE)],
				result[(6 * ENTRY_SIZE) - 1: (5 * ENTRY_SIZE)],
				result[(5 * ENTRY_SIZE) - 1: (4 * ENTRY_SIZE)],
				result[(4 * ENTRY_SIZE) - 1: (3 * ENTRY_SIZE)],
				result[(3 * ENTRY_SIZE) - 1: (2 * ENTRY_SIZE)],
				result[(2 * ENTRY_SIZE) - 1: (1 * ENTRY_SIZE)],
				result[(1 * ENTRY_SIZE) - 1: (0 * ENTRY_SIZE)]
			);
		end

		res_sel = `K; #10
		if (result !== `ONE_MAT) begin
			$display("Test failed: submatrix K contains wrong values");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				result[(9 * ENTRY_SIZE) - 1: (8 * ENTRY_SIZE)],
				result[(8 * ENTRY_SIZE) - 1: (7 * ENTRY_SIZE)],
				result[(7 * ENTRY_SIZE) - 1: (6 * ENTRY_SIZE)],
				result[(6 * ENTRY_SIZE) - 1: (5 * ENTRY_SIZE)],
				result[(5 * ENTRY_SIZE) - 1: (4 * ENTRY_SIZE)],
				result[(4 * ENTRY_SIZE) - 1: (3 * ENTRY_SIZE)],
				result[(3 * ENTRY_SIZE) - 1: (2 * ENTRY_SIZE)],
				result[(2 * ENTRY_SIZE) - 1: (1 * ENTRY_SIZE)],
				result[(1 * ENTRY_SIZE) - 1: (0 * ENTRY_SIZE)]
			);
		end

		res_sel = `L; #10
		if (result !== `MIX_MAT) begin
			$display("Test failed: submatrix L contains wrong values");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				result[(9 * ENTRY_SIZE) - 1: (8 * ENTRY_SIZE)],
				result[(8 * ENTRY_SIZE) - 1: (7 * ENTRY_SIZE)],
				result[(7 * ENTRY_SIZE) - 1: (6 * ENTRY_SIZE)],
				result[(6 * ENTRY_SIZE) - 1: (5 * ENTRY_SIZE)],
				result[(5 * ENTRY_SIZE) - 1: (4 * ENTRY_SIZE)],
				result[(4 * ENTRY_SIZE) - 1: (3 * ENTRY_SIZE)],
				result[(3 * ENTRY_SIZE) - 1: (2 * ENTRY_SIZE)],
				result[(2 * ENTRY_SIZE) - 1: (1 * ENTRY_SIZE)],
				result[(1 * ENTRY_SIZE) - 1: (0 * ENTRY_SIZE)]
			);
		end

		res_sel = `M; #10
		if (result !== `ONE_MAT) begin
			$display("Test failed: submatrix M contains wrong values");
			$display("\t%d\t%d\t%d\n\t%d\t%d\t%d\n\t%d\t%d\t%d",
				result[(9 * ENTRY_SIZE) - 1: (8 * ENTRY_SIZE)],
				result[(8 * ENTRY_SIZE) - 1: (7 * ENTRY_SIZE)],
				result[(7 * ENTRY_SIZE) - 1: (6 * ENTRY_SIZE)],
				result[(6 * ENTRY_SIZE) - 1: (5 * ENTRY_SIZE)],
				result[(5 * ENTRY_SIZE) - 1: (4 * ENTRY_SIZE)],
				result[(4 * ENTRY_SIZE) - 1: (3 * ENTRY_SIZE)],
				result[(3 * ENTRY_SIZE) - 1: (2 * ENTRY_SIZE)],
				result[(2 * ENTRY_SIZE) - 1: (1 * ENTRY_SIZE)],
				result[(1 * ENTRY_SIZE) - 1: (0 * ENTRY_SIZE)]
			);
		end

		$finish;
	end
endmodule // multiplier_network_TEST