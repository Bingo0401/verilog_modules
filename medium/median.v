module median (a0, a1, a2, a3, a4, out);

input    [5:0]   a0, a1, a2, a3, a4;

output   [5:0]   out;

wire [2:0] c0, c1, c2, c3, c4, c5;
wire [2:0] s0, s1, s2, s3, s4, s5;

assign s0 = a0[0] + a1[0] + a2[0] + a3[0] + a4[0];
assign s1 = a0[1] + a1[1] + a2[1] + a3[1] + a4[1];
assign s2 = a0[2] + a1[2] + a2[2] + a3[2] + a4[2];
assign s3 = a0[3] + a1[3] + a2[3] + a3[3] + a4[3];
assign s4 = a0[4] + a1[4] + a2[4] + a3[4] + a4[4];
assign s5 = a0[5] + a1[5] + a2[5] + a3[5] + a4[5];

assign c0 = s0;
assign c1 = c0 + s1;
assign c2 = c1 + s2;
assign c3 = c2 + s3;
assign c4 = c3 + s4;
assign c5 = c4 + s5;

assign out[0] = (c0 >= 3);
assign out[1] = (c0 <  3) && (c1 >= 3);
assign out[2] = (c1 <  3) && (c2 >= 3);
assign out[3] = (c2 <  3) && (c3 >= 3);
assign out[4] = (c3 <  3) && (c4 >= 3);
assign out[5] = (c4 <  3) && (c5 >= 3);

endmodule


//coded by Bingo
