/*
The memory where matrices are stored.
*/

// TODO (arianaolson419): Allow multiple data access in some fashion. 
module prog_memory
#(
    parameter addresswidth  = 32,
    parameter depth         = addresswidth * 2,
    parameter width         = 5
)
(
    input 		      clk,
    output [width-1:0]        data,
    input [addresswidth-1:0]  addr
);


    reg [width-1:0] memory [depth-1:0];


    initial $readmemb("prog_mem.dat", memory);
    assign data = memory[addr];

endmodule
