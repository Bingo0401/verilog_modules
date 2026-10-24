`timescale 1ns/1ps
module incrementer_4bit(input [3:0] in, output [3:0] out, output carry_out);
    assign {carry_out, out} = {1'b0, in} + 5'd1;
endmodule
