`timescale 1ns/1ps
module full_adder_4bit(input [3:0] a, input [3:0] b, input cin,
    output [3:0] sum, output cout);
    assign {cout, sum} = {1'b0, a} + {1'b0, b} + cin;
endmodule
