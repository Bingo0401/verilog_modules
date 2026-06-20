//`include "no_Cout_adder.v"
//`include "eight_bit_carry_lookahead_generator.v"


module no_Cout_adder(A, B, Cin, S, P, G);
input A, B, Cin;
output S;
output P, G;

wire axb;
wire ab;
wire cin_axb;

xor #1 X1(axb, A, B);
xor #1 X2(S, axb, Cin);

and #1 A1(ab, A, B);
//and #1 A2(cin_axb, Cin, axb);
//or  #1 O1(Cout, ab, cin_axb);


//for carry lookahead
assign P = axb;
assign G = ab;

endmodule

module four_bit_carry_lookahead_generator(Cin, P, G, C);

input Cin;
input [3:0] P;
input [3:0] G;

output [3:0] C;

wire [0:0] t0;
wire [1:0] t1;
wire [2:0] t2;
wire [3:0] t3;

// C[0] = G0 + P0*Cin
and #1 A01(t0[0], P[0], Cin);
or #1 O0(C[0], G[0], t0[0]);

// C[1] = G1 + P1*G0 + P1*P0*Cin
and #1 A11(t1[0], P[1], G[0]);
and #1 A12(t1[1], P[1], P[0], Cin);
or #1 O1(C[1], G[1], t1[0], t1[1]);

// C[2] = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*Cin
and #1 A21(t2[0], P[2], G[1]);
and #1 A22(t2[1], P[2], P[1], G[0]);
and #1 A23(t2[2], P[2], P[1], P[0], Cin);
or #1 O2(C[2], G[2], t2[0], t2[1], t2[2]);

// C[3] = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*Cin
and #1 A31(t3[0], P[3], G[2]);
and #1 A32(t3[1], P[3], P[2], G[1]);
and #1 A33(t3[2], P[3], P[2], P[1], G[0]);
and #1 A34(t3[3], P[3], P[2], P[1], P[0], Cin);
or #1 O3(C[3], G[3], t3[0], t3[1], t3[2], t3[3]);

endmodule



module adder_subtractor(A, B, mode, sum, c_out);


input [7:0] A;
input [7:0] B;
input mode;

output [7:0] sum;
output c_out;

wire [7:0] XOR;
wire [3:0] C1;  // Carries from first 4-bit CLA
wire [3:0] C2;  // Carries from second 4-bit CLA
wire [7:0] P;
wire [7:0] G;

// mode select
xor #1 XOR0(XOR[0], mode, B[0]);
xor #1 XOR1(XOR[1], mode, B[1]);
xor #1 XOR2(XOR[2], mode, B[2]);
xor #1 XOR3(XOR[3], mode, B[3]);
xor #1 XOR4(XOR[4], mode, B[4]);
xor #1 XOR5(XOR[5], mode, B[5]);
xor #1 XOR6(XOR[6], mode, B[6]);
xor #1 XOR7(XOR[7], mode, B[7]);

// full adders (sum path + P/G generation)
no_Cout_adder Addr0(.A(A[0]), .B(XOR[0]), .Cin(mode), .S(sum[0]), .P(P[0]), .G(G[0]));
no_Cout_adder Addr1(.A(A[1]), .B(XOR[1]), .Cin(C1[0]), .S(sum[1]), .P(P[1]), .G(G[1]));
no_Cout_adder Addr2(.A(A[2]), .B(XOR[2]), .Cin(C1[1]), .S(sum[2]), .P(P[2]), .G(G[2]));
no_Cout_adder Addr3(.A(A[3]), .B(XOR[3]), .Cin(C1[2]), .S(sum[3]), .P(P[3]), .G(G[3]));
no_Cout_adder Addr4(.A(A[4]), .B(XOR[4]), .Cin(C1[3]), .S(sum[4]), .P(P[4]), .G(G[4]));
no_Cout_adder Addr5(.A(A[5]), .B(XOR[5]), .Cin(C2[0]), .S(sum[5]), .P(P[5]), .G(G[5]));
no_Cout_adder Addr6(.A(A[6]), .B(XOR[6]), .Cin(C2[1]), .S(sum[6]), .P(P[6]), .G(G[6]));
no_Cout_adder Addr7(.A(A[7]), .B(XOR[7]), .Cin(C2[2]), .S(sum[7]), .P(P[7]), .G(G[7]));

// First 4-bit carry lookahead generator (bits 0-3)
four_bit_carry_lookahead_generator CLAG1(.Cin(mode), .P(P[3:0]), .G(G[3:0]), .C(C1));

// Second 4-bit carry lookahead generator (bits 4-7)
four_bit_carry_lookahead_generator CLAG2(.Cin(C1[3]), .P(P[7:4]), .G(G[7:4]), .C(C2));

// Carry out is from second CLA
assign c_out = C2[3];

endmodule



//coded by Bingo