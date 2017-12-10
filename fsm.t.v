`include "fsm.v"

module fsm_TEST();
	parameter NUM_TESTS = 5;

	reg[4:0] command;
	wire data_we;
	wire weA, weB, weC, weD, weE, weF, weG, weH;
	wire[1:0] jklm_sel;

	fsm dut (
		.command(command),
		.data_we(data_we),
		.weA(weA), .weB(weB), .weC(weC), .weD(weD),
		.weE(weE), .weF(weF), .weG(weG), .weH(weH),
		.jklm_select(jklm_sel)
	);

	reg[5:0] success_count = 0;

	initial begin
		$dumpfile("fsm.vcd");
		$dumpvars();

	// Test Case 1: load to block A
	command = 5'b0;
	#10

	if (data_we != 0) begin
		$display("Test Case 1 Failed: data_we not set correctly");
	end
	else if (weA === 1 & {weB, weC, weD, weE, weF, weG, weH} === 7'b0) begin
		// test passed
		success_count = success_count+1;
	end
	else begin
		$display("Test Case 1 Failed: write enables not set correctly");
	end

	// Test Case 2: load to block C
	command = 5'b00011;
	#10

	if (data_we != 0) begin
		$display("Test Case 2 Failed: data_we not set correctly");
	end
	else if (weD === 1 & {weA, weB, weC, weE, weF, weG, weH} === 7'b0) begin
		// test passed
		success_count = success_count+1;
	end
	else begin
		$display("Test Case 2 Failed: write enables not set correctly");
	end

	// Test Case 3: load to block H
	command = 5'b00111;
	#10

	if (data_we != 0) begin
		$display("Test Case 1 Failed: data_we not set correctly");
	end
	else if (weH === 1 & {weA, weB, weC, weD, weE, weF, weG} === 7'b0) begin
		// test passed
		success_count = success_count+1;
	end
	else begin
		$display("Test Case 3 Failed: write enables not set correctly");
	end

	// Test Case 4: store from block J
	command = 5'b01000;
	#10

	if (data_we != 1) begin
		$display("Test Case 4 Failed: data_we not set correctly");
	end
	else if ({weA, weB, weC, weD, weE, weF, weG, weH} != 8'b0) begin
		$display("Test Case 4 Failed: block we set on store");
	end
	else if (jklm_sel != 2'b00) begin
		$display("Test Case 4 Failed: jklm_select not correct");
	end
	else begin
		// test passed
		success_count = success_count+1;
	end
		
	// Test Case 5: store from block M
	command = 5'b01011;
	#10

	if (data_we != 1) begin
		$display("Test Case 5 Failed: data_we not set correctly");
	end
	else if ({weA, weB, weC, weD, weE, weF, weG, weH} != 8'b0) begin
		$display("Test Case 5 Failed: block we set on store");
	end
	else if (jklm_sel != 2'b11) begin
		$display("Test Case 5 Failed: jklm_select not correct");
	end
	else begin
		// test passed
		success_count = success_count+1;
	end


	if (success_count < NUM_TESTS) begin
		$display("\nFSM Failed %d Tests\n",(NUM_TESTS-success_count));
	end
	else begin
		$display("FSM Passed All %d tests", NUM_TESTS);
	end

        end
endmodule

