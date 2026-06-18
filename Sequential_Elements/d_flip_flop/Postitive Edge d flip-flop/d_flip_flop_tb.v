`timescale 1ns/1ps

module d_flip_flop_tb;

reg Din;
reg clk;
wire Dout;

d_flip_flop uut (
    .Din(Din),
    .clk(clk),
    .Dout(Dout)
);

initial begin
    $dumpfile("d_flip_flop.vcd");
    $dumpvars(0, d_flip_flop_tb);
    $timeformat(-9, 0, " ns", 6);
    $display(" time | clk Din | Dout");
    $display("----------------------");
    $monitor("%4t |  %b   %b  |  %b", $time, clk, Din, Dout);

    clk = 1'b0;
    Din = 1'b0;

    // Change Din on falling edges so sampling on posedge is clear.
    @(negedge clk) Din = 1'b1;
    @(negedge clk) Din = 1'b0;
    @(negedge clk) Din = 1'b1;
    @(negedge clk) Din = 1'b0;
    @(negedge clk) Din = 1'b1;

    repeat (2) @(posedge clk);
    $finish;
end

initial begin
    forever #5 clk = ~clk;
end

endmodule
