`timescale  1ns/1ps



module tb;

//module input/output
reg A, B, Cin;
wire Cout, S; 

//expected value
reg expected_S;
reg expected_Cout;

//simulation Hold and Settle time
parameter HOLD_NS = 5;
parameter SETTLE_NS = 5;

integer Errors = 0;
integer total_tests = 0;
integer i;

//Unit Under Test
full_adder UUT(
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .Cout(Cout), 
    .S(S)
);


task calculate_expected_value;

    input A, B, Cin;
    begin
        expected_S = (A ^ B ^ Cin);
        expected_Cout = ((A & B) | (A & Cin) | (B & Cin));
    end
endtask

task run_case;

    input A, B, Cin;
    begin
        #(SETTLE_NS)
        calculate_expected_value(A, B, Cin);
        if ((S !== expected_S) || (Cout !== expected_Cout)) begin
            $display ("%b %b %b | %b %b | %b %b | Fail", A, B, Cin, expected_S, S, expected_Cout, Cout);
            Errors = Errors + 1;
        end else if ((S == expected_S) && (Cout == expected_Cout)) begin
            $display ("%b %b %b | %b %b | %b %b | Pass", A, B, Cin, expected_S, S, expected_Cout, Cout);
        end
        #(HOLD_NS);
    end
endtask



initial begin

    //WaveForm File    
    //$fsdbDumpfile("tb.fsdb");
    //$fsdbDumpvars(0, tb);
    //$dumpfile("tb.vcd");
    //$dumpfile(0, tb);




    $display("beginning test...............");
    $display("--------------Full Adder-----------------");
    $display ("A B Cin | exp_S S exp_Cout Cout | Result");
    for (i = 0; i < 8; i = i + 1) begin
        {A, B, Cin} = i[2:0];
        run_case(A, B, Cin);
        total_tests = total_tests + 1;
    end
    $display("-----------------------------------------");
    $display ("Total Tests: %0d", total_tests);
    $display ("Errors: %0d", Errors);

    $finish;
end


endmodule


//coded by Bingo