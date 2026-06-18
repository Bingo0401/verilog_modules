module full_adder(A, B, Cin, Cout, S);
input A, B, Cin;
output Cout, S;

xor X1(S, A, B, Cin);

assign Cout = (A & B)|(Cin & A)|(B & Cin);
endmodule



module four_bit_adder(Cin, Cout, A, B, S);


input Cin;
input [3:0] A;
input [3:0] B;
output Cout;
output [3:0] S;
wire C0, C1, C2;


full_adder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .Cout(C0), .S(S[0]));
full_adder FA1(.A(A[1]), .B(B[1]), .Cin(C0), .Cout(C1), .S(S[1]));
full_adder FA2(.A(A[2]), .B(B[2]), .Cin(C1), .Cout(C2), .S(S[2]));
full_adder FA3(.A(A[3]), .B(B[3]), .Cin(C2), .Cout(Cout), .S(S[3]));


endmodule

//Coded by Bingo