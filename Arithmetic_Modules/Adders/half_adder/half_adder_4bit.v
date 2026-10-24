`timescale 1ns/1ps
module half_adder_4bit(input [3:0] a, input [3:0] b,
    output [3:0] sum, output carry);
    assign {carry, sum} = {1'b0, a} + {1'b0, b};
endmodule
