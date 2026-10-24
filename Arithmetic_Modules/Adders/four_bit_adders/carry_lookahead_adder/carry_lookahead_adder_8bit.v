`timescale 1ns/1ps
// Eight-bit carry-lookahead adder in dataflow style.
module carry_lookahead_adder_8bit(input [7:0] a, input [7:0] b, input cin,
    output [7:0] sum, output cout);
    wire [7:0] p, g;
    wire [8:0] carry;
    assign p = a ^ b;
    assign g = a & b;
    assign carry[0] = cin;
    assign carry[1] = (g[0]) |
                      ((&p[0:0]) & carry[0]);
    assign carry[2] = (g[1]) |
                      (p[1] & g[0]) |
                      ((&p[1:0]) & carry[0]);
    assign carry[3] = (g[2]) |
                      (p[2] & g[1]) |
                      (p[2] & p[1] & g[0]) |
                      ((&p[2:0]) & carry[0]);
    assign carry[4] = (g[3]) |
                      (p[3] & g[2]) |
                      (p[3] & p[2] & g[1]) |
                      (p[3] & p[2] & p[1] & g[0]) |
                      ((&p[3:0]) & carry[0]);
    assign carry[5] = (g[4]) |
                      (p[4] & g[3]) |
                      (p[4] & p[3] & g[2]) |
                      (p[4] & p[3] & p[2] & g[1]) |
                      (p[4] & p[3] & p[2] & p[1] & g[0]) |
                      ((&p[4:0]) & carry[0]);
    assign carry[6] = (g[5]) |
                      (p[5] & g[4]) |
                      (p[5] & p[4] & g[3]) |
                      (p[5] & p[4] & p[3] & g[2]) |
                      (p[5] & p[4] & p[3] & p[2] & g[1]) |
                      (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                      ((&p[5:0]) & carry[0]);
    assign carry[7] = (g[6]) |
                      (p[6] & g[5]) |
                      (p[6] & p[5] & g[4]) |
                      (p[6] & p[5] & p[4] & g[3]) |
                      (p[6] & p[5] & p[4] & p[3] & g[2]) |
                      (p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                      (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                      ((&p[6:0]) & carry[0]);
    assign carry[8] = (g[7]) |
                      (p[7] & g[6]) |
                      (p[7] & p[6] & g[5]) |
                      (p[7] & p[6] & p[5] & g[4]) |
                      (p[7] & p[6] & p[5] & p[4] & g[3]) |
                      (p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
                      (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                      (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                      ((&p[7:0]) & carry[0]);
    assign sum = p ^ carry[7:0];
    assign cout = carry[8];
endmodule
