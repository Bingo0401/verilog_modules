`timescale 1ns/1ps
// Zero input returns 4.
module leading_zero_count_4bit(input [3:0] in, output [2:0] count, output is_zero);
    assign is_zero = ~|in;
    assign count = in[3] ? 3'd0 :
                   in[2] ? 3'd1 :
                   in[1] ? 3'd2 :
                   in[0] ? 3'd3 : 3'd4;
endmodule
