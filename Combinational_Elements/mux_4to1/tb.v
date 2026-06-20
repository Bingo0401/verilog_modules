`timescale 1ns/1ps

module mux_4to1_tb;

reg [3:0] Din;
reg [1:0] sel;
wire Dout;

// Instantiate the 4-to-1 mux
mux_4to1 uut (
    .Din(Din),
    .sel(sel),
    .Dout(Dout)
);

initial begin
    $display("Din  sel | Dout");
    $display("----------------");

    // Set input pattern
    Din = 4'b1010;

    sel = 2'b00; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b01; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b10; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b11; #5 $display("%b  %b  |  %b", Din, sel, Dout);

    // Change input pattern
    Din = 4'b1100;

    sel = 2'b00; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b01; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b10; #5 $display("%b  %b  |  %b", Din, sel, Dout);
    sel = 2'b11; #5 $display("%b  %b  |  %b", Din, sel, Dout);

    $finish;
end

endmodule
