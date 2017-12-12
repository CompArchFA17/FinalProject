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
              input[14:0] down,
              input[14:0] left,
              input[14:0] right,
              output[14:0] upOut,
              output[14:0] downOut,
              output[14:0] leftOut,
              output[14:0] rightOut,
              output signed[10:0] accOut);

parameter memFile = "memory.dat";

//internal registers
reg[2:0] mode;
reg[2:0] phase;
reg[`ADDR_SIZE-1:0] last;
reg[`ADDR_SIZE-1:0] writeTarget;
reg[`ADDR_SIZE-1:0] readTarget;
reg signed[10:0] readValue;
reg signed[10:0] writeValue;

reg[`INST_SIZE-1:0] instructions[0:15];
reg[3:0] PC;
reg[3:0] PCNEXT;

reg signed[10:0] ACC;
reg signed[10:0] BAK;
assign accOut = ACC;

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

wire[5:2] portsWantData;
assign portsWantData[`LEFT_ADDR]  = left[`WRITE_REQ_BIT];
assign portsWantData[`RIGHT_ADDR] = right[`WRITE_REQ_BIT];
assign portsWantData[`UP_ADDR]    = up[`WRITE_REQ_BIT];
assign portsWantData[`DOWN_ADDR]  = down[`WRITE_REQ_BIT];
wire anyWantData;
assign anyWantData = |portsWantData[5:2];

wire[5:2] readAckIn;
assign readAckIn[`LEFT_ADDR]  = left[`READ_ACK_BIT];
assign readAckIn[`RIGHT_ADDR] = right[`READ_ACK_BIT];
assign readAckIn[`UP_ADDR]    = up[`READ_ACK_BIT];
assign readAckIn[`DOWN_ADDR]  = down[`READ_ACK_BIT];
wire anyReadAck;
assign anyReadAck = |readAckIn[5:2];

wire[5:2] writeAckIn;
assign writeAckIn[`LEFT_ADDR]  = left[`WRITE_ACK_BIT];
assign writeAckIn[`RIGHT_ADDR] = right[`WRITE_ACK_BIT];
assign writeAckIn[`UP_ADDR]    = up[`WRITE_ACK_BIT];
assign writeAckIn[`DOWN_ADDR]  = down[`WRITE_ACK_BIT];
wire anyWriteAck;
assign anyWriteAck = |writeAckIn[5:2];

reg[5:2] readAckOut;
assign leftOut[`WRITE_ACK_BIT]     = readAckOut[`LEFT_ADDR];
assign rightOut[`WRITE_ACK_BIT]    = readAckOut[`RIGHT_ADDR];
assign upOut[`WRITE_ACK_BIT]       = readAckOut[`UP_ADDR];
assign downOut[`WRITE_ACK_BIT]     = readAckOut[`DOWN_ADDR];

reg[5:2] writeAckOut;
assign leftOut[`READ_ACK_BIT]     = writeAckOut[`LEFT_ADDR];
assign rightOut[`READ_ACK_BIT]    = writeAckOut[`RIGHT_ADDR];
assign upOut[`READ_ACK_BIT]       = writeAckOut[`UP_ADDR];
assign downOut[`READ_ACK_BIT]     = writeAckOut[`DOWN_ADDR];

reg[5:2] weWantData;
assign leftOut[`WRITE_REQ_BIT]     = weWantData[`LEFT_ADDR];
assign rightOut[`WRITE_REQ_BIT]    = weWantData[`RIGHT_ADDR];
assign upOut[`WRITE_REQ_BIT]       = weWantData[`UP_ADDR];
assign downOut[`WRITE_REQ_BIT]     = weWantData[`DOWN_ADDR];

reg[5:2] weHaveData;
assign leftOut[`READ_REQ_BIT]     = weHaveData[`LEFT_ADDR];
assign rightOut[`READ_REQ_BIT]    = weHaveData[`RIGHT_ADDR];
assign upOut[`READ_REQ_BIT]       = weHaveData[`UP_ADDR];
assign downOut[`READ_REQ_BIT]     = weHaveData[`DOWN_ADDR];

//decode
wire[`INST_SIZE-1:0] instruction;
assign instruction = instructions[PC];

reg signed[10:0] outVals[5:2];

assign upOut[10:0]    = outVals[`UP_ADDR];
assign downOut[10:0]  = outVals[`DOWN_ADDR];
assign leftOut[10:0]  = outVals[`LEFT_ADDR];
assign rightOut[10:0] = outVals[`RIGHT_ADDR];


wire[3:0]            INST;
assign               INST[3:0] = instruction[17:14];
wire[`ADDR_SIZE-1:0] DST;
assign               DST[`ADDR_SIZE-1:0] = instruction[13:11];
wire[`ADDR_SIZE-1:0] SRC;
assign               SRC[`ADDR_SIZE-1:0] = instruction[10:8];
wire[3:0]            LABEL;
assign               LABEL[3:0] = instruction[13:10];
wire signed[10:0]    IMM;
assign               IMM[10:0] = instruction[10:0];


initial begin
   mode = `RUN_MODE;
   phase = `READ_PHASE;
   last = `NIL_ADDR;
   ACC = 0;
   BAK = 0;
   PC = 0;
   readAckOut = 0;
   weWantData = 0;
   writeAckOut = 0;
   weHaveData = 0;

   outVals[`UP_ADDR]    = 0;
   outVals[`DOWN_ADDR]  = 0;
   outVals[`LEFT_ADDR]  = 0;
   outVals[`RIGHT_ADDR] = 0;

   $readmemb(memFile, instructions);
end

always @(posedge clk) begin
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
                readValue <= regVals[SRC];
                readAckOut[SRC] <= 1;
                last <= SRC;
              end
              else begin //src has no data now
                mode <= `READ_MODE;
                readTarget <= SRC;
                weWantData[SRC] <= 1;
                last <= SRC;
              end
            end//src is a port
            else if (SRC == `LAST_ADDR) begin//src is LAST
              if(last == `NIL_ADDR) begin//edge case, last is NIL still
                readValue <= regVals[last];
              end
              else begin//last is a port
                if(portsHaveData[last]) begin//last has data now
                  readValue <= regVals[last];
                  readAckOut[last] <= 1;
                end
                else begin
                  mode <= `READ_MODE;
                  readTarget <= last;
                  weWantData[last] <= 1;
                end
              end//last is a port
            end//src is last
            else if (SRC == `ANY_ADDR) begin//src is ANY
              if(anyHasData) begin//any port has data
                if(portsHaveData[`LEFT_ADDR]) begin
                  readValue <= regVals[`LEFT_ADDR];
                  readAckOut[`LEFT_ADDR] <= 1;
                  last <= `LEFT_ADDR;
                end
                else if(portsHaveData[`RIGHT_ADDR]) begin
                  readValue <= regVals[`RIGHT_ADDR];
                  readAckOut[`RIGHT_ADDR] <= 1;
                  last <= `RIGHT_ADDR;
                end
                else if(portsHaveData[`UP_ADDR]) begin
                  readValue <= regVals[`UP_ADDR];
                  readAckOut[`UP_ADDR] <= 1;
                  last <= `UP_ADDR;
                end
                else if(portsHaveData[`DOWN_ADDR]) begin
                  readValue <= regVals[`DOWN_ADDR];
                  readAckOut[`DOWN_ADDR] <= 1;
                  last <= `DOWN_ADDR;
                end
              end//any port has data
              else begin//no port has data
                mode <= `READ_MODE;
                readTarget <= SRC;
                weWantData[`UP_ADDR] <= 1;
                weWantData[`DOWN_ADDR] <= 1;
                weWantData[`LEFT_ADDR] <= 1;
                weWantData[`RIGHT_ADDR] <= 1;
              end
            end//src is ANY
          end//instruction has a SRC
          phase <= `EX_PHASE;
        end//READ_PHASE
        `EX_PHASE: begin
          case(INST)
          `ADD: begin
            ACC <= ACC + readValue;
            PCNEXT <= PC + 1;
          end
          `SUB: begin
            ACC <= ACC - readValue;
            PCNEXT <= PC + 1;
          end
          `JRO: begin
            PCNEXT <= PC + readValue;
          end
          `MOV: begin
            writeValue <= readValue;
            PCNEXT <= PC + 1;
          end
          `MOVI: begin
            writeValue <= IMM;
            PCNEXT <= PC + 1;
          end
          `ADDI: begin
            ACC <= ACC + IMM;
            PCNEXT <= PC + 1;
          end
          `SUBI: begin
            ACC <= ACC - IMM;
            PCNEXT <= PC + 1;
          end
          `JROI: begin
            PCNEXT <= PC + IMM;
          end
          `SWP: begin
            ACC <= BAK;
            BAK <= ACC;
            PCNEXT <= PC + 1;
          end
          `SAV: begin
            BAK <= ACC;
            PCNEXT <= PC + 1;
          end
          `NEG: begin
            ACC <= -ACC;
            PCNEXT <= PC + 1;
          end
          `JMP: begin
            PCNEXT <= LABEL;
          end
          `JEZ: begin
            if(ACC == 0) PCNEXT <= LABEL;
            else PCNEXT <= PC + 1;
          end
          `JNZ: begin
            if(ACC != 0) PCNEXT <= LABEL;
            else PCNEXT <= PC + 1;
          end
          `JGZ: begin
            if(ACC > 0) PCNEXT <= LABEL;
            else PCNEXT <= PC + 1;
          end
          `JLZ: begin
            if(ACC < 0) PCNEXT <= LABEL;
            else PCNEXT <= PC + 1;
          end
          endcase
          phase <= `WRITE_PHASE;
        end//ex phase
        `WRITE_PHASE: begin
          if(INST == `MOV || INST == `MOVI) begin //inst has dst
            if(DST < 2 || (DST == `LAST_ADDR && last == `NIL_ADDR)) begin//DST is a register
              if(DST == `ACC_ADDR) begin
                ACC <= writeValue;
              end
            end//dst is a register
            else begin//dst is a port or pseudo port
              mode <= `WRITE_MODE;
              if(DST == `LAST_ADDR) begin
                writeTarget <= last;
                outVals[last] <= writeValue;
                weHaveData[last] <= 1;
              end
              else if(DST != `ANY_ADDR) begin
                writeTarget <= DST;
                outVals[DST] <= writeValue;
                weHaveData[DST] <= 1;
                last <= DST;
              end
              else begin//ANY
                if(anyWantData) begin//someone wants data
                  if(portsWantData[`UP_ADDR]) begin
                    writeTarget <= `UP_ADDR;
                    weHaveData[`UP_ADDR] <= 1;
                    outVals[`UP_ADDR] <= writeValue;
                    last <= `UP_ADDR;
                  end
                  else if(portsWantData[`LEFT_ADDR]) begin
                    writeTarget <= `LEFT_ADDR;
                    weHaveData[`LEFT_ADDR] <= 1;
                    outVals[`LEFT_ADDR] <= writeValue;
                    last <= `LEFT_ADDR;
                  end
                  else if(portsWantData[`RIGHT_ADDR]) begin
                    writeTarget <= `RIGHT_ADDR;
                    weHaveData[`RIGHT_ADDR] <= 1;
                    outVals[`RIGHT_ADDR] <= writeValue;
                    last <= `RIGHT_ADDR;
                  end
                  else if(portsWantData[`DOWN_ADDR]) begin
                    writeTarget <= `DOWN_ADDR;
                    weHaveData[`DOWN_ADDR] <= 1;
                    outVals[`DOWN_ADDR] <= writeValue;
                    last <= `DOWN_ADDR;
                  end
                end
                else begin//no one wants data
                  writeTarget <= DST;
                end
              end
            end
          end//inst has dst
          phase <= `READ_PHASE;
        end
      endcase
    end
    `READ_MODE: begin
      case(phase)
        `READ_PHASE: begin
          if(readTarget == `ANY_ADDR) begin
            if(anyHasData) begin
              mode <= `RUN_MODE;
              weWantData = 4'd0;
              if(portsHaveData[`LEFT_ADDR]) begin
                readValue <= regVals[`LEFT_ADDR];
                readAckOut[`LEFT_ADDR] <= 1;
                last <= `LEFT_ADDR;
              end
              else if(portsHaveData[`RIGHT_ADDR]) begin
                readValue <= regVals[`RIGHT_ADDR];
                readAckOut[`RIGHT_ADDR] <= 1;
                last <= `RIGHT_ADDR;
              end
              else if(portsHaveData[`UP_ADDR]) begin
                readValue <= regVals[`UP_ADDR];
                readAckOut[`UP_ADDR] <= 1;
                last <= `UP_ADDR;
              end
              else if(portsHaveData[`DOWN_ADDR]) begin
                readValue <= regVals[`DOWN_ADDR];
                readAckOut[`DOWN_ADDR] <= 1;
                last <= `DOWN_ADDR;
              end
            end
          end//target is not ANY
          else begin
            if(portsHaveData[readTarget]) begin//readTarget has data now
              mode <= `RUN_MODE;
              readValue <= regVals[readTarget];
              readAckOut[readTarget] <= 1;
              weWantData[readTarget] <= 0;
              last <= readTarget;
            end
          end
          phase <= `EX_PHASE;
        end
        `EX_PHASE: begin
          phase <= `WRITE_PHASE;
        end
        `WRITE_PHASE: begin
          phase <= `READ_PHASE;
        end
      endcase
    end
    `WRITE_MODE: begin
      case(phase)
        `READ_PHASE: begin
          phase <= `EX_PHASE;
        end
        `EX_PHASE: begin
          if(writeTarget == `ANY_ADDR) begin
            if(anyWantData) begin//someone wants data
              if(portsWantData[`UP_ADDR]) begin
                writeTarget <= `UP_ADDR;
                weHaveData[`UP_ADDR] <= 1;
                outVals[`UP_ADDR] <= writeValue;
                last <= `UP_ADDR;
              end
              else if(portsWantData[`LEFT_ADDR]) begin
                writeTarget <= `LEFT_ADDR;
                weHaveData[`LEFT_ADDR] <= 1;
                outVals[`LEFT_ADDR] <= writeValue;
                last <= `LEFT_ADDR;
              end
              else if(portsWantData[`RIGHT_ADDR]) begin
                writeTarget <= `RIGHT_ADDR;
                weHaveData[`RIGHT_ADDR] <= 1;
                outVals[`RIGHT_ADDR] <= writeValue;
                last <= `RIGHT_ADDR;
              end
              else if(portsWantData[`DOWN_ADDR]) begin
                writeTarget <= `DOWN_ADDR;
                weHaveData[`DOWN_ADDR] <= 1;
                outVals[`DOWN_ADDR] <= writeValue;
                last <= `DOWN_ADDR;
              end
            end
          end
          phase <= `WRITE_PHASE;
        end
        `WRITE_PHASE: begin
          if(writeTarget != `ANY_ADDR) begin//target is not any
            if(writeAckIn[writeTarget]) begin//write was acked
              weHaveData[writeTarget] = 0;
              mode <= `RUN_MODE;
              last <= writeTarget;
            end
          end
          phase <= `READ_PHASE;
        end
      endcase
    end
  endcase
end

always @(negedge clk) begin
  if(phase == `READ_PHASE && mode == `RUN_MODE && ^PCNEXT !== 1'bx) begin
    PC <= PCNEXT;
  end
  if(phase == `READ_PHASE) begin
    readAckOut = 4'd0;
  end
end

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
