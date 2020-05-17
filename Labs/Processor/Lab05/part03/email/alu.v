module alu(DATA1, DATA2, RESULT, SELECT);
input [7:0] DATA1, DATA2; //declare the inputs
input [2:0] SELECT; //declare the select input
output [7:0] RESULT; //declare the output

reg [7:0] RESULT; // declare the outputs as registers

always @ (*) // this block run if there is any change in DATA1 or DATA2 or SELECT
begin
    case (SELECT)
    'b000:
        RESULT = #1 DATA2; //forward operation  1
    'b001:
        RESULT = #2 DATA1 + DATA2; // add operation 2
    'b010:
        RESULT = #1 DATA1 & DATA2; // bitwise and operation 1
    'b011:
        RESULT = #1 DATA1 | DATA2; // bitwise or operation 1
    default: RESULT = 0; //result 0 if the other cases
    endcase
end
    
endmodule