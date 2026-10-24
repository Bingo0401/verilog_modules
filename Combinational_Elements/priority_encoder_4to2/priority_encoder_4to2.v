`timescale 1ns/1ps
// The highest numbered asserted input has priority.
module priority_encoder_4to2(input [3:0] in, output [1:0] code, output valid);
    assign valid = |in;
    assign code = in[3] ? 2'd3 :
                  in[2] ? 2'd2 :
                  in[1] ? 2'd1 : 2'd0;
endmodule
