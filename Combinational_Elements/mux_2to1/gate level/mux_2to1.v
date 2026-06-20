module mux_2to1(a, b, sel, c);

input a, sel, b;
output c;
wire g0, sel_, g1;

not n1(sel_, sel);
and a1(g0, sel_, a);
and a2(g1, sel, b);
or o1(c, g0, g1);


endmodule





//Coded by Bingo