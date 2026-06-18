module four_bit_shift_register(Sin, Pout, Sout, clk, reset);
input Sin, clk, reset;
output reg [3:0] Pout;
output Sout;

always @(posedge clk or posedge reset)begin
    if (reset)
        Pout <= 4'b0000;
    else
        Pout <= {Sin, Pout[3:1]};
end

assign Sout = Pout[0];

endmodule


//coded by Bingo
