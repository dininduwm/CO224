/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "logicalShifterLeft.v"
`include "logicalShifterRight.v"
`include "arithShifterRight.v"
`include "rotateShifterRight.v"

module alu(DATA1, DATA2, RESULT, SELECT, COMP);
input [7:0] DATA1, DATA2; //declare the inputs
input [3:0] SELECT; //declare the select input
output [7:0] RESULT; //declare the output
output COMP; //comparator output

reg [7:0] RESULT; // declare the outputs as registers

wire [7:0] LOGICAL_RIGHT, LOGICAL_LEFT, ARITH_RIGHT, ROTATE_RIGHT; //wires for the shifters

//initiate shift modules
logicalShifterLeft lsl(DATA1, LOGICAL_LEFT, DATA2);
logicalShifterRight lsr(DATA1, LOGICAL_RIGHT, DATA2);
arithShifterRight asr(DATA1, ARITH_RIGHT, DATA2);
rotateShifterRight rsr(DATA1, ROTATE_RIGHT, DATA2);

always @ (*) // this block run if there is any change in DATA1 or DATA2 or SELECT
begin
    case (SELECT)
    4'b0000:
        #1 RESULT = DATA2; //forward operation  1
    4'b0001:
        #2 RESULT = DATA1 + DATA2; // add operation 2
    4'b0010:
        #1 RESULT = DATA1 & DATA2; // bitwise and operation 1
    4'b0011:
        #1 RESULT = DATA1 | DATA2; // bitwise or operation 1
    4'b0100: 
        #1 RESULT = LOGICAL_LEFT;  //logical shift left
    4'b0101: 
        #1 RESULT = LOGICAL_RIGHT;  //logical shift left
    4'b0110: 
        #1 RESULT = ARITH_RIGHT;  //logical shift left
    4'b0111: 
        #1 RESULT = ROTATE_RIGHT;  //logical shift left
    default: RESULT = 0; //result 0 if the other cases
    endcase
end

assign COMP = ~(RESULT[7]|RESULT[6]|RESULT[5]|RESULT[4]|RESULT[3]|RESULT[2]|RESULT[1]);  //comparator
    
endmodule