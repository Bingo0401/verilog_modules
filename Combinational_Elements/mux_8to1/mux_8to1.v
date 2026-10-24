`timescale 1ns/1ps

// Like mux_4to1, sel=0 selects the highest numbered input bit.
module mux_8to1(input [7:0] Din, input [2:0] sel, output Dout);
    assign Dout = Din[3'd7 - sel];
endmodule
