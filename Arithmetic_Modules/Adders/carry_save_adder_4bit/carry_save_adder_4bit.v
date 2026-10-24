`timescale 1ns/1ps
// sum_bits + carry_bits equals a + b + c.
module carry_save_adder_4bit(input [3:0] a, input [3:0] b, input [3:0] c,
    output [4:0] sum_bits, output [4:0] carry_bits);
    assign sum_bits = {1'b0, a ^ b ^ c};
    assign carry_bits = {(a & b) | (a & c) | (b & c), 1'b0};
endmodule
