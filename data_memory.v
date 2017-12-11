/*
The memory where matrices are stored.
*/

module memory
#(
    parameter addresswidth  = 32,
    parameter depth         = addresswidth * 2,
    parameter width         = 32
)
(
    input                       clk,
    output [width-1:0]          data0, data1, data2, data3, data4,
    output [width-1:0]          data5, data6, data7, data8,
    input [addresswidth-1:0]    addr0, addr1, addr2, addr3, addr4,
    input [addresswidth-1:0]    addr5, addr6, addr7, addr8,
    input                       writeEnable,
    input [width-1:0]           dataIn0, dataIn1, dataIn2, dataIn3, dataIn4,
    input [width-1:0]           dataIn5, dataIn6, dataIn7, dataIn8
);


    reg [width-1:0] memory [depth-1:0];

    always @(negedge clk) begin
        if(writeEnable)
            memory[addr0 >> 2] <= dataIn0;
            memory[addr1 >> 2] <= dataIn1;
            memory[addr2 >> 2] <= dataIn2;
            memory[addr3 >> 2] <= dataIn3;
            memory[addr4 >> 2] <= dataIn4;
            memory[addr5 >> 2] <= dataIn5;
            memory[addr6 >> 2] <= dataIn6;
            memory[addr7 >> 2] <= dataIn7;
            memory[addr8 >> 2] <= dataIn8;
    end

    assign data0 = memory[addr0 >> 2];
    assign data1 = memory[addr1 >> 2];
    assign data2 = memory[addr2 >> 2];
    assign data3 = memory[addr3 >> 2];
    assign data4 = memory[addr4 >> 2];
    assign data5 = memory[addr5 >> 2];
    assign data6 = memory[addr6 >> 2];
    assign data7 = memory[addr7 >> 2];
    assign data8 = memory[addr8 >> 2];

    initial $readmemh("matrix_mem.dat", memory);

endmodule