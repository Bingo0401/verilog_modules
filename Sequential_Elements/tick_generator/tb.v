`timescale 1ns / 1ps

// Testbench for tick_generator
// This testbench is created based on Bingo's template structure.

module tb_tick_generator;

    // Parameters for the testbench
    localparam MASTER_CLK_FREQUENCY = 20; // Use a smaller value for faster simulation
    localparam CLK_PERIOD = 10;           // Clock period: 10 ns

    // Testbench signals
    reg  clk;
    reg  en;
    reg  clr;
    reg  reset;
    wire tick;

    // Instantiate the Device Under Test (DUT)
    tick_generator #(
        .MASTER_CLK_FREQUENCY(MASTER_CLK_FREQUENCY)
    ) dut (
        .clk(clk),
        .en(en),
        .clr(clr),
        .reset(reset),
        .tick(tick)
    );

    // Clock generator: 100 MHz clock
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        $display("Starting Testbench for tick_generator...");
        clk   = 0;
        reset = 1; // Assert reset initially
        en    = 0;
        clr   = 0;
        #(CLK_PERIOD * 2);

        // De-assert reset
        $display("Testing Asynchronous Reset...");
        reset = 0;
        #1; // Wait a delta cycle to see effect of de-asserting reset
        if (dut.cnt !== 0 || dut.tick !== 0) $error("Counter should be 0 after reset de-assertion.");

        // Test enable and tick generation
        $display("Testing tick generation...");
        en = 1;
        
        // Wait for the number of cycles for one tick
        repeat (MASTER_CLK_FREQUENCY) @(posedge clk);

        if (tick !== 1'b1) $error("FAIL: Tick did not fire when counter reached MAX_COUNT.");
        else $display("PASS: Tick fired correctly.");

        // Check if tick is a single-cycle pulse
        @(posedge clk);
        if (tick !== 1'b0) $error("FAIL: Tick did not de-assert after one cycle.");
        else $display("PASS: Tick is a single-cycle pulse.");

        // Test disable
        $display("Testing disable (en=0)...");
        en = 0;
        #(CLK_PERIOD * 5);
        if (dut.cnt !== 1) $error("FAIL: Counter should hold its value when disabled.");
        else $display("PASS: Counter holds value when disabled.");

        // Test synchronous clear
        $display("Testing Synchronous Clear...");
        en = 1;
        #(CLK_PERIOD * 5); // Let counter run for a few cycles
        
        clr = 1;
        @(posedge clk); // clr is synchronous
        #1;
        if (dut.cnt !== 0) $error("FAIL: Synchronous clear did not reset counter.");
        else $display("PASS: Synchronous clear works correctly.");
        clr = 0;

        $display("All tests completed.");
        $finish;
    end

endmodule

//coded by Bingo