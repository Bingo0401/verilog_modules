`timescale 1ns/1ps
// sum_bits + carry_bits equals a + b + c.
module carry_save_adder_8bit(input [7:0] a, input [7:0] b, input [7:0] c,
    output [8:0] sum_bits, output [8:0] carry_bits);
    assign sum_bits = {1'b0, a ^ b ^ c};
    assign carry_bits = {(a & b) | (a & c) | (b & c), 1'b0};
endmodule
