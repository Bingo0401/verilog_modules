module scan_flip_flop(
    input Din,
    input Scan_in,
    input Scan_en,
    input clk,
    output Dout
);

wire selected_data;

mux_2to1 input_mux (
    .normal_data(Din),
    .scan_data(Scan_in),
    .select(Scan_en),
    .data_out(selected_data)
);

d_flip_flop storage_flop (
    .Din(selected_data),
    .clk(clk),
    .Dout(Dout)
);

endmodule

module d_flip_flop(
    input Din,
    input clk,
    output reg Dout
);

always @(posedge clk)
    Dout <= Din;

endmodule

module mux_2to1(
    input normal_data,
    input scan_data,
    input select,
    output data_out
);

assign data_out = select ? scan_data : normal_data;

endmodule
