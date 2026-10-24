`timescale 1ns/1ps
module even_parity_4bit(input [3:0] data, input [3:0] received_data,
    input received_parity, output parity_bit, output parity_error);
    assign parity_bit = ^data;
    assign parity_error = ^{received_data, received_parity};
endmodule
