`timescale 1ns / 1ps

module tb_synchronous_counter;

    // Parameters
    parameter WIDTH = 3;

    // Inputs
    reg clk;
    reg reset;
    reg en;
    reg clr;

    // Outputs
    wire [WIDTH-1:0] count;

    // Expected values and error tracking
    reg [WIDTH-1:0] expected_count;
    integer errors;
    integer i;

    // Instantiate the Unit Under Test (UUT)
    synchronous_counter #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .reset(reset),
        .en(en),
        .clr(clr),
        .count(count)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        reset = 1'b1;
        en = 1'b0;
        clr = 1'b0;
        errors = 0;
        expected_count = 0;

        // Dump waves for GTKWave/ModelSim
        $dumpfile("synchronous_counter.vcd");
        $dumpvars(0, tb_synchronous_counter);

        $display("\nStarting Synchronous Counter Testbench");
        $display(" Time(ns) | RST EN CLR | Expected | Actual | Check");
        $display("----------------------------------------------------------");

        // Test 1: Reset behavior
        @(negedge clk);
        check_output("RESET   ");

        // Test 2: Release reset, enable counting (tests wrap-around 7->0)
        reset = 1'b0;
        en = 1'b1;
        for (i = 1; i <= 8; i = i + 1) begin
            @(negedge clk);
            expected_count = (i == 8) ? 3'd0 : i[WIDTH-1:0];
            check_output("COUNT   ");
        end

        // Test 3: Clear override (clear should reset counter even if en is high)
        clr = 1'b1;
        @(negedge clk);
        expected_count = 3'd0;
        check_output("CLEAR   ");

        // Test 4: Release clear, disable enable (should hold value)
        clr = 1'b0;
        en = 1'b0;
        @(negedge clk);
        expected_count = 3'd0; 
        check_output("HOLD    ");

        // Test 5: Count a few steps, then verify reset takes priority over enable
        en = 1'b1;
        @(negedge clk); expected_count = 3'd1; check_output("COUNT1  ");
        @(negedge clk); expected_count = 3'd2; check_output("COUNT2  ");
        
        reset = 1'b1;
        @(negedge clk); expected_count = 3'd0; check_output("RST_OVR ");
        
        if (errors == 0) begin
            $display("\n[PASS] All tests passed.");
        end else begin
            $display("\n[FAIL] Total errors: %0d", errors);
        end
        
        $finish;
    end

    // Task to check output at the negative edge
    task check_output;
        input [63:0] step_name;
        begin
            if (count !== expected_count) begin
                $display("%9d |  %1b   %1b   %1b  |      %3b |    %3b | FAIL (%0s)", 
                         $time, reset, en, clr, expected_count, count, step_name);
                errors = errors + 1;
            end else begin
                $display("%9d |  %1b   %1b   %1b  |      %3b |    %3b | PASS (%0s)", 
                         $time, reset, en, clr, expected_count, count, step_name);
            end
        end
    endtask

endmodule