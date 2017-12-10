/*
Test bench for program memory module.
*/

`include "prog_memory.v"

module memory_TEST();
	parameter ENTRY_SIZE = 5;
	parameter ADDRESS_WIDTH = 32;
	parameter NUM_TESTS = 3;

	reg clk;
	reg [ADDRESS_WIDTH - 1:0] addr;

	wire [ENTRY_SIZE - 1:0] data;

	memory #(.width(ENTRY_SIZE), .addresswidth(ADDRESS_WIDTH)) dut(
		.clk(clk), .data(data),
		.addr(addr)
	);

	reg[5:0] success_count = 0;

	initial clk = 0;
	always #10 clk = !clk;
	initial begin
		$dumpfile("prog_memory.vcd");
		$dumpvars(0, memory_TEST, dut.memory[0]);


		// Test Case 1: Read first memory element
		addr = 32'd0;
		#20
		if (data === 5'b0) begin
			success_count = success_count + 1;
		end
		else begin
			$display("Test case 1 failed: expected %b got %b", 5'b0, data);
		end

		// Test Case 2: Read second memory element
		addr = 32'd1;
		#20
		if (data === 5'b1) begin
			success_count = success_count + 1;
		end
		else begin
			$display("Test case 2 failed: expected %b got %b", 5'b1, data);
		end

		// Test Case 3: Read tenth memory element
		addr = 32'd9;
		#20
		if (data === 5'b01001) begin
			success_count = success_count + 1;
		end
		else begin
			$display("Test case 3 failed: expected %b got %b", 5'b01001, data);
		end

		#10

        	if (success_count < NUM_TESTS) begin
                	$display("\nProgram Memory Failed %d Tests\n",(NUM_TESTS-success_count));
        	end
	        else begin
        	        $display("Program Memory Passed All %d tests", NUM_TESTS);
	        end


		$finish;
	end
endmodule
