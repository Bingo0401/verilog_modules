module d_latch (
  input  Din,
  input  clk,
  output reg Dout
);
  always @(*) begin
    if (clk)
      Dout = Din;
  end
endmodule
