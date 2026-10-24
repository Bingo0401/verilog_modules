`timescale 1ns/1ps
// Append parity_bit to data to produce an even number of 1 bits.
// parity_error is high when received_data plus received_parity is odd.
module even_parity_8bit(
    input [7:0] data,
    input [7:0] received_data,
    input received_parity,
    output parity_bit,
    output parity_error
);
    assign parity_bit = ^data;
    assign parity_error = ^{received_data, received_parity};
endmodule
