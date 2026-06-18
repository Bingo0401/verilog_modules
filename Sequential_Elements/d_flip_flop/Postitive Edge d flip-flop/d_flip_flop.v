
//postive edge d flip_flop

module d_flip_flop(
    input Din,
    input clk,
    output reg Dout
);

always @(posedge clk)
    Dout <= Din;

endmodule

//coded by Bingo