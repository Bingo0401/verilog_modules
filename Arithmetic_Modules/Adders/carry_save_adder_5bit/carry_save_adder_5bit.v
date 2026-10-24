`timescale 1ns/1ps

// Compress three 5-bit inputs into sum and shifted carry rows.
// Their 7-bit sum equals a + b + c.
module carry_save_adder_5bit(
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    output [5:0] sum_bits,
    output [5:0] carry_bits
);
    assign sum_bits = {1'b0, a ^ b ^ c};
    assign carry_bits = {(a & b) | (a & c) | (b & c), 1'b0};
endmodule
