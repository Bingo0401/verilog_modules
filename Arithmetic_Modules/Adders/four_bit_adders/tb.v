`timescale  10ns/1ps




module tb;

four_bit_adder UUT(
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);

reg [3:0] A;
reg [3:0] B;
reg Cin;
wire [3:0] S;
wire Cout;

reg exp_Cout;
reg [3:0] exp_S;

parameter integer HOLD_NS = 5;
parameter integer SETTLE_NS = 5;

integer errors = 0;
integer total_tests = 0;
integer all_errors = 0;
integer all_total_tests = 0;
integer i = 0;


task automatic calculate_expected_value;

// Net

    input Cin;
    input [3:0] A;
    input [3:0] B;
    reg [4:0] weighted_S;
// Logic 
    begin
        
        weighted_S = A[3:0] + B[3:0] + Cin;
        exp_Cout = weighted_S[4];
        exp_S = weighted_S [3:0];

    end
endtask




task automatic run_case;
//NET
    begin

        #(SETTLE_NS);

        if ((S !== exp_S) || (Cout !== exp_Cout)) begin
            errors = errors + 1;
            $display();
        end else begin
            $display();
        end

        #(HOLD_NS);
    end
endtask


task automatic run_all_cases;
    begin
        all_errors = 0;
        all_total_tests  = 0;
        

        for (i = 0; i <= 'b111111111; i = i + 1) begin

            {Cin, A, B} = i[8:0];
            #(SETTLE_NS);
            calculate_expected_value(Cin, A, B);
            if ((S !== exp_S) || (Cout !== exp_Cout)) begin
                all_errors = all_errors + 1;
                $display("ERROR {Cin, A, B} = { %0b, %3b, %3b} S: %3b Cout: %0b Golden:S: %3b Cout: %0b", Cin, A, B, S, Cout, exp_S, exp_Cout);
            end
            #(HOLD_NS);
            all_total_tests =all_total_tests + 1;
        end


        if (all_errors == 0)
            $display("ALL SUMMARY: PASS (%0d tests)", all_total_tests);
        else
            $display("ALL SUMMARY: FAIL (%0d errors out of %0d tests)", all_errors, all_total_tests);
    end
endtask



initial begin

//WaveForm File    

    //$fsdbDumpfile("tb.fsdb");
    //$fsdbDumpvars(0, tb);
    //$dumpfile("tb.vcd");
    //$dumpfile(0, tb);


    errors = 0;
    total_tests  = 0;


    $display("This is a very awesome testbench designed by Bingo");
    $display("beginning test...............");

    $display("Each case is held for %0dns for clear waveform time frames.", HOLD_NS, "\n");
    $display("Testing...................");
    $display("[ALL CASES]-------------------------------------------------------------------------------------------");
    run_all_cases();

    //$display("[SELECTED CASES]-------------------------------------------------------------------------------------------");
    //$display("=============================  =============================");
















    $finish;
end



endmodule


//coded by Bingo


