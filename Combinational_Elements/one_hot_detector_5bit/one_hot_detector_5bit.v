`timescale 1ns/1ps

// one_hot excludes zero; one_hot_or_zero accepts zero.
module one_hot_detector_5bit(
    input [4:0] in,
    output one_hot,
    output one_hot_or_zero
);
    assign one_hot_or_zero = (in & (in - 5'd1)) == 5'd0;
    assign one_hot = (|in) & one_hot_or_zero;
endmodule
