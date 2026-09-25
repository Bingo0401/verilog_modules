module flip_flop(
    input en, clk, d, rst,
    output reg q
);
    always @(posedge clk) begin
        if(rst) q <= 1'b0;
        else if(en) q <= d;
    end
endmodule

module mux_4x1(
    input A0, A1, A2, A3,
    input [1:0] sel,
    output reg S
);

    always@(*)begin
        case(sel)
            2'b00: S=A0;
            2'b01: S=A1;
            2'b10: S=A2;
            default: S=A3;
        endcase
    end
endmodule


/*
functions

00: hold
01: shift right
10: shift left
11: parallel load

*/

module universal_shift_register(
    input en,
    input clk,
    input rst,
    input Cin,
    input [1:0] Sel,
    output Cout,
    input [3:0] Din,
    output [3:0] Q
);

wire m0, m1, m2, m3;

// Right shift: Q <= {Cin, Q[3:1]}; left shift: Q <= {Q[2:0], Cin}.
mux_4x1 M0(.A0(Q[0]), .A1(Q[1]), .A2(Cin),  .A3(Din[0]), .sel(Sel), .S(m0));
mux_4x1 M1(.A0(Q[1]), .A1(Q[2]), .A2(Q[0]), .A3(Din[1]), .sel(Sel), .S(m1));
mux_4x1 M2(.A0(Q[2]), .A1(Q[3]), .A2(Q[1]), .A3(Din[2]), .sel(Sel), .S(m2));
mux_4x1 M3(.A0(Q[3]), .A1(Cin),  .A2(Q[2]), .A3(Din[3]), .sel(Sel), .S(m3));

// Synchronous active-high reset takes priority over enable.
flip_flop FF0(.en(en), .clk(clk), .d(m0), .rst(rst), .q(Q[0]));
flip_flop FF1(.en(en), .clk(clk), .d(m1), .rst(rst), .q(Q[1]));
flip_flop FF2(.en(en), .clk(clk), .d(m2), .rst(rst), .q(Q[2]));
flip_flop FF3(.en(en), .clk(clk), .d(m3), .rst(rst), .q(Q[3]));

// Current outgoing bit, sampled before the clock edge; not a stored carry.
// Hold and parallel-load modes expose Q[0].
assign Cout = (Sel == 2'b10) ? Q[3] : Q[0];

endmodule
