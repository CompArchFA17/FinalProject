module tis100(input signed[11:0] up,
              input signed[11:0] down
              input signed[11:0] left,
              input signed[11:0] right,
              output signed reg[11:0] upOut,
              output signed reg[11:0] downOut,
              output signed reg[11:0] leftOut,
              output signed reg[11:0] rightOut,
              output[3:0] requestWrite,
              output[3:0] ackRead,
              input[3:0]  dataReady,
              input[3:0]  ackWrite);

endmodule

//writing: set requestWrite high, block until ackWrite goes high
//reading: block until dataReady goes high, pulse ackRead

//instructions:
//NOP
//MOV
//SWP
//SAV
//ADD
//SUB
//NEG
//JMP
//JEZ
//JNZ
//JGZ
//JLZ
//JRO

//registers:
//ACC
//BACK

//ports:
//LEFT,RIGHT,UP,DOWN

//pseudo ports:
//ANY
//LAST
