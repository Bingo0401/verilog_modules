`timescale 1ns/1ps
// Unsigned addition clamps to 255.
module saturating_adder_8bit(input [7:0] a, input [7:0] b, output [7:0] sum, output saturated);
    wire [8:0] full_sum;
    assign full_sum = {1'b0, a} + {1'b0, b};
    assign saturated = full_sum[8];
    assign sum = saturated ? {8{1'b1}} : full_sum[7:0];
endmodule
