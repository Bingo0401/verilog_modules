`timescale 1ns/1ps

// Count leading zeros; zero input returns a count of five.
module leading_zero_count_5bit(
    input [4:0] in,
    output [2:0] count,
    output is_zero
);
    assign is_zero = ~|in;
    assign count = in[4] ? 3'd0 :
                   in[3] ? 3'd1 :
                   in[2] ? 3'd2 :
                   in[1] ? 3'd3 :
                   in[0] ? 3'd4 : 3'd5;
endmodule
