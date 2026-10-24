`timescale 1ns/1ps
module population_count_8bit(input [7:0] in, output [3:0] count);
    assign count = {3'b0, in[0]} +
                   {3'b0, in[1]} +
                   {3'b0, in[2]} +
                   {3'b0, in[3]} +
                   {3'b0, in[4]} +
                   {3'b0, in[5]} +
                   {3'b0, in[6]} +
                   {3'b0, in[7]};
endmodule
