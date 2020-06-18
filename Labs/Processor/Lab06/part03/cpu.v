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
`timescale 1ns/100ps

module cpu(PC, INSTRUCTION, CLK, RESET, memReadEn, memWriteEn, ALUOUT, REGOUT1, MEMREAD, BUSY_WAIT,
            insReadEn, INS_CACHE_BUSY_WAIT);

    input [31:0] INSTRUCTION; //fetched INSTRUCTIONtructions
    input CLK, RESET; // clock and reset for the cpu
    input BUSY_WAIT; // busy wait signal from the memory
    input INS_CACHE_BUSY_WAIT; // busy wait from the instruction memory
    input [7:0] MEMREAD; // input from the memory read
    output reg [31:0] PC; //programme counter
    output memReadEn, memWriteEn; // control signal to the data memory
    output reg insReadEn; // read enable for the instruction read
    output [7:0] ALUOUT, REGOUT1; // output signal to the memory (address and the write data input)

    wire [7:0] SOURCE1, SOURCE2, DESTINATION;  //decoded INSTRUCTIONtructons
    wire twoscompMUXSEL, immeMUXSEL, regWRITEEN, jump, beq, bne, jumpMUXSEL, alu_shiftMUXSEL, memMUXSEL, memWriteEn, memReadEn;   //control signals
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
    wire [7:0] PREV_ALU_BARREL_OUT; // output of the mux which select the barrel shifter or alu
    
    wire [7:0] MEMREAD; //data from the memory
    wire BUSY_WAIT; // busy signal to hault the CPU

    wire regWRITEEN_FIN; // reg write enable signal after checking with the busy wait signal

    //initiating the modules
    control_unit mycu (INSTRUCTION, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP, jump, beq, bne, alu_shiftMUXSEL, bShifterOpCode, memReadEn, memWriteEn, memMUXSEL, RESET); //control unit module
    reg_file myreg (REGSAVE, REGOUT1, REGOUT2, DESTINATION[2:0], SOURCE1[2:0], SOURCE2[2:0], regWRITEEN_FIN, CLK, RESET); //alu module
    twosComp twos (REGOUT2, TWOSCOMPOUT); // twos complement unit
    mux2to1_8bit muxtwos (REGOUT2, TWOSCOMPOUT, TWOSMUXOUT, twoscompMUXSEL); //mux for two to one in the 2s complement selection
    mux2to1_8bit muximme (TWOSMUXOUT, SOURCE2, ALOP1, immeMUXSEL); //immmediate value load mux
    mux2to1_32bit muxjump (PCINCBY4, PCJUMP, PCNEXT, jumpMUXSEL); //jump mux
    alu myalu (ALOP2, ALOP1, ALUOUT, aluOP, ALUCOMP); //alu module 
    adder myadder (PC, 32'h00000004, PCINCBY4); //adder to increment the cpu
    adder jumpadder (PCINCBY4, {{22{DESTINATION[7]}}, DESTINATION, 2'b00}, PCJUMP); //adder for the jump instruction
    
    //and gate for the write enable signal to deactivate when busy wait
    //and a_reg(regWRITEEN_FIN, regWRITEEN, ~BUSY_WAIT);
    assign regWRITEEN_FIN = regWRITEEN && ~BUSY_WAIT;

    //beq and j instructions
    wire ANDOUTBEQ, ANDOUTBNE; //out wire for the and gate
    and a1(ANDOUTBEQ, beq, ALUCOMP);  //and gate to decide a successfull beq command
    and a1(ANDOUTBNE, bne, (~ALUCOMP));  //and gate to decide a successfull bne command
    assign jumpMUXSEL = ANDOUTBEQ | ANDOUTBNE | jump; //or gate to select the mux for branch

    // decoding the INSTRUCTIONtructions
    assign DESTINATION = INSTRUCTION[23:16];
    assign SOURCE1 = INSTRUCTION[16:8];
    assign SOURCE2 = INSTRUCTION[7:0];

    //barrel shifter
    wire [7:0] BARRELOUT; //output of the barrel shifter
    barrelShifter bs(ALOP2, BARRELOUT, ALOP1, bShifterOpCode); //initiate barrel shifter

    //mux to choose between alu and the barrel shifter    
    mux2to1_8bit muxFin(ALUOUT, BARRELOUT, PREV_ALU_BARREL_OUT, alu_shiftMUXSEL); //mux to select alu or barrel shifter

    //mux to select between data memory or the cpu out
    mux2to1_8bit muMem(PREV_ALU_BARREL_OUT, MEMREAD, REGSAVE, memMUXSEL);

    assign ALOP2 = REGOUT1; //connect regout1 with the alu oparand 2

    always @ (posedge CLK)
    begin      
      if (RESET == 1'b1) 
          begin
            PC = -4; // rest the pc counter
            insReadEn = 1'b0; // disable the read enable signal of the instruction memory
          end
      else 
        begin
          insReadEn = 1'b0;
          #1
          if (!(BUSY_WAIT || INS_CACHE_BUSY_WAIT)) 
            begin 
              PC = PCNEXT;        // increment the pc
              insReadEn = 1'b1; // enable read from the instruction memory
            end
        end
    end

    always @ (*)
    begin
      if (RESET == 1'b1) PC = -4; //asynchronus reset for the cpu
    end

endmodule