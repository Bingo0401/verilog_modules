`timescale 1ns/1ps
module population_count_4bit(input [3:0] in, output [2:0] count);
    assign count = {2'b0, in[0]} +
                   {2'b0, in[1]} +
                   {2'b0, in[2]} +
                   {2'b0, in[3]};
endmodule
