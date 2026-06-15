module full_adder(A, B, Cin, Cout, S);
input A, B, Cin;
output Cout, S;

xor X1(S, A, B, Cin);

assign Cout = (A & B)|(Cin & A)|(B & Cin);

endmodule






//Coded by Bingo