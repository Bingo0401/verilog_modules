module mux_2to1(a, b, sel, c)

input a, sel, b;
output c;

always @(a or b or c)
begin
    if (sel)
        c = a;
    else
        c = b;

end



endmodule





//Coded by Bingo