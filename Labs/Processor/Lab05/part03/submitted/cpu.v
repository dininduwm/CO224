/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "alu.v"
`include "reg_file.v"
`include "control_unit.v"
`include "twosComp.v"
`include "mux2to1.v"
`include "adder.v"

module cpu(PC, INSTRUCTION, CLK, RESET);

    input [31:0] INSTRUCTION; //fetched INSTRUCTIONtructions
    input CLK, RESET; // clock and reset for the cpu
    output reg [31:0] PC; //programme counter

    wire [7:0] SOURCE1, SOURCE2, DESTINATION, OP;  //decoded INSTRUCTIONtructons
    wire twoscompMUXSEL, immeMUXSEL, regWRITEEN;   //control signals
    wire [2:0] aluOP; // alu op code

    wire [7:0] REGOUT1, REGOUT2; //register file outputs
    wire [7:0] ALOP1, ALOP2, ALUOUT; //alu signal
    wire [7:0] TWOSCOMPOUT; //output of the twos complement
    wire [7:0] TWOSMUXOUT; //output of the twos compliment mux

    wire [31:0] PCNEXT; //store the next value of the pc

    //initiating the modules
    control_unit mycu (OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP); //control unit module
    reg_file myreg (ALUOUT, REGOUT1, REGOUT2, DESTINATION[2:0], SOURCE1[2:0], SOURCE2[2:0], regWRITEEN, CLK, RESET); //alu module
    twosComp twos (REGOUT2, TWOSCOMPOUT); // twos complement unit
    mux2to1 muxtwos (REGOUT2, TWOSCOMPOUT, TWOSMUXOUT, twoscompMUXSEL); //mux for two to one in the 2s complement selection
    mux2to1 muximme (TWOSMUXOUT, SOURCE2, ALOP1, immeMUXSEL); //immmediate value load mux
    alu myalu (ALOP2, ALOP1, ALUOUT, aluOP); //alu module 
    adder myadder (PC, 32'h00000004, PCNEXT); //adder to increment the cpu

    // decoding the INSTRUCTIONtructions
    assign DESTINATION = INSTRUCTION[23:16];
    assign SOURCE1 = INSTRUCTION[16:8];
    assign SOURCE2 = INSTRUCTION[7:0];
    assign OP = INSTRUCTION[31:24];

    assign ALOP2 = REGOUT1; //connect regout1 with the alu oparand 2

    always @ (posedge CLK)
    begin
      if (RESET == 1'b1) PC = -4; // rest the pc counter
      else #1 PC = PCNEXT;        // increment the pc
    end

    always @ (*)
    begin
      if (RESET == 1'b1) PC = -4; //asynchronus reset for the cpu
    end

endmodule