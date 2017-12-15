//acts as read ANY, write ANY in terms of read, write presedence
//15 stack entries
`define READ_REQ_BIT  11
`define WRITE_REQ_BIT 12
`define READ_ACK_BIT  13
`define WRITE_ACK_BIT 14

`define READ_PHASE  2'd0
`define EX_PHASE    2'd1
`define WRITE_PHASE 2'd2
module stackMemory
  #(
    parameter loadmemory = 0,
    parameter memoryfile = "mem.dat",
    parameter initialpointer = 0
    )
   (input clk,
    input [14:0] in,
    output reg [14:0] out);
   reg [10:0] 		   mem [15:1];
   reg [3:0] 		   pointer;
   reg [2:0] 		   phase;

   initial begin
      phase = `READ_PHASE;
      pointer = initialpointer;
      out = 0;

      if(loadmemory)
	$readmemb(memoryfile, mem);
      if (pointer > 0) begin
	 out[10:0] = mem[pointer];
      end
   end

   always @(posedge in[`WRITE_ACK_BIT]) begin
      pointer = pointer - 1;
      if(pointer > 0) begin
	 out[10:0] = mem[pointer];
      end
   end

   always @(posedge in[`READ_ACK_BIT]) begin
      pointer = pointer -1;
      if (pointer > 0) begin
	 out[`READ_REQ_BIT] <= 1;
	 out[10:0] <= mem[pointer];
      end
      else
	out[`READ_REQ_BIT] <= 0;
   end

   always @(pointer) begin
      if(pointer < 15)
	out[`WRITE_REQ_BIT] <= 1;
      else
	out[`WRITE_REQ_BIT] <= 0;

      if (pointer > 0)
	out[`READ_REQ_BIT] <= 1;
      else
	out[`READ_REQ_BIT] <= 0;
   end // always @ (pointer)

   always @(posedge clk) begin
     case(phase)
       `READ_PHASE:
	 if(in[`READ_REQ_BIT]) begin
	    if(pointer < 15) begin
	       pointer = pointer + 1;
	       mem[pointer] = in[10:0];
	       out[`READ_ACK_BIT] <= 1;
	    end
	 end
       `EX_PHASE: begin

       end
       `WRITE_PHASE:
	 if(pointer > 0) begin
	    out[10:0] <= mem[pointer];
	    if(in[`WRITE_REQ_BIT]) begin
	       pointer = pointer - 1;
	       out[`WRITE_ACK_BIT] <= 1;
	    end
	 end

     endcase
   end // always @ (posedge clk)

   always @(negedge clk) begin
      if (phase == `WRITE_PHASE) begin
	 out[`READ_ACK_BIT] = 0;
	 out[`WRITE_ACK_BIT] = 0;
      end
      phase = (phase + 1) % 3;
   end


endmodule
