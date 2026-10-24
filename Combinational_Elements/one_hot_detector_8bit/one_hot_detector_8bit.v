`timescale 1ns/1ps
module one_hot_detector_8bit(input [7:0] in, output one_hot, output one_hot_or_zero);
    assign one_hot_or_zero = (in & (in - 8'd1)) == 8'd0;
    assign one_hot = (|in) & one_hot_or_zero;
endmodule
