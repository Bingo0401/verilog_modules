module synchronous_counter(clk, reset, en, clr, count);
parameter WIDTH = 3;

input clk, reset, en, clr;
output reg [WIDTH-1:0] count;

always @(posedge clk) begin
    if (reset || clr) begin
        count <= {WIDTH{1'b0}};
    end else if (en) begin
        count <= count + {{(WIDTH-1){1'b0}}, 1'b1};
    end
end

endmodule