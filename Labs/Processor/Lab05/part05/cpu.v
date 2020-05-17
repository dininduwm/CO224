/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "alu.v"
`include "reg_file.v"
`include "control_unit.v"
`include "twosComp.v"
`include "mux2to1_8bit.v"
`include "mux2to1_32bit.v"
`include "adder.v"
`include "barrelShifter.v"

module cpu(PC, INSTRUCTION, CLK, RESET);

    input [31:0] INSTRUCTION; //fetched INSTRUCTIONtructions
    input CLK, RESET; // clock and reset for the cpu
    output reg [31:0] PC; //programme counter

    wire [7:0] SOURCE1, SOURCE2, DESTINATION, OP;  //decoded INSTRUCTIONtructons
    wire twoscompMUXSEL, immeMUXSEL, regWRITEEN, jump, beq, bne, jumpMUXSEL, alu_shiftMUXSEL;   //control signals
    wire [2:0] aluOP; // alu op code
    wire [1:0] bShifterOpCode; // barrel shifter opcode

    wire [7:0] REGOUT1, REGOUT2; //register file outputs
    wire [7:0] ALOP1, ALOP2, ALUOUT; //alu signal
    wire ALUCOMP; //comparator of the alu
    wire [7:0] TWOSCOMPOUT; //output of the twos complement
    wire [7:0] TWOSMUXOUT; //output of the twos compliment mux

    wire [31:0] PCNEXT; //store the next value of the pc
    wire [31:0] PCINCBY4; //store the next value of the pc + 4
    wire [31:0] PCJUMP; //store the next value of the pc if the instruction is jump

    wire [7:0] REGSAVE; //data to be save in the register in the next clock cycle

    //initiating the modules
    control_unit mycu (OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP, jump, beq, bne, alu_shiftMUXSEL, RESET); //control unit module
    reg_file myreg (REGSAVE, REGOUT1, REGOUT2, DESTINATION[2:0], SOURCE1[2:0], SOURCE2[2:0], regWRITEEN, CLK, RESET); //alu module
    twosComp twos (REGOUT2, TWOSCOMPOUT); // twos complement unit
    mux2to1_8bit muxtwos (REGOUT2, TWOSCOMPOUT, TWOSMUXOUT, twoscompMUXSEL); //mux for two to one in the 2s complement selection
    mux2to1_8bit muximme (TWOSMUXOUT, SOURCE2, ALOP1, immeMUXSEL); //immmediate value load mux
    mux2to1_32bit muxjump (PCINCBY4, PCJUMP, PCNEXT, jumpMUXSEL); //jump mux
    alu myalu (ALOP2, ALOP1, ALUOUT, aluOP, ALUCOMP); //alu module 
    adder myadder (PC, 32'h00000004, PCINCBY4); //adder to increment the cpu
    adder jumpadder (PCINCBY4, {{22{DESTINATION[7]}}, DESTINATION, 2'b00}, PCJUMP); //adder for the jump instruction

    //beq and j instructions
    wire ANDOUTBEQ, ANDOUTBNE; //out wire for the and gate
    and a1(ANDOUTBEQ, beq, ALUCOMP);  //and gate to decide a successfull beq command
    and a1(ANDOUTBNE, bne, (~ALUCOMP));  //and gate to decide a successfull bne command
    assign jumpMUXSEL = ANDOUTBEQ | ANDOUTBNE | jump; //or gate to select the mux for branch

    // decoding the INSTRUCTIONtructions
    assign DESTINATION = INSTRUCTION[23:16];
    assign SOURCE1 = INSTRUCTION[16:8];
    assign SOURCE2 = INSTRUCTION[7:0];
    assign OP = INSTRUCTION[31:24];

    //barrel shifter
    wire [7:0] BARRELOUT; //output of the barrel shifter
    barrelShifter bs(ALOP2, BARRELOUT, ALOP1, bShifterOpCode); //initiate barrel shifter

    //mux to choose between alu and the barrel shifter    
    mux2to1_8bit muxFin(ALUOUT, BARRELOUT, REGSAVE, alu_shiftMUXSEL); //mux to select alu or barrel shifter

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