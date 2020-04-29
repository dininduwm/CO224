module cpu(INS, CLK);
    input [31:0] INS;
    input CLK;

    reg [7:0] SORCE1, SORCE2, DESTINATION, IMMEDIATE, OP;

    always @ (posedge CLK) // instruction decoding unit
    begin
        SORCE2 = INS [7:0]; 
        SORCE1 = INS [15:8];
        DESTINATION = INS [23:16];
        OP = INS [31:24];
    end

endmodule