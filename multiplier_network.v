/*
Network of 8 multiplier units
*/

`include "multiplier.v"
`include "add3by3.v"
`include "multiplexer.v"

module multiplier_network
	#(parameter ENTRY_SIZE = 5)(
	input clk,
	input [1:0] res_sel,
	input a_wrenable,
	input b_wrenable,
	input c_wrenable,
	input d_wrenable,
	input e_wrenable,
	input f_wrenable,
	input g_wrenable,
	input h_wrenable,
	input [ENTRY_SIZE - 1:0] ae0_in, ae1_in, ae2_in,
	input [ENTRY_SIZE - 1:0] ae3_in, ae4_in, ae5_in,
	input [ENTRY_SIZE - 1:0] ae6_in, ae7_in, ae8_in,
	input [ENTRY_SIZE - 1:0] af0_in, af1_in, af2_in,
	input [ENTRY_SIZE - 1:0] af3_in, af4_in, af5_in,
	input [ENTRY_SIZE - 1:0] af6_in, af7_in, af8_in,
	input [ENTRY_SIZE - 1:0] bg0_in, bg1_in, bg2_in,
	input [ENTRY_SIZE - 1:0] bg3_in, bg4_in, bg5_in,
	input [ENTRY_SIZE - 1:0] bg6_in, bg7_in, bg8_in,
	input [ENTRY_SIZE - 1:0] bh0_in, bh1_in, bh2_in,
	input [ENTRY_SIZE - 1:0] bh3_in, bh4_in, bh5_in,
	input [ENTRY_SIZE - 1:0] bh6_in, bh7_in, bh8_in,
	input [ENTRY_SIZE - 1:0] ce0_in, ce1_in, ce2_in,
	input [ENTRY_SIZE - 1:0] ce3_in, ce4_in, ce5_in,
	input [ENTRY_SIZE - 1:0] ce6_in, ce7_in, ce8_in,
	input [ENTRY_SIZE - 1:0] cf0_in, cf1_in, cf2_in,
	input [ENTRY_SIZE - 1:0] cf3_in, cf4_in, cf5_in,
	input [ENTRY_SIZE - 1:0] cf6_in, cf7_in, cf8_in,
	input [ENTRY_SIZE - 1:0] dg0_in, dg1_in, dg2_in,
	input [ENTRY_SIZE - 1:0] dg3_in, dg4_in, dg5_in,
	input [ENTRY_SIZE - 1:0] dg6_in, dg7_in, dg8_in,
	input [ENTRY_SIZE - 1:0] dh0_in, dh1_in, dh2_in,
	input [ENTRY_SIZE - 1:0] dh3_in, dh4_in, dh5_in,
	input [ENTRY_SIZE - 1:0] dh6_in, dh7_in, dh8_in,
	output [(9 * ENTRY_SIZE) - 1:0] res
);


	wire [ENTRY_SIZE - 1:0] ae0, ae1, ae2;
	wire [ENTRY_SIZE - 1:0] ae3, ae4, ae5;
	wire [ENTRY_SIZE - 1:0] ae6, ae7, ae8;
	wire [ENTRY_SIZE - 1:0] af0, af1, af2;
	wire [ENTRY_SIZE - 1:0] af3, af4, af5;
	wire [ENTRY_SIZE - 1:0] af6, af7, af8;
	wire [ENTRY_SIZE - 1:0] bg0, bg1, bg2;
	wire [ENTRY_SIZE - 1:0] bg3, bg4, bg5;
	wire [ENTRY_SIZE - 1:0] bg6, bg7, bg8;
	wire [ENTRY_SIZE - 1:0] bh0, bh1, bh2;
	wire [ENTRY_SIZE - 1:0] bh3, bh4, bh5;
	wire [ENTRY_SIZE - 1:0] bh6, bh7, bh8;
	wire [ENTRY_SIZE - 1:0] ce0, ce1, ce2;
	wire [ENTRY_SIZE - 1:0] ce3, ce4, ce5;
	wire [ENTRY_SIZE - 1:0] ce6, ce7, ce8;
	wire [ENTRY_SIZE - 1:0] cf0, cf1, cf2;
	wire [ENTRY_SIZE - 1:0] cf3, cf4, cf5;
	wire [ENTRY_SIZE - 1:0] cf6, cf7, cf8;
	wire [ENTRY_SIZE - 1:0] dg0, dg1, dg2;
	wire [ENTRY_SIZE - 1:0] dg3, dg4, dg5;
	wire [ENTRY_SIZE - 1:0] dg6, dg7, dg8;
	wire [ENTRY_SIZE - 1:0] dh0, dh1, dh2;
	wire [ENTRY_SIZE - 1:0] dh3, dh4, dh5;
	wire [ENTRY_SIZE - 1:0] dh6, dh7, dh8;

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) AE (
		.clk(clk), .a_wrenable(a_wrenable), .b_wrenable(e_wrenable),
		.a0_in(ae0_in), .a1_in(ae1_in), .a2_in(ae2_in), .a3_in(ae3_in),
		.a4_in(ae4_in), .a5_in(ae5_in), .a6_in(ae6_in), .a7_in(ae7_in), .a8_in(ae8_in),
		.b0_in(ae0_in), .b1_in(ae1_in), .b2_in(ae2_in), .b3_in(ae3_in),
		.b4_in(ae4_in), .b5_in(ae5_in), .b6_in(ae6_in), .b7_in(ae7_in), .b8_in(ae8_in),
		.c0_out(ae0), .c1_out(ae1), .c2_out(ae2), .c3_out(ae3),
		.c4_out(ae4), .c5_out(ae5), .c6_out(ae6), .c7_out(ae7), .c8_out(ae8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) AF (
		.clk(clk), .a_wrenable(a_wrenable), .b_wrenable(f_wrenable),
		.a0_in(af0_in), .a1_in(af1_in), .a2_in(af2_in), .a3_in(af3_in),
		.a4_in(af4_in), .a5_in(af5_in), .a6_in(af6_in), .a7_in(af7_in), .a8_in(af8_in),
		.b0_in(af0_in), .b1_in(af1_in), .b2_in(af2_in), .b3_in(af3_in),
		.b4_in(af4_in), .b5_in(af5_in), .b6_in(af6_in), .b7_in(af7_in), .b8_in(af8_in),
		.c0_out(af0), .c1_out(af1), .c2_out(af2), .c3_out(af3),
		.c4_out(af4), .c5_out(af5), .c6_out(af6), .c7_out(af7), .c8_out(af8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) BG (
		.clk(clk), .a_wrenable(b_wrenable), .b_wrenable(g_wrenable),
		.a0_in(bg0_in), .a1_in(bg1_in), .a2_in(bg2_in), .a3_in(bg3_in),
		.a4_in(bg4_in), .a5_in(bg5_in), .a6_in(bg6_in), .a7_in(bg7_in), .a8_in(bg8_in),
		.b0_in(bg0_in), .b1_in(bg1_in), .b2_in(bg2_in), .b3_in(bg3_in),
		.b4_in(bg4_in), .b5_in(bg5_in), .b6_in(bg6_in), .b7_in(bg7_in), .b8_in(bg8_in),
		.c0_out(bg0), .c1_out(bg1), .c2_out(bg2), .c3_out(bg3),
		.c4_out(bg4), .c5_out(bg5), .c6_out(bg6), .c7_out(bg7), .c8_out(bg8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) BH (
		.clk(clk), .a_wrenable(b_wrenable), .b_wrenable(h_wrenable),
		.a0_in(bh0_in), .a1_in(bh1_in), .a2_in(bh2_in), .a3_in(bh3_in),
		.a4_in(bh4_in), .a5_in(bh5_in), .a6_in(bh6_in), .a7_in(bh7_in), .a8_in(bh8_in),
		.b0_in(bh0_in), .b1_in(bh1_in), .b2_in(bh2_in), .b3_in(bh3_in),
		.b4_in(bh4_in), .b5_in(bh5_in), .b6_in(bh6_in), .b7_in(bh7_in), .b8_in(bh8_in),
		.c0_out(bh0), .c1_out(bh1), .c2_out(bh2), .c3_out(bh3),
		.c4_out(bh4), .c5_out(bh5), .c6_out(bh6), .c7_out(bh7), .c8_out(bh8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) CE (
		.clk(clk), .a_wrenable(c_wrenable), .b_wrenable(e_wrenable),
		.a0_in(ce0_in), .a1_in(ce1_in), .a2_in(ce2_in), .a3_in(ce3_in),
		.a4_in(ce4_in), .a5_in(ce5_in), .a6_in(ce6_in), .a7_in(ce7_in), .a8_in(ce8_in),
		.b0_in(ce0_in), .b1_in(ce1_in), .b2_in(ce2_in), .b3_in(ce3_in),
		.b4_in(ce4_in), .b5_in(ce5_in), .b6_in(ce6_in), .b7_in(ce7_in), .b8_in(ce8_in),
		.c0_out(ce0), .c1_out(ce1), .c2_out(ce2), .c3_out(ce3),
		.c4_out(ce4), .c5_out(ce5), .c6_out(ce6), .c7_out(ce7), .c8_out(ce8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) CF (
		.clk(clk), .a_wrenable(c_wrenable), .b_wrenable(f_wrenable),
		.a0_in(cf0_in), .a1_in(cf1_in), .a2_in(cf2_in), .a3_in(cf3_in),
		.a4_in(cf4_in), .a5_in(cf5_in), .a6_in(cf6_in), .a7_in(cf7_in), .a8_in(cf8_in),
		.b0_in(cf0_in), .b1_in(cf1_in), .b2_in(cf2_in), .b3_in(cf3_in),
		.b4_in(cf4_in), .b5_in(cf5_in), .b6_in(cf6_in), .b7_in(cf7_in), .b8_in(cf8_in),
		.c0_out(cf0), .c1_out(cf1), .c2_out(cf2), .c3_out(cf3),
		.c4_out(cf4), .c5_out(cf5), .c6_out(cf6), .c7_out(cf7), .c8_out(cf8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) DG (
		.clk(clk), .a_wrenable(d_wrenable), .b_wrenable(g_wrenable),
		.a0_in(dg0_in), .a1_in(dg1_in), .a2_in(dg2_in), .a3_in(dg3_in),
		.a4_in(dg4_in), .a5_in(dg5_in), .a6_in(dg6_in), .a7_in(dg7_in), .a8_in(dg8_in),
		.b0_in(dg0_in), .b1_in(dg1_in), .b2_in(dg2_in), .b3_in(dg3_in),
		.b4_in(dg4_in), .b5_in(dg5_in), .b6_in(dg6_in), .b7_in(dg7_in), .b8_in(dg8_in),
		.c0_out(dg0), .c1_out(dg1), .c2_out(dg2), .c3_out(dg3),
		.c4_out(dg4), .c5_out(dg5), .c6_out(dg6), .c7_out(dg7), .c8_out(dg8)
	);

	multiplier #(.ENTRY_SIZE(ENTRY_SIZE)) DH (
		.clk(clk), .a_wrenable(d_wrenable), .b_wrenable(h_wrenable),
		.a0_in(dh0_in), .a1_in(dh1_in), .a2_in(dh2_in), .a3_in(dh3_in),
		.a4_in(dh4_in), .a5_in(dh5_in), .a6_in(dh6_in), .a7_in(dh7_in), .a8_in(dh8_in),
		.b0_in(dh0_in), .b1_in(dh1_in), .b2_in(dh2_in), .b3_in(dh3_in),
		.b4_in(dh4_in), .b5_in(dh5_in), .b6_in(dh6_in), .b7_in(dh7_in), .b8_in(dh8_in),
		.c0_out(dh0), .c1_out(dh1), .c2_out(dh2), .c3_out(dh3),
		.c4_out(dh4), .c5_out(dh5), .c6_out(dh6), .c7_out(dh7), .c8_out(dh8)
	);

	wire [ENTRY_SIZE - 1:0] ae_bg_sum0, ae_bg_sum1, ae_bg_sum2;
	wire [ENTRY_SIZE - 1:0] ae_bg_sum3, ae_bg_sum4, ae_bg_sum5;
	wire [ENTRY_SIZE - 1:0] ae_bg_sum6, ae_bg_sum7, ae_bg_sum8;
	wire [ENTRY_SIZE - 1:0] af_bh_sum0, af_bh_sum1, af_bh_sum2;
	wire [ENTRY_SIZE - 1:0] af_bh_sum3, af_bh_sum4, af_bh_sum5;
	wire [ENTRY_SIZE - 1:0] af_bh_sum6, af_bh_sum7, af_bh_sum8;
	wire [ENTRY_SIZE - 1:0] ce_dg_sum0, ce_dg_sum1, ce_dg_sum2;
	wire [ENTRY_SIZE - 1:0] ce_dg_sum3, ce_dg_sum4, ce_dg_sum5;
	wire [ENTRY_SIZE - 1:0] ce_dg_sum6, ce_dg_sum7, ce_dg_sum8;
	wire [ENTRY_SIZE - 1:0] cf_dh_sum0, cf_dh_sum1, cf_dh_sum2;
	wire [ENTRY_SIZE - 1:0] cf_dh_sum3, cf_dh_sum4, cf_dh_sum5;
	wire [ENTRY_SIZE - 1:0] cf_dh_sum6, cf_dh_sum7, cf_dh_sum8;

	add3by3 #(.ENTRY_SIZE(ENTRY_SIZE)) AEplusBG (
		.a0(ae0), .a1(ae1), .a2(ae2), .a3(ae3), .a4(ae4), .a5(ae5), .a6(ae6), .a7(ae7), .a8(ae8),
		.b0(bg0), .b1(bg1), .b2(bg2), .b3(bg3), .b4(bg4), .b5(bg5), .b6(bg6), .b7(bg7), .b8(bg8),
		.c0(ae_bg_sum0), .c1(ae_bg_sum1), .c2(ae_bg_sum2), .c3(ae_bg_sum3), .c4(ae_bg_sum4),
		.c5(ae_bg_sum5), .c6(ae_bg_sum6), .c7(ae_bg_sum7), .c8(ae_bg_sum8)
	);

	add3by3 #(.ENTRY_SIZE(ENTRY_SIZE)) AFplusBH (
		.a0(af0), .a1(af1), .a2(af2), .a3(af3), .a4(af4), .a5(af5), .a6(af6), .a7(af7), .a8(af8),
		.b0(bh0), .b1(bh1), .b2(bh2), .b3(bh3), .b4(bh4), .b5(bh5), .b6(bh6), .b7(bh7), .b8(bh8),
		.c0(af_bh_sum0), .c1(af_bh_sum1), .c2(af_bh_sum2), .c3(af_bh_sum3), .c4(af_bh_sum4),
		.c5(af_bh_sum5), .c6(af_bh_sum6), .c7(af_bh_sum7), .c8(af_bh_sum8)
	);

	add3by3 #(.ENTRY_SIZE(ENTRY_SIZE)) CEplusDG (
		.a0(ce0), .a1(ce1), .a2(ce2), .a3(ce3), .a4(ce4), .a5(ce5), .a6(ce6), .a7(ce7), .a8(ce8),
		.b0(dg0), .b1(dg1), .b2(dg2), .b3(dg3), .b4(dg4), .b5(dg5), .b6(dg6), .b7(dg7), .b8(dg8),
		.c0(ce_dg_sum0), .c1(ce_dg_sum1), .c2(ce_dg_sum2), .c3(ce_dg_sum3), .c4(ce_dg_sum4),
		.c5(ce_dg_sum5), .c6(ce_dg_sum6), .c7(ce_dg_sum7), .c8(ce_dg_sum8)
	);

	add3by3 #(.ENTRY_SIZE(ENTRY_SIZE)) CFplusDH (
		.a0(cf0), .a1(cf1), .a2(cf2), .a3(cf3), .a4(cf4), .a5(cf5), .a6(cf6), .a7(cf7), .a8(cf8),
		.b0(dh0), .b1(dh1), .b2(dh2), .b3(dh3), .b4(dh4), .b5(dh5), .b6(dh6), .b7(dh7), .b8(dh8),
		.c0(cf_dh_sum0), .c1(cf_dh_sum1), .c2(cf_dh_sum2), .c3(cf_dh_sum3), .c4(cf_dh_sum4),
		.c5(cf_dh_sum5), .c6(cf_dh_sum6), .c7(cf_dh_sum7), .c8(cf_dh_sum8)
	);

	`define AEBG {{ae_bg_sum0}, {ae_bg_sum1}, {ae_bg_sum2}, {ae_bg_sum3}, {ae_bg_sum4}, {ae_bg_sum5}, {ae_bg_sum6}, {ae_bg_sum7}, {ae_bg_sum8}}
	`define AFBH {{af_bh_sum0}, {af_bh_sum1}, {af_bh_sum2}, {af_bh_sum3}, {af_bh_sum4}, {af_bh_sum5}, {af_bh_sum6}, {af_bh_sum7}, {af_bh_sum8}}
	`define CEDG {{ce_dg_sum0}, {ce_dg_sum1}, {ce_dg_sum2}, {ce_dg_sum3}, {ce_dg_sum4}, {ce_dg_sum5}, {ce_dg_sum6}, {ce_dg_sum7}, {ce_dg_sum8}}
	`define CFDH {{cf_dh_sum0}, {cf_dh_sum1}, {cf_dh_sum2}, {cf_dh_sum3}, {cf_dh_sum4}, {cf_dh_sum5}, {cf_dh_sum6}, {cf_dh_sum7}, {cf_dh_sum8}}

	multiplexer4to1 #(
		.ENTRY_SIZE(ENTRY_SIZE)) chooseres (.res_sel (res_sel), .AEplusBG(`AEBG), .AFplusBH(`AFBH),
		.CEplusDG(`CEDG), .CFplusDH(`CFDH), .result  (res)
	);


endmodule // multiplier_network