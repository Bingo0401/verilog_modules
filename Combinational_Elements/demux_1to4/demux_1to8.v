`timescale 1ns/1ps
module demux_1to8(input din, input [2:0] sel, output [7:0] dout);
    assign dout = din ? (8'b00000001 << sel) : 8'b00000000;
endmodule
