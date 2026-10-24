`timescale 1ns/1ps

// Unsigned 5-bit magnitude comparator.
module comparator_5bit(
    input [4:0] a,
    input [4:0] b,
    output greater,
    output equal,
    output less
);
    assign greater = a > b;
    assign equal = a == b;
    assign less = a < b;
endmodule
