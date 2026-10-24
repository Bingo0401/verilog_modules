`timescale 1ns/1ps
// Unsigned addition clamps to 15.
module saturating_adder_4bit(input [3:0] a, input [3:0] b, output [3:0] sum, output saturated);
    wire [4:0] full_sum;
    assign full_sum = {1'b0, a} + {1'b0, b};
    assign saturated = full_sum[4];
    assign sum = saturated ? {4{1'b1}} : full_sum[3:0];
endmodule
