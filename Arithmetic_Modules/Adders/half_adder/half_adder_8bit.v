`timescale 1ns/1ps
module half_adder_8bit(input [7:0] a, input [7:0] b,
    output [7:0] sum, output carry);
    assign {carry, sum} = {1'b0, a} + {1'b0, b};
endmodule
