`include "stackmemory.v"
module stackMemoryTestBench
  ();

   reg clk;
   reg dutpassed;
   wire [14:0] out;
   reg [10:0] val;
   reg [14:0]  in;
   reg [3:0]   testcase;
   reg [2:0]   phase;
   reg [5:0]   counter;
   
   
   always #10 clk = !clk;

   stackMemory #( .loadmemory(1), .initialpointer(4)) dut 
     (
      .clk(clk),
      .in(in),
      .out(out)
      );

   
   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0);
      clk <= 0;
      dutpassed <= 1;
      phase <= `READ_PHASE;
      in <= 0;
      testcase <= 0;
      counter <= 1;
      
      #30;//time to cycle clock
      //Test Case 0: check flags
      if(!out[`READ_REQ_BIT] || !out[`WRITE_REQ_BIT] || out[`READ_ACK_BIT] || out[`WRITE_ACK_BIT])
	dutpassed = 0;
      in[`WRITE_REQ_BIT] = 1;
      testcase = 1;
   end

   //Test Case 1: read a value 
   always @(posedge clk) begin
      if(testcase == 1 && phase == `READ_PHASE) begin
	 val <= out[10:0];
	 
	 if(val != 11'b10101110010)
	   dutpassed = 0;
	 in[`WRITE_ACK_BIT] <= 1;
	 in[`WRITE_REQ_BIT] <= 0;
	 
	 testcase = 2;
      end
   end

   //Test Case 2: write a value
   always @(posedge clk) begin
      if(testcase == 2 && phase == `WRITE_PHASE) begin
	 val = 11'hBA;
	 in[10:0] <= val;
	 in[`READ_REQ_BIT] <= 1;
      end
   end

   always @(posedge out[`READ_ACK_BIT]) begin
      if(testcase == 2) begin
	 in[`READ_REQ_BIT] <= 0;
	 
	 testcase = 3;
      end
   end

   //Test Case 3: read that value
   always @(posedge clk) begin
      if(testcase == 3 && phase == `READ_PHASE) begin
	 val = out[10:0];
	 
	 if(val != 11'hBA) begin
	    dutpassed = 0;
	 end
	 else begin
	    in[`WRITE_ACK_BIT] = 1;
	    testcase = 4;
	    in[`WRITE_REQ_BIT] = 1;
	 end
      end
   end

   //Test Case 4: read until empty
   always @(posedge out[`WRITE_ACK_BIT]) begin
      if(testcase == 4)
	 counter = counter +1;
   end

   always @(negedge out[`READ_REQ_BIT]) begin
      if(testcase == 4) begin
	 if(counter == 3) begin
	    in[`WRITE_REQ_BIT] = 0;
	    counter = 0;
	    in[10:0] = counter;
	    in[`READ_REQ_BIT] = 1;
	    testcase = 5;
 	 end
	 else
	   dutpassed = 0;
      end
   end // always @ (negedge out[`READ_REQ_BIT])

   //Test Case 5: write until full
   always @(posedge out[`READ_ACK_BIT]) begin
      if(testcase == 5) begin
	 counter = counter + 1;
	 in[10:0] = counter;
      end
   end

   always @(negedge out[`WRITE_REQ_BIT]) begin
      if(testcase == 5) begin
	 if(counter != 15)
	    dutpassed = 0;
	 else begin
	    $display("DUT Passed");
	    $finish();
	 end
      end
   end
      
   always @(negedge clk) begin
      if (phase == `WRITE_PHASE) begin
	 in[`READ_ACK_BIT] = 0;
	 in[`WRITE_ACK_BIT] = 0;
      end
      phase = (phase + 1) % 3;
   end

   always @(negedge dutpassed) begin
      $display("DUT Failed Test: %d", testcase);
      $finish();
   end

endmodule
