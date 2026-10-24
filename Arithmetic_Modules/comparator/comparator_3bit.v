`timescale 1ns/1ps

// Unsigned 3-bit magnitude comparator.
module comparator_3bit(
    input [2:0] a,
    input [2:0] b,
    output greater,
    output equal,
    output less
);
    assign greater = a > b;
    assign equal = a == b;
    assign less = a < b;
endmodule
