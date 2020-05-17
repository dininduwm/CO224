`include "mux2to1_1bit.v"
//`include "mux2to1_8bit.v"

module logicalShifterLeft(INPUT, OUTPUT, LSHIFT);        

    input  [7:0] INPUT; //input for the barrel shifter
    output  [7:0] OUTPUT; //output from the barrel shifter
    input [7:0]   LSHIFT; //Lshift Magnitude
    wire [7:0]    INTER1, INTER2, INNER3; //Two 8-bit intermediate lines 

    //the barrel shifter implemented as array of MUX shown in the figure 

    mux2to1_1bit m0 (INPUT[0], 1'b0, INTER1[0], LSHIFT[0]);  //first layer
    mux2to1_1bit m1 (INPUT[1], INPUT[0], INTER1[1], LSHIFT[0]); 
    mux2to1_1bit m2 (INPUT[2], INPUT[1], INTER1[2], LSHIFT[0]); 
    mux2to1_1bit m3 (INPUT[3], INPUT[2], INTER1[3], LSHIFT[0]); 
    mux2to1_1bit m4 (INPUT[4], INPUT[3], INTER1[4], LSHIFT[0]); 
    mux2to1_1bit m5 (INPUT[5], INPUT[4], INTER1[5], LSHIFT[0]); 
    mux2to1_1bit m6 (INPUT[6], INPUT[5], INTER1[6], LSHIFT[0]); 
    mux2to1_1bit m7 (INPUT[7], INPUT[6], INTER1[7], LSHIFT[0]); 

    mux2to1_1bit m00 (INTER1[0], 1'b0, INTER2[0], LSHIFT[1]); //second layer
    mux2to1_1bit m11 (INTER1[1], 1'b0, INTER2[1], LSHIFT[1]); 
    mux2to1_1bit m22 (INTER1[2], INTER1[0], INTER2[2], LSHIFT[1]); 
    mux2to1_1bit m33 (INTER1[3], INTER1[1], INTER2[3], LSHIFT[1]); 
    mux2to1_1bit m44 (INTER1[4], INTER1[2], INTER2[4], LSHIFT[1]); 
    mux2to1_1bit m55 (INTER1[5], INTER1[3], INTER2[5], LSHIFT[1]); 
    mux2to1_1bit m66 (INTER1[6], INTER1[4], INTER2[6], LSHIFT[1]); 
    mux2to1_1bit m77 (INTER1[7], INTER1[5], INTER2[7], LSHIFT[1]); 

    mux2to1_1bit m000 (INTER2[0], 1'b0, INNER3[0], LSHIFT[2]); //third layer
    mux2to1_1bit m111 (INTER2[1], 1'b0, INNER3[1], LSHIFT[2]); 
    mux2to1_1bit m222 (INTER2[2], 1'b0, INNER3[2], LSHIFT[2]); 
    mux2to1_1bit m333 (INTER2[3], 1'b0, INNER3[3], LSHIFT[2]); 
    mux2to1_1bit m444 (INTER2[4], INTER2[0], INNER3[4], LSHIFT[2]); 
    mux2to1_1bit m555 (INTER2[5], INTER2[1], INNER3[5], LSHIFT[2]); 
    mux2to1_1bit m666 (INTER2[6], INTER2[2], INNER3[6], LSHIFT[2]); 
    mux2to1_1bit m777 (INTER2[7], INTER2[3], INNER3[7], LSHIFT[2]); 

    // fourth layer
    mux2to1_8bit m0000 (INNER3, 8'h00, OUTPUT, LSHIFT[3]|LSHIFT[4]|LSHIFT[5]|LSHIFT[6]|LSHIFT[7]);

endmodule


