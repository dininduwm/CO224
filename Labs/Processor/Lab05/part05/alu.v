/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module alu(DATA1, DATA2, RESULT, SELECT, COMP);
input [7:0] DATA1, DATA2; //declare the inputs
input [2:0] SELECT; //declare the select input
output [7:0] RESULT; //declare the output
output COMP; //comparator output

reg [7:0] RESULT; // declare the outputs as registers

always @ (DATA1, DATA2, SELECT) // this block run if there is any change in DATA1 or DATA2 or SELECT
begin
    case (SELECT)
    3'b000:
        #1 RESULT = DATA2; //forward operation  1
    3'b001:
        #2 RESULT = DATA1 + DATA2; // add operation 2
    3'b010:
        #1 RESULT = DATA1 & DATA2; // bitwise and operation 1
    3'b011:
        #1 RESULT = DATA1 | DATA2; // bitwise or operation 1
    default: RESULT = 0; //result 0 if the other cases
    endcase
end

assign COMP = ~(RESULT[7]|RESULT[6]|RESULT[5]|RESULT[4]|RESULT[3]|RESULT[2]|RESULT[1]);  //comparator
    
endmodule