/*
Test bench for controller module.
*/

`include "controller.v"

module controller_TEST();
        parameter NUM_TESTS = 3;
        
        reg Clk;

        wire data_we;
        wire weA, weB, weC, weD, weE, weF, weG, weH;
        wire[1:0] jklm_select;
        wire next_row, column;

        controller dut(Clk, data_we, weA, weB, weC, weD, weE, weF, weG, weH, jklm_select, next_row, column);
        
        reg[5:0] success_count = 0;

        initial Clk = 0;
        integer i;
        
        initial #1000 $finish;

initial begin
        $dumpfile("controller.vcd");
        $dumpvars();

        #5
        // Test Case 1: command 1
        if (data_we != 0) begin
                $display("Test Case 1 Failed: data_we not set correctly");
        end
        else if (weA !== 1 & {weB, weC, weD, weE, weF, weG, weH} !== 7'b0) begin
                $display("Test Case 1 Failed: write enables not set correctly");
        end
        else if (next_row != 0) begin
                $display("Test Case 1 Failed: next row is signalled incorrectly");
        end
        else if (column != 0) begin
                $display("Test Case 1 Failed: column is signalled incorrectly");
        end
        else begin
                // test passed
                success_count = success_count+1;
        end


        // cycle clock
        Clk = 1;
        #5 Clk=0;
        #5

        // Test Case 2: command 2
        if (data_we != 0) begin
                $display("Test Case 2 Failed: data_we not set correctly");
        end
        else if (weB !== 1 & {weA, weC, weD, weE, weF, weG, weH} !== 7'b0) begin
                $display("Test Case 2 Failed: write enables not set correctly");
        end
        else if (next_row != 1) begin
                $display("Test Case 2 Failed: next row is signalled incorrectly");
        end
        else if (column != 0) begin
                $display("Test Case 2 Failed: column is signalled incorrectly");
        end
        else begin
                // test passed
                success_count = success_count+1;
        end

        // cycle clock 9 times
        for (i=0; i<9; i=i+1) begin
                Clk = 1;
                #5 Clk=0;
                #5;
        end

        // Test Case 3: command 11
        if (data_we != 1) begin
                $display("Test Case 3 Failed: data_we not set correctly");
        end
        else if ( {weA, weB, weC, weD, weE, weF, weG, weH} != 8'b0) begin
                $display("Test Case 3 Failed: write enable set on store cmd");
        end
        else if (jklm_select != 2'b10) begin
                $display("Test Case 3 Failed: mux select incorrect");
        end
        else if (next_row != 0) begin
                $display("Test Case 3 Failed: next row is signalled incorrectly");
        end
        else if (column != 1) begin
                $display("Test Case 3 Failed: column is signalled incorrectly");
        end
        else begin
                // test passed
                success_count = success_count+1;
                $display("what");
        end

        if (success_count < NUM_TESTS) begin
                $display("\nController Failed %d Tests\n",(NUM_TESTS-success_count));
        end
        else begin
                $display("Controller Passed All %d tests", NUM_TESTS);
        end

end
endmodule
