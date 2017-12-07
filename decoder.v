/*module decoder(
    DCtrl,
    RoundA,
    RoundB,
    Data_out
    );
    input DCtrl;
    input [128:0] RoundA;
    input [128:0] RoundB;
    output reg [128:0] Data_out; 

    //Whenever there is a change in the Data_in, execute the always block.
    always @(DCtrl)
    case (DCtrl)   //case statement. Check all the 8 combinations.
        0 : Data_out = RoundA;
        1 : Data_out = RoundB;
        //To make sure that latches are not created create a default value for output.
        default : Data_out = 8'b00000000; 
    endcase
endmodule
*/
module mux(
    Ctrl,
    RoundA,
    RoundB,
    Data_out
    );

    input Ctrl;
    input [127:0] RoundA;
    input [127:0] RoundB;
    output reg [127:0] Data_out; 

    //Whenever there is a change in the Data_in, execute the always block.
    always @(Ctrl)
    case (Ctrl)   //case statement. Check all the 8 combinations.
        0 : Data_out = RoundA;
        1 : Data_out = RoundB;
        //To make sure that latches are not created create a default value for output.
        default : Data_out = 8'b00000000; 
    endcase
endmodule



/*
module testdec();
    reg [5:0] counter;
    reg [7:0] RoundA;
    reg [7:0] RoundB;
    wire [7:0] Data_out; 
    
    decoder dec(counter, RoundA, RoundB, Data_out);
    
    initial begin
    	counter = 5'b010; RoundA = 8'b1111; RoundB = 8'b1;#20
    	$display("%b | %b | %b ", Data_out, RoundA, RoundB);
    end


endmodule*/
