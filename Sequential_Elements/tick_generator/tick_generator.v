
module tick_generator #(parameter MASTER_CLK_FREQUENCY = 400)(clk, en, clr, reset, tick);

    input clk, en, clr, reset;
    reg [31:0] cnt;
    output reg tick;

    always @(posedge clk or posedge reset)begin
        if(reset || clr)begin
            cnt <= 'h0000;
            tick <= 1'b0; 
        end else if(en)begin 
            if (cnt == MASTER_CLK_FREQUENCY - 1)begin
                tick <= 1'b1;
                cnt <= 'h0000;
            end else begin
                cnt <= cnt + 1;
                tick <= 1'b0;
            end
        end else begin
            tick <= 1'b0;
        end
    end
endmodule

//coded by Bingo
