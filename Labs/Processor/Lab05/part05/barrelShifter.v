`include "mux4to1_1bit.v"
`include "mux2to1_1bit.v"

module barrelShifter(INPUT, OUTPUT, SHIFT, SHIFT_MODE);        

    input  [7:0] INPUT; //input for the barrel shifter
    input [1:0] SHIFT_MODE;    
    input [7:0] SHIFT; //Lshift Magnitude
    output  [7:0] OUTPUT; //output from the barrel shifter

    reg SHIFT_DIR; //direction of the shift
    wire [7:0] INTER1, INTER2, INNER3; //Two 8-bit intermediate lines 
    wire [7:0] ININTER, OUTINTER;
    reg EN_LAYER_4; //enable layer 4
    reg [7:0] LAYER4_IN;  //second option of the layer 2
    wire [1:0] SHIFT_MODE;
    wire TMP1, TMP2, TMP3, TMP4, TMP5, TMP6, TMP7; //temp wire to select the mode of the shifter

    //mode selest muxes 
    mux4to1_1bit mt1(1'b0, INPUT[7], ININTER[7], 1'b0, TMP1, SHIFT_MODE);    
    mux4to1_1bit mt2(1'b0, INPUT[7], INTER1[6], 1'b0, TMP2, SHIFT_MODE);
    mux4to1_1bit mt3(1'b0, INPUT[7], INTER1[7], 1'b0, TMP3, SHIFT_MODE);
    mux4to1_1bit mt4(1'b0, INPUT[7], INTER2[4], 1'b0, TMP4, SHIFT_MODE);
    mux4to1_1bit mt5(1'b0, INPUT[7], INTER2[5], 1'b0, TMP5, SHIFT_MODE);
    mux4to1_1bit mt6(1'b0, INPUT[7], INTER2[6], 1'b0, TMP6, SHIFT_MODE);
    mux4to1_1bit mt7(1'b0, INPUT[7], INTER2[7], 1'b0, TMP7, SHIFT_MODE);

    mux2to1_8bit inmux(INPUT, {INPUT[0],INPUT[1],INPUT[2],INPUT[3],INPUT[4],INPUT[5],INPUT[6],INPUT[7]}, ININTER, SHIFT_DIR);
    mux2to1_8bit outmux(OUTINTER, {OUTINTER[0],OUTINTER[1],OUTINTER[2],OUTINTER[3],OUTINTER[4],OUTINTER[5],OUTINTER[6],OUTINTER[7]}, OUTPUT, SHIFT_DIR);

    //the barrel shifter implemented as array of MUX shown in the figure 

    mux2to1_1bit m0 (ININTER[0], TMP1, INTER1[0], SHIFT[0]);  //first layer
    mux2to1_1bit m1 (ININTER[1], ININTER[0], INTER1[1], SHIFT[0]); 
    mux2to1_1bit m2 (ININTER[2], ININTER[1], INTER1[2], SHIFT[0]); 
    mux2to1_1bit m3 (ININTER[3], ININTER[2], INTER1[3], SHIFT[0]); 
    mux2to1_1bit m4 (ININTER[4], ININTER[3], INTER1[4], SHIFT[0]); 
    mux2to1_1bit m5 (ININTER[5], ININTER[4], INTER1[5], SHIFT[0]); 
    mux2to1_1bit m6 (ININTER[6], ININTER[5], INTER1[6], SHIFT[0]); 
    mux2to1_1bit m7 (ININTER[7], ININTER[6], INTER1[7], SHIFT[0]); 

    mux2to1_1bit m00 (INTER1[0], TMP2, INTER2[0], SHIFT[1]); //second layer
    mux2to1_1bit m11 (INTER1[1], TMP3, INTER2[1], SHIFT[1]); 
    mux2to1_1bit m22 (INTER1[2], INTER1[0], INTER2[2], SHIFT[1]); 
    mux2to1_1bit m33 (INTER1[3], INTER1[1], INTER2[3], SHIFT[1]); 
    mux2to1_1bit m44 (INTER1[4], INTER1[2], INTER2[4], SHIFT[1]); 
    mux2to1_1bit m55 (INTER1[5], INTER1[3], INTER2[5], SHIFT[1]); 
    mux2to1_1bit m66 (INTER1[6], INTER1[4], INTER2[6], SHIFT[1]); 
    mux2to1_1bit m77 (INTER1[7], INTER1[5], INTER2[7], SHIFT[1]); 

    mux2to1_1bit m000 (INTER2[0], TMP4, INNER3[0], SHIFT[2]); //third layer
    mux2to1_1bit m111 (INTER2[1], TMP5, INNER3[1], SHIFT[2]); 
    mux2to1_1bit m222 (INTER2[2], TMP6, INNER3[2], SHIFT[2]); 
    mux2to1_1bit m333 (INTER2[3], TMP7, INNER3[3], SHIFT[2]); 
    mux2to1_1bit m444 (INTER2[4], INTER2[0], INNER3[4], SHIFT[2]); 
    mux2to1_1bit m555 (INTER2[5], INTER2[1], INNER3[5], SHIFT[2]); 
    mux2to1_1bit m666 (INTER2[6], INTER2[2], INNER3[6], SHIFT[2]); 
    mux2to1_1bit m777 (INTER2[7], INTER2[3], INNER3[7], SHIFT[2]); 

    // fourth layer
    mux2to1_8bit m0000 (INNER3, LAYER4_IN, OUTINTER, (SHIFT[3]|SHIFT[4]|SHIFT[5]|SHIFT[6]|SHIFT[7]));

    always @(*)
    begin
      case (SHIFT_MODE)
      2'b00:
        begin
          SHIFT_DIR = 1'b1;
          LAYER4_IN = 8'h00;
        end
      2'b01:
        begin
          SHIFT_DIR = 1'b1;
          LAYER4_IN = {8{INPUT[7]}};
        end
      2'b10:
        begin
          SHIFT_DIR = 1'b1;
          LAYER4_IN = INNER3;
        end
      2'b11:
        begin
          SHIFT_DIR = 1'b0;
          LAYER4_IN = 8'h00;
        end
      endcase
    end

endmodule


