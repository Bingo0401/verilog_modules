`timescale 1ns/1ps
// Zero input returns 8.
module leading_zero_count_8bit(input [7:0] in, output [3:0] count, output is_zero);
    assign is_zero = ~|in;
    assign count = in[7] ? 4'd0 :
                   in[6] ? 4'd1 :
                   in[5] ? 4'd2 :
                   in[4] ? 4'd3 :
                   in[3] ? 4'd4 :
                   in[2] ? 4'd5 :
                   in[1] ? 4'd6 :
                   in[0] ? 4'd7 : 4'd8;
endmodule
