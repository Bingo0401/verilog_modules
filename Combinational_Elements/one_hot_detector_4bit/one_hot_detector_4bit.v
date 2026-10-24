`timescale 1ns/1ps
module one_hot_detector_4bit(input [3:0] in, output one_hot, output one_hot_or_zero);
    assign one_hot_or_zero = (in & (in - 4'd1)) == 4'd0;
    assign one_hot = (|in) & one_hot_or_zero;
endmodule
