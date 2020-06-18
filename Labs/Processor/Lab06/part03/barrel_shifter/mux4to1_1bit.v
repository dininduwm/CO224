/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module mux4to1_1bit(INPUT1, INPUT2, INPUT3, INPUT4, RESULT, SELECT);
    input INPUT1, INPUT2, INPUT3, INPUT4; //declare inputs of the module
    input [1:0] SELECT;               //declare inputs
    output reg RESULT;    //declare outputs

    always @(*)
    begin
      if (SELECT == 2'b00)  //selecting according to the select signal
            RESULT = INPUT1;
      else if (SELECT == 2'b01) 
            RESULT = INPUT2;
      else if (SELECT == 2'b10) 
            RESULT = INPUT3;
      else
            RESULT = INPUT4;
    end

endmodule