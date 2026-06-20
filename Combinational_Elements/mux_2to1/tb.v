`timescale 1ns/1ps

module mux_2to1_tb;

reg a;
reg b;
reg sel;
wire c;

// Instantiate the MUX
mux_2to1 uut (
    .a(a),
    .b(b),
    .sel(sel),
    .c(c)
);

initial begin
    $display("a b sel | c");
    $display("---------------");
    $monitor("%b %b  %b  | %b", a, b, sel, c);

    // Test all input combinations
    a=0; b=0; sel=0; #10;
    a=0; b=0; sel=1; #10;
    a=0; b=1; sel=0; #10;
    a=0; b=1; sel=1; #10;
    a=1; b=0; sel=0; #10;
    a=1; b=0; sel=1; #10;
    a=1; b=1; sel=0; #10;
    a=1; b=1; sel=1; #10;

    $finish;
end

endmodule