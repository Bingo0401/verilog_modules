module four_bit_adder(Cin, A, B, Cout, S);

input Cin;
input [3:0] A;
input [3:0] B;

output Cout;
output [3:0] S;

wire [2:0] C;


carry_lookahead_generator CLG(.Cin(Cin), .G(A&B), .P(A|B), .C(C), .Cout(Cout));
full_adder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]));
full_adder FA1(.A(A[1]), .B(B[1]), .Cin(C[0]), .S(S[1]));
full_adder FA2(.A(A[2]), .B(B[2]), .Cin(C[1]), .S(S[2]));
full_adder FA3(.A(A[3]), .B(B[3]), .Cin(C[2]), .S(S[3]));
endmodule


module full_adder(A, B, Cin, Cout, S);
input A, B, Cin;
output Cout, S;

xor X1(S, A, B, Cin);
assign Cout = (A & B)|(Cin & A)|(B & Cin);
endmodule

module carry_lookahead_generator(Cin, G, P, C, Cout);
input Cin;
input [3:0] G;
input [3:0] P;

output Cout;
output [2:0] C;


assign C[0] = G[0]|(P[0] & Cin);
assign C[1] = G[1]|(P[1] & G[0])|(P[1] & P[0] & Cin);
assign C[2] = G[2]|(P[2] & G[1])|(P[2] & P[1] & G[0])|(P[2] & P[1] & P[0] & Cin);
assign Cout = G[3]|(P[3] & G[2])|(P[3] & P[2] & G[1])|(P[3] & P[2] & P[1] & G[0])|(P[3] & P[2] & P[1] & P[0] & Cin);
endmodule








//Coded by Bingo