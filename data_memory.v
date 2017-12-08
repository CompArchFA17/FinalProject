/*
The memory where matrices are stored.
*/

// TODO (arianaolson419): Allow multiple data access in some fashion.
module memory
#(
    parameter addresswidth  = 32,
    parameter depth         = addresswidth * 2,
    parameter width         = 32
)
(
    input 		                clk,
    output [width-1:0]      dataOut,
    input [addresswidth-1:0]    address,
    input                       writeEnable,
    input [width-1:0]           dataIn
);


    reg [width-1:0] memory [depth-1:0];

    always @(negedge clk) begin
        if(writeEnable)
            memory[address >> 2] <= dataIn;
    end
    assign dataOut = memory[address >> 2];

    initial $readmemh("matrix_mem.dat", memory);

endmodule