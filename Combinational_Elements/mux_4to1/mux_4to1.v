module mux_2to1(a, b, sel, c);

    input a, sel, b;
    output c;
    wire g0, sel_, g1;

    not n1(sel_, sel);
    and a1(g0, sel_, a);
    and a2(g1, sel, b);
    or o1(c, g0, g1);
endmodule








module mux_4to1(Din, sel, Dout);
input [3:0] Din;
input [1:0] sel;
output Dout;

wire M0_out, M1_out;

//logic
mux_2to1 M0(.a(Din[3]), .b(Din[2]), .sel(sel[0]), .c(M0_out));
mux_2to1 M1(.a(Din[1]), .b(Din[0]), .sel(sel[0]), .c(M1_out));
mux_2to1 M2(.a(M0_out), .b(M1_out), .sel(sel[1]), .c(Dout));


endmodule





//Coded by Bingo