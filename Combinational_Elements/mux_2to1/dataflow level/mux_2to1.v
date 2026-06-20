module mux_2to1(a, b, sel, c);

input a, b, sel;
output c;
wire g0, g1;


assign c = g0|g1;
assign g0 = a&sel;
assign g1 = b|!sel;


endmodule





//Coded by Bingo