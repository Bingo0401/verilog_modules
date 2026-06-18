//`include "full_adder.v"
module full_adder(A, B, Cin, Cout, S);
input A, B, Cin;
output Cout, S;

wire axb;
wire ab;
wire cin_axb;

xor #1 X1(axb, A, B);
xor #1 X2(S, axb, Cin);

and #1 A1(ab, A, B);
and #1 A2(cin_axb, Cin, axb);
or  #1 O1(Cout, ab, cin_axb);

endmodule


module adder_subtractor(A, B, mode, sum, c_out);

input [7:0] A;
input [7:0] B;
input mode;
output [7:0] sum;
output c_out;

wire [7:0] XOR;
wire [6:0] C;

// mode select
xor #1 XOR0(XOR[0], mode, B[0]);
xor #1 XOR1(XOR[1], mode, B[1]);
xor #1 XOR2(XOR[2], mode, B[2]);
xor #1 XOR3(XOR[3], mode, B[3]);
xor #1 XOR4(XOR[4], mode, B[4]);
xor #1 XOR5(XOR[5], mode, B[5]);
xor #1 XOR6(XOR[6], mode, B[6]);
xor #1 XOR7(XOR[7], mode, B[7]);

// ripple adder
full_adder Addr0(.A(A[0]), .B(XOR[0]), .Cin(mode), .Cout(C[0]), .S(sum[0]));
full_adder Addr1(.A(A[1]), .B(XOR[1]), .Cin(C[0]), .Cout(C[1]), .S(sum[1]));
full_adder Addr2(.A(A[2]), .B(XOR[2]), .Cin(C[1]), .Cout(C[2]), .S(sum[2]));
full_adder Addr3(.A(A[3]), .B(XOR[3]), .Cin(C[2]), .Cout(C[3]), .S(sum[3]));
full_adder Addr4(.A(A[4]), .B(XOR[4]), .Cin(C[3]), .Cout(C[4]), .S(sum[4]));
full_adder Addr5(.A(A[5]), .B(XOR[5]), .Cin(C[4]), .Cout(C[5]), .S(sum[5]));
full_adder Addr6(.A(A[6]), .B(XOR[6]), .Cin(C[5]), .Cout(C[6]), .S(sum[6]));
full_adder Addr7(.A(A[7]), .B(XOR[7]), .Cin(C[6]), .Cout(c_out), .S(sum[7]));

endmodule




//coded by Bingo