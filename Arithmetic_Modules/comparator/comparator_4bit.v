`timescale 1ns/1ps
// Unsigned comparison.
module comparator_4bit(input [3:0] a, input [3:0] b, output greater, output equal, output less);
    assign greater = a > b;
    assign equal = a == b;
    assign less = a < b;
endmodule
