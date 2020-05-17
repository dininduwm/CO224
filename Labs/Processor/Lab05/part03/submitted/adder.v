/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module adder(INPUT1, INPUT2, RESULT); // adder module

    input [31:0] INPUT1, INPUT2; // declare inputs
    output reg [31:0] RESULT;    // declare outputs

    always @(*) 
    begin
      #2 RESULT = INPUT1 + INPUT2; // add two numbers 
    end

endmodule