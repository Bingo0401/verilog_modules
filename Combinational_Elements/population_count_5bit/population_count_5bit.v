`timescale 1ns/1ps

// Count the number of asserted bits (0 through 5).
module population_count_5bit(input [4:0] in, output [2:0] count);
    assign count = {2'b00, in[0]} + {2'b00, in[1]} +
                   {2'b00, in[2]} + {2'b00, in[3]} +
                   {2'b00, in[4]};
endmodule
