module full_adder(A, B, Cin, Cout, S);
input A, B, Cin;
output Cout, S;

wire axb;
wire ab;
wire cin_axb;

xor X1(axb, A, B);
xor X2(S, axb, Cin);

and A1(ab, A, B);
and A2(cin_axb, Cin, axb);
or  O1(Cout, ab, cin_axb);

endmodule

// Coded by Bingo
