`timescale 1ns/1ps



module testbench;

// Net









localparam integer HOLD_NS = 5;
localparam integer SETTLE_NS = 5;

integer errors;
integer total;
integer all_errors;
integer all_total;


// Unit Under Test
// module UUT()






task automatic calculate_expected_value;

// Net



// Logic 
    begin




    end
endtask




task automatic run_case;
//NET
    begin

        #(SETTLE_NS);

        if ((SUM !== exp_sum) || (C_out !== exp_cout)) begin
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
        all_total  = 0;
        


        for () begin


                    #(HOLD_NS);
        end


        if (all_errors == 0)
            $display("ALL SUMMARY: PASS (%0d tests)", all_total);
        else
            $display("ALL SUMMARY: FAIL (%0d errors out of %0d tests)", all_errors, all_total);
    end
endtask



initial begin

//WaveForm File    

    //$fsdbDumpfile("tb.fsdb");
    //$fsdbDumpvars(0, tb);
    //$dumpfile("tb.vcd");
    //$dumpfile(0, tb);


    errors = 0;
    total  = 0;


    $display("This is a very awesome testbench designed by Bingo");
    $display("beginning test...............");

    $display("Each case is held for %0dns for clear waveform time frames.", HOLD_NS, "\n");
    $display("Testing...................");
    $display("[ALL CASES]-------------------------------------------------------------------------------------------");
    run_all_cases();

    $display("[SELECTED CASES]-------------------------------------------------------------------------------------------");
    $display("=============================  =============================");
















    $finish;
end



endmodule


//coded by Bingo