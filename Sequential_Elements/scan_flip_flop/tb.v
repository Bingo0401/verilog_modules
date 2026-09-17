`timescale 1ns/1ps

module testbench;

reg Din;
reg Scan_in;
reg Scan_en;
reg clk;
wire Dout;

scan_flip_flop UUT (
    .Din(Din),
    .Scan_in(Scan_in),
    .Scan_en(Scan_en),
    .clk(clk),
    .Dout(Dout)
);

parameter integer HOLD_NS = 5;
parameter integer SETTLE_NS = 1;

integer errors = 0;
integer total_tests = 0;
integer all_errors = 0;
integer all_total_tests = 0;
integer d_index;
integer scan_index;
integer enable_index;
reg expected_value;
reg has_sampled = 0;

task automatic calculate_expected_value;
    begin
        expected_value = Scan_en ? Scan_in : Din;
    end
endtask

task automatic run_case;
    input normal_bit;
    input scan_bit;
    input enable_bit;
    begin
        // Change the inputs while the clock is low.
        Din = normal_bit;
        Scan_in = scan_bit;
        Scan_en = enable_bit;
        #(HOLD_NS);

        if (has_sampled && Dout !== expected_value) begin
            errors = errors + 1;
            $display("FAIL: output changed before clock edge");
        end

        calculate_expected_value();
        clk = 1'b1;
        #(SETTLE_NS);
        if (Dout !== expected_value) begin
            errors = errors + 1;
            $display("FAIL: Din=%b Scan_in=%b Scan_en=%b expected=%b got=%b",
                     normal_bit, scan_bit, enable_bit, expected_value, Dout);
        end else begin
            $display("PASS: Din=%b Scan_in=%b Scan_en=%b Dout=%b",
                     normal_bit, scan_bit, enable_bit, Dout);
        end
        has_sampled = 1;

        // The stored value must hold when mux inputs change between edges.
        Din = ~normal_bit;
        Scan_in = ~scan_bit;
        Scan_en = ~enable_bit;
        #(HOLD_NS);
        if (Dout !== expected_value) begin
            errors = errors + 1;
            $display("FAIL: output changed between clock edges");
        end

        clk = 1'b0;
        #(SETTLE_NS);
        total_tests = total_tests + 1;
    end
endtask

task automatic run_all_cases;
    begin
        for (enable_index = 0; enable_index < 2; enable_index = enable_index + 1)
            for (d_index = 0; d_index < 2; d_index = d_index + 1)
                for (scan_index = 0; scan_index < 2; scan_index = scan_index + 1)
                    run_case(d_index, scan_index, enable_index);

        all_errors = errors;
        all_total_tests = total_tests;
        if (all_errors == 0)
            $display("ALL SUMMARY: PASS (%0d tests)", all_total_tests);
        else
            $display("ALL SUMMARY: FAIL (%0d errors out of %0d tests)",
                     all_errors, all_total_tests);
    end
endtask

initial begin
    //$dumpfile("scan_flip_flop.vcd");
    //$dumpvars(0, testbench);
    //$fsdbDumpfile("tb.fsdb");
    //$fsdbDumpvars(0, tb);

    clk = 1'b0;
    Din = 1'b0;
    Scan_in = 1'b0;
    Scan_en = 1'b0;

    $display("This is a very awesome testbench designed by Bingo");
    $display("beginning test...............");
    $display("Each case is held for %0dns for clear waveform time frames.", HOLD_NS);
    $display("[ALL CASES]--------------------------------------------------");
    run_all_cases();

    if (all_errors != 0)
        $fatal(1, "Scan flip-flop test failed");
    $finish;
end

endmodule
