`timescale 1ns/1ps

// Unsigned sum clamps to 31 instead of wrapping when it overflows.
module saturating_adder_5bit(
    input [4:0] a,
    input [4:0] b,
    output [4:0] sum,
    output saturated
);
    wire [5:0] full_sum;
    assign full_sum = {1'b0, a} + {1'b0, b};
    assign saturated = full_sum[5];
    assign sum = saturated ? 5'b11111 : full_sum[4:0];
endmodule
