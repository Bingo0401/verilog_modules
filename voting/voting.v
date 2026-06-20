

module voting (a0, a1, a2, a3, a4, out, count);

input    [4:0]   a0, a1, a2, a3, a4;

wire [2:0] c0, c1, c2, c3, c4; //vote count of each contestant

assign c0 = a0[0] + a1[0] + a2[0] + a3[0] + a4[0];
assign c1 = a0[1] + a1[1] + a2[1] + a3[1] + a4[1];
assign c2 = a0[2] + a1[2] + a2[2] + a3[2] + a4[2];
assign c3 = a0[3] + a1[3] + a2[3] + a3[3] + a4[3];
assign c4 = a0[4] + a1[4] + a2[4] + a3[4] + a4[4];


output   reg [4:0]   out;
output   reg [2:0]   count;


always @(*) begin

    out = 5'b00000;
    count = 3'b000;

    if (c4 >= c3 && c4 >= c2 && c4 >= c1 && c4 >= c0) begin
        out = 5'b10000;
        count = c4;
    end else if (c3 >= c2 && c3 >= c1 && c3 >= c0) begin
        out = 5'b01000;
        count = c3;
    end else if (c2 >= c1 && c2 >= c0) begin
        out = 5'b00100;
        count = c2;
    end else if (c1 >= c0) begin
        out = 5'b00010;
        count = c1;
    end else begin
        out = 5'b00001;
        count = c0;
    end


end

endmodule
