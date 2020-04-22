module alu(DATA1, DATA2, RESULT, SELECT);
input [7:0] DATA1, DATA2; //declare the inputs
input [2:0] SELECT; //declare the select input
output [7:0] RESULT; //declare the output

reg [7:0] RESULT; // declare the outputs as registers

always @ (DATA1 or DATA2 or SELECT)
begin
    if (SELECT == 'b000)
        RESULT = DATA2; //forward operation  
    else if (SELECT == 'b001)
        RESULT = DATA1 + DATA2; // add operation
    else if (SELECT == 'b010)
        RESULT = DATA1 & DATA2; // bitwise and operation
    else if (SELECT == 'b011)
        RESULT = DATA1 | DATA2; // bitwise or operation
end
    
endmodule