`timescale 1ns/1ps
// Full-width unsigned product.
module multiplier_8bit(input [7:0] a, input [7:0] b, output [15:0] product);
    assign product = a * b;
endmodule
