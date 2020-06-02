module twosComp(INPUT, RESULT); //change this
    input [7:0] INPUT;       //declare inputs
    output reg [7:0] RESULT; //declare outputs

    always @ (INPUT)
    begin
      #1 RESULT = ~INPUT + 1; // 2s comp negative
    end

endmodule
