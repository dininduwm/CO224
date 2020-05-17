`include "mux2to1_1bit.v"
`include "mux2to1_8bit.v"

module arithShifterRight(INPUT, OUTPUT, RSHIFT);        

    input  [7:0] INPUT; //input for the barrel shifter
    output  [7:0] OUTPUT; //output from the barrel shifter
    input [7:0]   RSHIFT; //Lshift Magnitude
    wire [7:0]    INTER1, INTER2, INNER3; //Two 8-bit intermediate lines 

    //the barrel shifter implemented as array of MUX shown in the figure 

    mux2to1_1bit m0 (INPUT[7], INPUT[7], INTER1[0], RSHIFT[0]);  //first layer
    mux2to1_1bit m1 (INPUT[6], INPUT[7], INTER1[1], RSHIFT[0]); 
    mux2to1_1bit m2 (INPUT[5], INPUT[6], INTER1[2], RSHIFT[0]); 
    mux2to1_1bit m3 (INPUT[4], INPUT[5], INTER1[3], RSHIFT[0]); 
    mux2to1_1bit m4 (INPUT[3], INPUT[4], INTER1[4], RSHIFT[0]); 
    mux2to1_1bit m5 (INPUT[2], INPUT[3], INTER1[5], RSHIFT[0]); 
    mux2to1_1bit m6 (INPUT[1], INPUT[2], INTER1[6], RSHIFT[0]); 
    mux2to1_1bit m7 (INPUT[0], INPUT[1], INTER1[7], RSHIFT[0]); 

    mux2to1_1bit m00 (INTER1[0], INPUT[7], INTER2[0], RSHIFT[1]); //second layer
    mux2to1_1bit m11 (INTER1[1], INPUT[7], INTER2[1], RSHIFT[1]); 
    mux2to1_1bit m22 (INTER1[2], INTER1[0], INTER2[2], RSHIFT[1]); 
    mux2to1_1bit m33 (INTER1[3], INTER1[1], INTER2[3], RSHIFT[1]); 
    mux2to1_1bit m44 (INTER1[4], INTER1[2], INTER2[4], RSHIFT[1]); 
    mux2to1_1bit m55 (INTER1[5], INTER1[3], INTER2[5], RSHIFT[1]); 
    mux2to1_1bit m66 (INTER1[6], INTER1[4], INTER2[6], RSHIFT[1]); 
    mux2to1_1bit m77 (INTER1[7], INTER1[5], INTER2[7], RSHIFT[1]); 

    mux2to1_1bit m000 (INTER2[0], INPUT[7], INNER3[7], RSHIFT[2]); //third layer
    mux2to1_1bit m111 (INTER2[1], INPUT[7], INNER3[6], RSHIFT[2]); 
    mux2to1_1bit m222 (INTER2[2], INPUT[7], INNER3[5], RSHIFT[2]); 
    mux2to1_1bit m333 (INTER2[3], INPUT[7], INNER3[4], RSHIFT[2]); 
    mux2to1_1bit m444 (INTER2[4], INTER2[0], INNER3[3], RSHIFT[2]); 
    mux2to1_1bit m555 (INTER2[5], INTER2[1], INNER3[2], RSHIFT[2]); 
    mux2to1_1bit m666 (INTER2[6], INTER2[2], INNER3[1], RSHIFT[2]); 
    mux2to1_1bit m777 (INTER2[7], INTER2[3], INNER3[0], RSHIFT[2]); 

    // fourth layer
    mux2to1_8bit m0000 (INNER3, 8'h00, OUTPUT, RSHIFT[3]|RSHIFT[4]|RSHIFT[5]|RSHIFT[6]|RSHIFT[7]);

endmodule


