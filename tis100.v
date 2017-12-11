`define RUN_MODE   2'd0
`define READ_MODE  2'd1
`define WRITE_MODE 2'd2

`define READ_PHASE  2'd0
`define EX_PHASE    2'd1
`define WRITE_PHASE 2'd2

`define READ_REQ_BIT  11
`define WRITE_REQ_BIT 12
`define READ_ACK_BIT  13
`define WRITE_ACK_BIT 14

//registers
`define NIL_ADDR   3'd0
`define ACC_ADDR   3'd1
//ports
`define LEFT_ADDR  3'd2
`define RIGHT_ADDR 3'd3
`define UP_ADDR    3'd4
`define DOWN_ADDR  3'd5
//pseudo ports
`define LAST_ADDR  3'd6
`define ANY_ADDR   3'd7

`define ADDR_SIZE 3
`define INST_SIZE 18


`define ADD  4'd0
`define SUB  4'd1
`define JRO  4'd2
`define MOV  4'd3
`define MOVI 4'd4
`define ADDI 4'd5
`define SUBI 4'd6
`define JROI 4'd7
`define SWP  4'd8
`define SAV  4'd9
`define NEG  4'd10
`define JMP  4'd11
`define JEZ  4'd12
`define JNZ  4'd13
`define JGZ  4'd14
`define JLZ  4'd15



module tis100(input clk,
              input[14:0] up,
              input[14:0] down
              input[14:0] left,
              input[14:0] right,
              output[14:0] upOut,
              output[14:0] downOut,
              output[14:0] leftOut,
              output[14:0] rightOut);

//internal registers
reg[2:0] mode;
reg[2:0] phase;
reg[`ADDR_SIZE-1:0] last;
reg[`ADDR_SIZE-1:0] writeTarget;
reg[`ADDR_SIZE-1:0] readTarget;
reg[10:0] readValue;
reg[10:0] writeValue;

reg[`INST_SIZE-1:0] instructions[15:0];
reg[3:0] PC;
reg[3:0] PCNEXT;

reg signed[10:0] ACC;
reg signed[10:0] BAK;

//port stuff
wire signed[10:0] regVals[7:0];
assign regVals[`NIL_ADDR] = 0;
assign regVals[`ACC_ADDR] = ACC;
assign regVals[`LEFT_ADDR] = left[10:0];
assign regVals[`RIGHT_ADDR] = right[10:0];
assign regVals[`UP_ADDR] = up[10:0];
assign regVals[`DOWN_ADDR] = down[10:0];

wire[5:2] portsHaveData;
assign portsHaveData[`LEFT_ADDR]  = left[`READ_REQ_BIT];
assign portsHaveData[`RIGHT_ADDR] = right[`READ_REQ_BIT];
assign portsHaveData[`UP_ADDR]    = up[`READ_REQ_BIT];
assign portsHaveData[`DOWN_ADDR]  = down[`READ_REQ_BIT];
wire anyHasData;
assign anyHasData = |portsHaveData[5:2];

reg[5:2] readAckOut;
assign leftOut[`WRITE_ACK_BIT]     = readAckOut[`LEFT_ADDR];
assign rightOut[`WRITE_ACK_BIT]    = readAckOut[`RIGHT_ADDR];
assign upOut[`WRITE_ACK_BIT]       = readAckOut[`UP_ADDR];
assign downOut[`WRITE_ACK_BIT]     = readAckOut[`DOWN_ADDR];

reg[5:2] weWantData;
assign leftOut[`WRITE_REQ_BIT]     = weWantData[`LEFT_ADDR];
assign rightOut[`WRITE_REQ_BIT]    = weWantData[`RIGHT_ADDR];
assign upOut[`WRITE_REQ_BIT]       = weWantData[`UP_ADDR];
assign downOut[`WRITE_REQ_BIT]     = weWantData[`DOWN_ADDR];

//decode
wire[INST_SIZE-1:0] instruction;
assign instruction = instructions[PC];

wire[3:0]            INST;
assign               INST[3:0] = instruction[17:14];
wire[`ADDR_SIZE-1:0] DST;
assign               DST[`ADDR_SIZE-1:0] = instruction[13:11];
wire[`ADDR_SIZE-1:0] SRC;
assign               SRC[`ADDR_SIZE-1:0] = instruction[10:8];
wire[3:0]            LABEL;
assign               LABEL[3:0] = instruction[13:10];
wire signed[11:0]    IMM;
assign               IMM[10:0] = instruction[10:0];


initial begin
   mode = `RUN_MODE;
   phase = `READ_PHASE
   last = `NIL_ADDR;
   ACC = 0;
   BAK = 0;
   PC = 0;
   readAckOut = 0;

   upOut    = 15'0;
   downOut  = 15'0;
   leftOut  = 15'0;
   rightOut = 15'0;
end

always @(posedge clk)
  case(mode)
    `RUN_MODE: begin
      case(phase)
        `READ_PHASE: begin
          if(INST < 4) begin //instruction has a SRC
            if(SRC < 2) begin //SRC is a register, not a port
              readValue <= regVals[SRC];
            end
            else if(SRC < 6) begin//src is a port, not a register
              if(portsHaveData[SRC]) begin//src has data now
                readValue <= regVals[SRC]
                
              end
            end
          end
          else begin//instruction has no SRC
          phase <= EX_PHASE;
          end
        end
        `EX_PHASE: begin
        end
        `WRITE_PHASE: begin
        end
      endcase
    end
    `READ_MODE: begin
    end
    `WRITE_MODE: begin
    end
  endcase
endmodule

//writing: set requestWrite high, block until ackWrite goes high
//reading: block until dataReady goes high, pulse ackRead

//instructions:
//NO ARG:


//R/I
//ADD : SRC
//SUB : SRC
//JRO : SRC
//MOV : SRC DST

//R
//NOP = ADD NIL
//SWP
//SAV
//NEG

//J type
//JMP : LABEL
//JEZ : LABEL
//JNZ : LABEL
//JGZ : LABEL
//JLZ : LABEL

//SRC : port or ACC or immediate
//DST : port or ACC
//LABEL : immediate

//registers:
//ACC
//BAK

//ports:
//LEFT,RIGHT,UP,DOWN

//pseudo ports:
//ANY : UP, LEFT, RIGHT, DOWN for write. LEFT, RIGHT, UP, DOWN for read
//LAST : If no last operation ignored
