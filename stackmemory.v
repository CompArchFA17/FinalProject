//acts as read ANY, write ANY in terms of read, write presedence
//15 stack entries
module stackmemory(input signed[11:0] up,
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
