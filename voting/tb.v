module tb;

reg    [4:0] a0, a1, a2, a3, a4;
wire   [4:0] out;
wire   [2:0] count;

reg [4:0] exp_out;
reg [2:0] exp_count;
localparam integer HOLD_NS = 5;
localparam integer SETTLE_NS = 5;

integer total = 0;
integer errors = 0;
integer all_total = 0;
integer all_errors = 0;
integer i0, i1, i2, i3, i4;
reg [4:0] valid [0:4];

voting UUT (
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .a4(a4),
    .out(out),
    .count(count)
);


task automatic calculate_expected_value;
    input [4:0]   a0_in, a1_in, a2_in, a3_in, a4_in;
    reg [2:0] c0, c1, c2, c3, c4;
    begin
        c0 = a0_in[0] + a1_in[0] + a2_in[0] + a3_in[0] + a4_in[0];
        c1 = a0_in[1] + a1_in[1] + a2_in[1] + a3_in[1] + a4_in[1];
        c2 = a0_in[2] + a1_in[2] + a2_in[2] + a3_in[2] + a4_in[2];
        c3 = a0_in[3] + a1_in[3] + a2_in[3] + a3_in[3] + a4_in[3];
        c4 = a0_in[4] + a1_in[4] + a2_in[4] + a3_in[4] + a4_in[4];

        exp_out   = 5'b00000;
        exp_count = 3'b000;

        if (c4 >= c3 && c4 >= c2 && c4 >= c1 && c4 >= c0) begin
            exp_out   = 5'b10000;
            exp_count = c4;
        end else if (c3 >= c2 && c3 >= c1 && c3 >= c0) begin
            exp_out   = 5'b01000;
            exp_count = c3;
        end else if (c2 >= c1 && c2 >= c0) begin
            exp_out   = 5'b00100;
            exp_count = c2;
        end else if (c1 >= c0) begin
            exp_out   = 5'b00010;
            exp_count = c1;
        end else begin
            exp_out   = 5'b00001;
            exp_count = c0;
        end
    end
endtask


task automatic run_case;
    input [4:0]   a0_in, a1_in, a2_in, a3_in, a4_in;
    input [8*80-1:0] desc;
    begin
        a0 = a0_in; a1 = a1_in; a2 = a2_in; a3 = a3_in; a4 = a4_in;
        calculate_expected_value(a0_in, a1_in, a2_in, a3_in, a4_in);

        #(SETTLE_NS);
        if ((out !== exp_out) || (count !== exp_count)) begin
            $display("%6t | %b %b %b %b %b | %b    %b | %1d(%03b)   %1d(%03b) | %-6s | %-30s",
                     $time, a0, a1, a2, a3, a4, exp_out, out, exp_count, exp_count, count, count, "FAIL", desc);
            errors = errors + 1;
        end else begin
            $display("%6t | %b %b %b %b %b | %b    %b | %1d(%03b)   %1d(%03b) | %-6s | %-30s",
                     $time, a0, a1, a2, a3, a4, exp_out, out, exp_count, exp_count, count, count, "PASS", desc);
        end
        total = total + 1;
        #(HOLD_NS);
    end
endtask


task automatic run_all_cases;
    begin
        valid[0] = 5'b00001;
        valid[1] = 5'b00010;
        valid[2] = 5'b00100;
        valid[3] = 5'b01000;
        valid[4] = 5'b10000;

        for (i0 = 0; i0 < 5; i0 = i0 + 1) begin
            for (i1 = 0; i1 < 5; i1 = i1 + 1) begin
                for (i2 = 0; i2 < 5; i2 = i2 + 1) begin
                    for (i3 = 0; i3 < 5; i3 = i3 + 1) begin
                        for (i4 = 0; i4 < 5; i4 = i4 + 1) begin
                            a0 = valid[i0];
                            a1 = valid[i1];
                            a2 = valid[i2];
                            a3 = valid[i3];
                            a4 = valid[i4];
                            #0;
                            calculate_expected_value(a0, a1, a2, a3, a4);
                            all_total = all_total + 1;
                            if ((out !== exp_out) || (count !== exp_count)) begin
                                all_errors = all_errors + 1;
                                $display("ALL FAIL: case %0d a0=%b a1=%b a2=%b a3=%b a4=%b exp_out=%b out=%b exp_count=%0d count=%0d",
                                         all_total, a0, a1, a2, a3, a4, exp_out, out, exp_count, count);
                            end
                        end
                    end
                end
            end
        end

        if (all_errors == 0)
            $display("ALL SUMMARY: PASS (%0d tests)", all_total);
        else
            $display("ALL SUMMARY: FAIL (%0d errors out of %0d tests)", all_errors, all_total);
    end
endtask

//main part
initial begin


    //dumpfile("tb.vcd");
    //dumpvars(0, tb);
    //$fsdbDumpfile("tb.fsdb");
    //$fsdbDumpvars(0, tb);

    #5;
    $display("This is a very awesome testbench made by Bingo");
    $display("Each test is held for %0d and settles for %0d units", HOLD_NS, SETTLE_NS);
    $display("If there is a TIE the HIGHER PRIORITY BIT wins");
   
   
    $display("Testing...................");
    $display("[ALL CASES]-------------------------------------------------------------------------------------------");
    run_all_cases();


    $display("[SELECTED CASES]-------------------------------------------------------------------------------------------");
    $display(" time  |  a0    a1    a2    a3    a4   | exp_out  out   | exp_count  got_count | Result | Description");
    $display("----------------------------------------------------------------------------------------------------------------");
    $display("[MAIN FUNCTION CASES]-------------------------------------------------------------------------------------------");
    run_case(5'b10000, 5'b10000, 5'b10000, 5'b01000, 5'b00001, "main_1_example_from_TA");
    run_case(5'b00010, 5'b00010, 5'b00010, 5'b00010, 5'b00100, "main_2_clear_majority");
    run_case(5'b10000, 5'b01000, 5'b00100, 5'b00001, 5'b00001, "main_3_three_way_bottom");

    $display("[EDGE CASES]----------------------------------------------------------------------------------------------------");
    run_case(5'b10000, 5'b01000, 5'b00100, 5'b00010, 5'b00001, "edge_1_all_candidates_tie");
    run_case(5'b10000, 5'b10000, 5'b01000, 5'b01000, 5'b00001, "edge_2_two_way_top_tie");
    run_case(5'b00001, 5'b00001, 5'b00001, 5'b00001, 5'b00001, "edge_3__all_same");

    $display("[CORNER CASES]--------------------------------------------------------------------------------------------------");
    run_case(5'b00001, 5'b00001, 5'b00001, 5'b00001, 5'b00001, "corner_1_lowest_unanimous");
    run_case(5'b00010, 5'b00010, 5'b00001, 5'b00001, 5'b00100, "corner_2_low_bit_tie");
    run_case(5'b10000, 5'b01000, 5'b00100, 5'b00100, 5'b00010, "corner_3_valid_spread_repeat");

    $display("----------------------------------------------------------------------------------------------------------------");
    if (errors == 0)
        $display("SUMMARY: PASS (%0d/%0d)", total, total);
    else
        $display("SUMMARY: FAIL (%0d errors out of %0d)", errors, total);

    $finish;
end

endmodule

//coded by Bingo