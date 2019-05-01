module mux(
    Ctrl,
    RoundA,
    RoundB,
    Initial,
    RoundE,
    Data_out
    );

    input [1:0] Ctrl;
    input [127:0] RoundA;
    input [127:0] RoundB;
    input [127:0] Initial;
    input [127:0] RoundE;
    output reg [127:0] Data_out; 

    //Whenever there is a change in the Data_in, execute the always block.
    always @(*)
    case (Ctrl)   
        2'b00 : Data_out = RoundA;
        2'b01 : Data_out = RoundB;
        2'b10 : Data_out = Initial;
        2'b11 : Data_out = RoundE;        
        //To make sure that latches are not created create a default value for output.
        default : Data_out = 128'h7; 
    endcase
endmodule

module smallmux(
    Ctrl,
    Initial,
    Data_out
    );
    
	reg [127:0] zero = 128'b0;
    input Ctrl;
    input [127:0] Initial;
    output reg [127:0] Data_out; 

    //Whenever there is a change in the Data_in, execute the always block.
    always @(*)
    case (Ctrl)   //case statement. Check all the 8 combinations.
        0 : Data_out = zero;
        1 : Data_out = Initial;        
        //To make sure that latches are not created create a default value for output.
        default : Data_out = 128'h7; 
    endcase
endmodule

