//traffic ligth sequential circuit
//finite state machine
/*

State  Road_A  Road_B  Time
S0     Red     Red     1
S1     Green   Red     7
S2     Yellow  Red     2
S3     Red     Red     1
S4     Red     Green   7
S5     Red     Yellow  2
*/

module synchronous_counter_4_bit (en, clk, reset, clr, count);
input en, reset, clk, clr;
output reg [3:0] count; 

always @(posedge clk or posedge reset)begin 
if (reset || clr) begin
    count <= 4'b0000;
end else if (en) begin
    count <= count + 4'b0001;
end
end

endmodule

module traffic_light(
    input clk,
    input reset,
    output reg Road_A_Red,
    output reg Road_A_Yellow,
    output reg Road_A_Green,
    output reg Road_B_Red,
    output reg Road_B_Yellow,
    output reg Road_B_Green
);


localparam S0 = 3'h0, S1 = 3'h1, S2 = 3'h2, S3 = 3'h3, S4 = 3'h4, S5 = 3'h5;

reg [2:0] state;
wire [3:0] count;
wire end_of_state_delay;


synchronous_counter_4_bit counter(
    .en(1'b1),
    .clk(clk),
    .reset(reset),
    .clr(end_of_state_delay),
    .count(count)
);

// Combinational logic to determine when a state's time delay has been met.
assign end_of_state_delay = (state == S0 && count == 4'd1) ||
                            (state == S1 && count == 4'd7) ||
                            (state == S2 && count == 4'd2) ||
                            (state == S3 && count == 4'd1) ||
                            (state == S4 && count == 4'd7) ||
                            (state == S5 && count == 4'd2);

// Sequential logic for state transitions (the FSM).
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0; // On global reset, go to the initial state.
    end else if (end_of_state_delay) begin // Transition only when timer is done.
        case (state)
            S0: state <= S1;
            S1: state <= S2;
            S2: state <= S3;
            S3: state <= S4;
            S4: state <= S5;
            S5: state <= S0;
            default: state <= S0;
        endcase
    end
end

// Combinational logic for light outputs based on the current state.
always @(*) begin
    case(state)
        S0: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b100_100;
        S1: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b001_100;
        S2: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b010_100;
        S3: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b100_100;
        S4: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b100_001;
        S5: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b100_010;
        default: {Road_A_Red, Road_A_Yellow, Road_A_Green, Road_B_Red, Road_B_Yellow, Road_B_Green} = 6'b100_100; // Default to a safe "All Red" state.
    endcase
end
endmodule
