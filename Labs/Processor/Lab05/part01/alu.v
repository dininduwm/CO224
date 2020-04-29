module alu(DATA1, DATA2, RESULT, SELECT);
input [7:0] DATA1, DATA2; //declare the inputs
input [2:0] SELECT; //declare the select input
output [7:0] RESULT; //declare the output

reg [7:0] RESULT; // declare the outputs as registers

always @ (DATA1 or DATA2 or SELECT) // this block run if there is any change in DATA1 or DATA2 or SELECT
begin
    case (SELECT)
    'b000:
        RESULT = DATA2; //forward operation  
    'b001:
        RESULT = DATA1 + DATA2; // add operation
    'b010:
        RESULT = DATA1 & DATA2; // bitwise and operation
    'b011:
        RESULT = DATA1 | DATA2; // bitwise or operation
    default: RESULT = 0; //result 0 if the other cases
    endcase
end
    
endmodule