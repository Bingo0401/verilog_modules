`timescale 1ns/1ps
// carry_out indicates that in was 8'hFF.
module incrementer_8bit(input [7:0] in, output [7:0] out, output carry_out);
    assign {carry_out, out} = {1'b0, in} + 9'd1;
endmodule
