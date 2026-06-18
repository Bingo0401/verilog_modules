module Comparator( In1, In2, Out);

    input   In1, In2;
    output  [2:0] Out;

    wire    In1, In2;
    reg     [2:0] Out;

    always @( In1, In2 ) begin
        Out[0] <= ( In1 > In2 );
        Out[1] <= ( In1 == In2 );
        Out[2] <= ( In1 < In2 );
    end

endmodule