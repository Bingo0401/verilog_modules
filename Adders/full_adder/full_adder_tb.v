`timescale 1ns/1ps

module full_adder_tb;
  reg A;
  reg B;
  reg Cin;
  wire Cout;
  wire S;

  full_adder dut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Cout(Cout),
    .S(S)
  );

  integer i;
  reg exp_sum;
  reg exp_cout;

  initial begin
    for (i = 0; i < 8; i = i + 1) begin
      {A, B, Cin} = i[2:0];
      #1;
      exp_sum = A ^ B ^ Cin;
      exp_cout = (A & B) | (A & Cin) | (B & Cin);
      if (S !== exp_sum || Cout !== exp_cout) begin
        $display("FAIL: A=%b B=%b Cin=%b => S=%b Cout=%b (expected S=%b Cout=%b)",
                 A, B, Cin, S, Cout, exp_sum, exp_cout);
        $fatal;
      end
    end

    $display("PASS: full_adder all vectors OK");
    $finish;
  end
endmodule
