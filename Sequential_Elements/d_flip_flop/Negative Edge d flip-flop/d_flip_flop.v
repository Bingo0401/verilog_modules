
//negative edge d flip-flop

module d_flip_flop(
    input Din,
    input clk,
    output reg Dout
);

always @(negedge clk)
    Dout <= Din;

endmodule

//coded by Bingo