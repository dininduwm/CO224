module mux2to1(INPUT1, INPUT2, RESULT, SELECT);
    input [7:0] INPUT1, INPUT2; //declare inputs of the module
    input SELECT;               //declare inputs
    output reg [7:0] RESULT;    //declare outputs

    always @(SELECT or INPUT1 or INPUT2)
    begin
      if (SELECT == 'b0)  //selecting according to the select signal
            RESULT = INPUT1;
      else 
            RESULT = INPUT2;
    end

endmodule