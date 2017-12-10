module register #(parameter width = 5'd4, parameter init = {width{1'd0}})
(

    output reg[width-1:0]    q,
    input[width-1:0]         d,
    input               wrenable,
    input               clk
);

    initial begin
        q={width{1'b0}}+init;
    end
  
    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end

endmodule

module regfile
#(parameter width = 5)
(
    input a_wrenable,
    input b_wrenable,
    input c_wrenable,
    input[width - 1:0] a0_in, a1_in, a2_in, a3_in, a4_in, a5_in, a6_in, a7_in, a8_in,
    input[width - 1:0] b0_in, b1_in, b2_in, b3_in, b4_in, b5_in, b6_in, b7_in, b8_in,
    input[width - 1:0] c0_in, c1_in, c2_in, c3_in, c4_in, c5_in, c6_in, c7_in, c8_in,
    output[width - 1:0] a0_out, a1_out, a2_out, a3_out, a4_out, a5_out, a6_out, a7_out, a8_out,
    output[width - 1:0] b0_out, b1_out, b2_out, b3_out, b4_out, b5_out, b6_out, b7_out, b8_out,
    output[width - 1:0] c0_out, c1_out, c2_out, c3_out, c4_out, c5_out, c6_out, c7_out, c8_out,
    input clk
);
register #(.width(width)) 
    a0_reg(.d(a0_in),
            .q(a0_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a1_reg(.d(a1_in),
            .q(a1_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a2_reg(.d(a2_in),
            .q(a2_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a3_reg(.d(a3_in),
            .q(a3_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a4_reg(.d(a4_in),
            .q(a4_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a5_reg(.d(a5_in),
            .q(a5_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a6_reg(.d(a6_in),
            .q(a6_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a7_reg(.d(a7_in),
            .q(a7_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    a8_reg(.d(a8_in),
            .q(a8_out),
            .wrenable(a_wrenable),
            .clk(clk));
register #(.width(width))
    b0_reg(.d(b0_in),
            .q(b0_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b1_reg(.d(b1_in),
            .q(b1_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b2_reg(.d(b2_in),
            .q(b2_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b3_reg(.d(b3_in),
            .q(b3_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b4_reg(.d(b4_in),
            .q(b4_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b5_reg(.d(b5_in),
            .q(b5_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b6_reg(.d(b6_in),
            .q(b6_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b7_reg(.d(b7_in),
            .q(b7_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    b8_reg(.d(b8_in),
            .q(b8_out),
            .wrenable(b_wrenable),
            .clk(clk));
register #(.width(width))
    c0_reg(.d(c0_in),
            .q(c0_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c1_reg(.d(c1_in),
            .q(c1_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c2_reg(.d(c2_in),
            .q(c2_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c3_reg(.d(c3_in),
            .q(c3_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c4_reg(.d(c4_in),
            .q(c4_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c5_reg(.d(c5_in),
            .q(c5_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c6_reg(.d(c6_in),
            .q(c6_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c7_reg(.d(c7_in),
            .q(c7_out),
            .wrenable(c_wrenable),
            .clk(clk));
register #(.width(width))
    c8_reg(.d(c8_in),
            .q(c8_out),
            .wrenable(c_wrenable),
            .clk(clk));
endmodule
