`timescale 1ns/1ps

module universal_shift_register_tb;
    reg en, clk, rst, Cin;
    reg [1:0] Sel;
    reg [3:0] Din;
    wire [3:0] Q;
    wire Cout;
    reg [3:0] expected;
    integer state, mode, serial_bit, parallel_data, enabled, reset_value;
    integer checks;

    universal_shift_register dut(
        .en(en), .clk(clk), .rst(rst), .Cin(Cin),
        .Sel(Sel), .Din(Din), .Q(Q), .Cout(Cout)
    );

    task check_outputs;
        begin
            if (Q !== expected)
                $fatal(1, "Q=%b expected=%b sel=%b en=%b rst=%b",
                       Q, expected, Sel, en, rst);
            if (Cout !== ((Sel == 2'b10) ? expected[3] : expected[0]))
                $fatal(1, "Incorrect serial output: Q=%b Sel=%b Cout=%b", Q, Sel, Cout);
            checks = checks + 1;
        end
    endtask

    initial begin
        clk = 0;
        en = 0;
        rst = 1;
        Cin = 0;
        Sel = 0;
        Din = 0;
        expected = 0;
        checks = 0;
        #5 clk = 1;
        #1 check_outputs;
        #4 clk = 0;

        // Exhaust every starting state, operation, input, enable and reset.
        for (state = 0; state < 16; state = state + 1)
        for (mode = 0; mode < 4; mode = mode + 1)
        for (serial_bit = 0; serial_bit < 2; serial_bit = serial_bit + 1)
        for (parallel_data = 0; parallel_data < 16; parallel_data = parallel_data + 1)
        for (enabled = 0; enabled < 2; enabled = enabled + 1)
        for (reset_value = 0; reset_value < 2; reset_value = reset_value + 1) begin
            // Establish the starting state through the public load interface.
            rst = 0;
            en = 1;
            Sel = 2'b11;
            Din = state[3:0];
            #5 clk = 1;
            expected = state[3:0];
            #1 check_outputs;
            #4 clk = 0;

            Sel = mode[1:0];
            Cin = serial_bit[0];
            Din = parallel_data[3:0];
            en = enabled[0];
            rst = reset_value[0];
            // Inputs, including synchronous reset, cannot change Q mid-cycle.
            #2 check_outputs;
            if (rst)
                expected = 4'b0000;
            else if (en) begin
                case (Sel)
                    2'b00: expected = state[3:0];
                    2'b01: expected = {Cin, state[3:1]};
                    2'b10: expected = {state[2:0], Cin};
                    2'b11: expected = Din;
                endcase
            end
            #3 clk = 1;
            #1 check_outputs;
            #4 clk = 0;
            #1 check_outputs;
        end
        $display("PASS: %0d output checks across 8192 exhaustive transitions", checks);
        $finish;
    end
endmodule
