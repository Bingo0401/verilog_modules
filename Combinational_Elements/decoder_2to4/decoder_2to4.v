`timescale 1ns/1ps
// Active-high, one-hot decoder with an active-high enable.
module decoder_2to4(input [1:0] in, input en, output [3:0] out);
    assign out = en ? (4'b0001 << in) : 4'b0000;
endmodule
