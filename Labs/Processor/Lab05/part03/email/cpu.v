`include "alu.v"
`include "reg_file.v"
`include "control_unit.v"
`include "twosComp.v"
`include "mux2to1.v"

module cpu(PC, INS, CLK, RESET);

    /*
    op codes
    00000000 - add
    00000001 - sub
    00000010 - and
    00000011 - or
    00000100 - mov
    00000101 - loadi
    */

    input [31:0] INS; //fetched instructions
    input CLK, RESET; // clock and reset for the cpu
    output reg [7:0] PC; //programme counter

    reg [7:0] SOURCE1, SOURCE2, DESTINATION, OP; //decoded instructons
    wire twoscompMUXSEL, immeMUXSEL, regWRITEEN;       //control signals
    wire [2:0] aluOP;

    wire [7:0] REGOUT1, REGOUT2; //register file outputs
    wire [7:0] ALOP1, ALOP2, ALUOUT; //alu out signal
    wire [7:0] TWOSCOMPOUT; //output of the twos complement
    wire [7:0] TWOSMUXOUT; //output of the twos compliment mux

    //initiating the modules
    control_unit mycu (OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP); //control unit module
    reg_file myreg (ALUOUT, REGOUT1, REGOUT2, DESTINATION[2:0], SOURCE1[2:0], SOURCE2[2:0], regWRITEEN, CLK, RESET); //alu module
    twosComp twos (REGOUT2, TWOSCOMPOUT); // twos complement unit
    mux2to1 muxtwos (REGOUT2, TWOSCOMPOUT, TWOSMUXOUT, twoscompMUXSEL); //mux for two to one in the 2s complement selection
    mux2to1 muximme (TWOSMUXOUT, SOURCE2, ALOP1, immeMUXSEL); //immmediate value load mux
    alu myalu (ALOP2, ALOP1, ALUOUT, aluOP); //alu module 

    always @ (INS) // instruction decoding unit
    begin   
        #1     
        {OP, DESTINATION, SOURCE1, SOURCE2} = INS; //decode the instruction     
    end

    assign ALOP2 = REGOUT1; //connect regout1 with the alu oparand 2

    always @ (posedge CLK)
    begin
      if (RESET == 1'b1) PC = -4; // rest the pc counter
      else #1 PC = PC + 4;        // 
    end

endmodule