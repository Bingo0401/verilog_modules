`timescale 1ns/1ps
module binary_to_gray_4bit(input [3:0] binary, output [3:0] gray);
    assign gray = binary ^ (binary >> 1);
endmodule
