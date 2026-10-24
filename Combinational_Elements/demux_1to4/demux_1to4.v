`timescale 1ns/1ps
// Route one input bit to the output selected by sel.
module demux_1to4(input din, input [1:0] sel, output [3:0] dout);
    assign dout = din ? (4'b0001 << sel) : 4'b0000;
endmodule
