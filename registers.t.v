`include "registers.v"

module test_registers();

reg clk, wrenable;
reg[5:0] n_in, m_in, p_in;
wire[5:0] n_out, m_out, p_out;
reg[4:0] a0_in, a1_in, a2_in, a3_in, a4_in, a5_in, a6_in, a7_in, a8_in;
reg[4:0] b0_in, b1_in, b2_in, b3_in, b4_in, b5_in, b6_in, b7_in, b8_in;
reg[4:0] c0_in, c1_in, c2_in, c3_in, c4_in, c5_in, c6_in, c7_in, c8_in;
wire[4:0] a0_out, a1_out, a2_out, a3_out, a4_out, a5_out, a6_out, a7_out, a8_out;
wire[4:0] b0_out, b1_out, b2_out, b3_out, b4_out, b5_out, b6_out, b7_out, b8_out;
wire[4:0] c0_out, c1_out, c2_out, c3_out, c4_out, c5_out, c6_out, c7_out, c8_out;

regfile dut (wrenable, n_in, m_in, p_in,
     n_out, m_out, p_out,
     a0_in, a1_in, a2_in, a3_in, a4_in, a5_in, a6_in, a7_in, a8_in,
     b0_in, b1_in, b2_in, b3_in, b4_in, b5_in, b6_in, b7_in, b8_in,
     c0_in, c1_in, c2_in, c3_in, c4_in, c5_in, c6_in, c7_in, c8_in,
     a0_out, a1_out, a2_out, a3_out, a4_out, a5_out, a6_out, a7_out, a8_out,
     b0_out, b1_out, b2_out, b3_out, b4_out, b5_out, b6_out, b7_out, b8_out,
     c0_out, c1_out, c2_out, c3_out, c4_out, c5_out, c6_out, c7_out, c8_out,
     clk);

genvar i;
initial begin

a0_in = 5'd0;
a1_in = 5'd1;
a2_in = 5'd2;
a3_in = 5'd3;
a4_in = 5'd4;
a5_in = 5'd5;
a6_in = 5'd6;
a7_in = 5'd7;
a8_in = 5'd8;
b0_in = 5'd9;
b1_in = 5'd10;
b2_in = 5'd11;
b3_in = 5'd12;
b4_in = 5'd13;
b5_in = 5'd14;
b6_in = 5'd15;
b7_in = 5'd16;
b8_in = 5'd17;
c0_in = 5'd18;
c1_in = 5'd19;
c2_in = 5'd20;
c3_in = 5'd21;
c4_in = 5'd22;
c5_in = 5'd23;
c6_in = 5'd24;
c7_in = 5'd25;
c8_in = 5'd26;
wrenable = 0;

clk = 0; #5
clk = 1; #5
clk = 0; #5

if (a0_out !== 5'd0 || a1_out !== 5'd0 || a2_out !== 5'd0 || 
a3_out !== 5'd0 || a4_out !== 5'd0 || a5_out !== 5'd0 || a6_out !== 5'd0 || 
a7_out !== 5'd0 || a8_out !== 5'd0 || b0_out !== 5'd0 || b1_out !== 5'd0 ||
b2_out !== 5'd0 || b3_out !== 5'd0 || b4_out !== 5'd0 || b5_out !== 5'd0 || 
b6_out !== 5'd0 || b7_out !== 5'd0 || b8_out !== 5'd0 || c0_out !== 5'd0 || 
c1_out !== 5'd0 || c2_out !== 5'd0 || c3_out !== 5'd0 || c4_out !== 5'd0 || 
c5_out !== 5'd0 || c6_out !== 5'd0 || c7_out !== 5'd0 || c8_out !== 5'd0) 

   $display("wrote to registers when wrenable was 0");

wrenable = 1;

clk = 0; #5
clk = 1; #5
clk = 0; #5

if (a0_out !== 5'd0 || a1_out !== 5'd1 || a2_out !== 5'd2 ||   
a3_out !== 5'd3 || a4_out !== 5'd4 || a5_out !== 5'd5 || a6_out !== 5'd6 ||
a7_out !== 5'd7 || a8_out !== 5'd8 || b0_out !== 5'd9 || b1_out !== 5'd10 || 
b2_out !== 5'd11 || b3_out !== 5'd12 || b4_out !== 5'd13 || b5_out !== 5'd14 || 
b6_out !== 5'd15 || b7_out !== 5'd16 || b8_out !== 5'd17 || c0_out !== 5'd18 || 
c1_out !== 5'd19 || c2_out !== 5'd20 || c3_out !== 5'd21 || c4_out !== 5'd22 || 
c5_out !== 5'd23 || c6_out !== 5'd24 || c7_out !== 5'd25 || c8_out !== 5'd26)  

   $display("wrote to registers incorrectly");


end

endmodule
