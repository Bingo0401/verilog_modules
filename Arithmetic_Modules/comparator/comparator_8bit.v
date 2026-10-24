`timescale 1ns/1ps
// Unsigned 8-bit magnitude comparison.
module comparator_8bit(
    input [7:0] a,
    input [7:0] b,
    output greater,
    output equal,
    output less
);
    assign greater = a > b;
    assign equal = a == b;
    assign less = a < b;
endmodule
