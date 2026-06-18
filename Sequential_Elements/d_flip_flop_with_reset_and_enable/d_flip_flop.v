module d_flip_flop(Din, reset, w_en, clk, Dout);
input [7:0] Din;
input reset, w_en, clk;
output [7:0] Dout;

reg [7:0] Dout;

always@(posedge clk or posedge reset)begin
    if (!reset)
        Dout <= 8'd0;
    else
        Dout <= (w_en)? Din:Dout; //if w_en then Din else Dout
end


endmodule


//coded by Bingo