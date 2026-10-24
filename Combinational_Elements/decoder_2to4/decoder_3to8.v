`timescale 1ns/1ps

// Enabled 3-to-8 one-hot decoder.
module decoder_3to8(input [2:0] in, input en, output [7:0] out);
    assign out = en ? (8'b00000001 << in) : 8'b00000000;
endmodule
