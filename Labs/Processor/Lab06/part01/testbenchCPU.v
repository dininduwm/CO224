/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "cpu.v"
`include "data_memory.v"

module testbenchCPU;
    
    //input registers
    wire [31:0] INS;
    reg CLK, RESET; 
    reg [7:0] INST_MEMORY [1023:0] ; //instruction array

    wire[31:0] PC;

    wire memReadEn, memWriteEn; // memory read or write enable signals
    wire [7:0] ADDRESS; // address of the data memory
    wire [7:0] READ_DATA, WRITE_DATA; // read and write data of the memory module
    wire BUSY_WAIT; // busy wait signal of the CPU
    
    cpu mycpu(PC, INS, CLK, RESET, memReadEn, memWriteEn, ADDRESS, WRITE_DATA, READ_DATA, BUSY_WAIT); //initialize the cpu
    data_memory myDataMemory(CLK, RESET, memReadEn, memWriteEn, ADDRESS, WRITE_DATA, READ_DATA, BUSY_WAIT); // initialize the memory module

    initial // instruction array
    begin
      //monitor command to check the content od the register file
      $monitor($time, " REG0: %b  REG1: %b  REG2: %b  REG3: %b  REG4: %b  REG5: %b  REG6: %b  REG7: %b ",
                          mycpu.myreg.REGISTERS[0], mycpu.myreg.REGISTERS[1], mycpu.myreg.REGISTERS[2], 
                          mycpu.myreg.REGISTERS[3], mycpu.myreg.REGISTERS[4], mycpu.myreg.REGISTERS[5], 
                          mycpu.myreg.REGISTERS[6], mycpu.myreg.REGISTERS[7]);
      // generate files needed to plot the waveform using GTKWave
      $dumpfile("cpu_wavedata.vcd");
      $dumpvars(0, testbenchCPU);
    end

    assign #2 INS = {INST_MEMORY[PC + 3], INST_MEMORY[PC + 2], INST_MEMORY[PC + 1], INST_MEMORY[PC]}; //fetching instruction
       
    initial
    begin
        /*
         // loadi 0 0x0A
        {INST_MEMORY[3],INST_MEMORY[2],INST_MEMORY[1],INST_MEMORY[0]}     = 32'b00000101_00000000_00000000_00001010;
        // mov 1 0
        {INST_MEMORY[7],INST_MEMORY[6],INST_MEMORY[5],INST_MEMORY[4]}     = 32'b00000100_00000001_00000000_00000000;
        // loadi 2 0x05
        {INST_MEMORY[11],INST_MEMORY[10],INST_MEMORY[9],INST_MEMORY[8]}   = 32'b00000101_00000010_00000000_00000101;
        // sub 3 1 2
        {INST_MEMORY[15],INST_MEMORY[14],INST_MEMORY[13],INST_MEMORY[12]} = 32'b00000001_00000011_00000001_00000010;
        // or 3 1 2
        {INST_MEMORY[19],INST_MEMORY[18],INST_MEMORY[17],INST_MEMORY[16]} = 32'b00000011_00000011_00000001_00000010;
        // and 3 1 2
        {INST_MEMORY[23],INST_MEMORY[22],INST_MEMORY[21],INST_MEMORY[20]} = 32'b00000010_00000011_00000001_00000010;
        // add 3 1 2
        {INST_MEMORY[27],INST_MEMORY[26],INST_MEMORY[25],INST_MEMORY[24]} = 32'b00000000_00000001_00000001_00000010;
        // j 
        {INST_MEMORY[31],INST_MEMORY[30],INST_MEMORY[29],INST_MEMORY[28]} = 32'b00000110_11111110_00000000_00000000;
        */

        /*
        // loadi 0 0x0A
        {INST_MEMORY[3],INST_MEMORY[2],INST_MEMORY[1],INST_MEMORY[0]}     = 32'b00000101000000000000000000001010;
        // mov 1 0
        {INST_MEMORY[7],INST_MEMORY[6],INST_MEMORY[5],INST_MEMORY[4]}     = 32'b00000101000000110000000000011110;
        // loadi 2 0x05
        {INST_MEMORY[11],INST_MEMORY[10],INST_MEMORY[9],INST_MEMORY[8]}   = 32'b00000101000000010000000000000101;
        // sub 3 1 2
        {INST_MEMORY[15],INST_MEMORY[14],INST_MEMORY[13],INST_MEMORY[12]} = 32'b00000000000000000000000000000001;
        // or 3 1 2
        {INST_MEMORY[19],INST_MEMORY[18],INST_MEMORY[17],INST_MEMORY[16]} = 32'b00000111000000010000000000000011;
        // and 3 1 2
        {INST_MEMORY[23],INST_MEMORY[22],INST_MEMORY[21],INST_MEMORY[20]} = 32'b00000110111111010000000000000000;
        */
        
        /*
        // loadi 0 0xFA
        {INST_MEMORY[3],INST_MEMORY[2],INST_MEMORY[1],INST_MEMORY[0]}     = 32'b00000101_000000000000000011111010;
        // sll 1 0 0x02
        {INST_MEMORY[7],INST_MEMORY[6],INST_MEMORY[5],INST_MEMORY[4]}     = 32'b00001001_000000010000000000000010;
        // srl 1 0 0x02
        {INST_MEMORY[11],INST_MEMORY[10],INST_MEMORY[9],INST_MEMORY[8]}   = 32'b00001010_000000010000000000000010;
        // sra 1 0 0x02
        {INST_MEMORY[15],INST_MEMORY[14],INST_MEMORY[13],INST_MEMORY[12]} = 32'b00001011_000000010000000000000010;
        // ror 1 0 0x02
        {INST_MEMORY[19],INST_MEMORY[18],INST_MEMORY[17],INST_MEMORY[16]} = 32'b00001100_000000010000000000000010;
        // loadi 2 0x05
        {INST_MEMORY[23],INST_MEMORY[22],INST_MEMORY[21],INST_MEMORY[20]}     = 32'b00000101_00000010_00000000_00000101;
        // loadi 3 0x0A
        {INST_MEMORY[27],INST_MEMORY[26],INST_MEMORY[25],INST_MEMORY[24]}     = 32'b00000101_00000011_00000000_00001010;
        // mul 4 2 3
        {INST_MEMORY[31],INST_MEMORY[30],INST_MEMORY[29],INST_MEMORY[28]}     = 32'b00001101_00000100_00000010_00000011;
        */

        // loadi 0 0x0A
        {INST_MEMORY[3],INST_MEMORY[2],INST_MEMORY[1],INST_MEMORY[0]}     = 32'b00000101_00000000_00000000_00001010;
        // swi 0 0X03
        {INST_MEMORY[7],INST_MEMORY[6],INST_MEMORY[5],INST_MEMORY[4]}     = 32'b00010001_00000000_00000000_00000011;
        // lwi 1 0X03
        {INST_MEMORY[11],INST_MEMORY[10],INST_MEMORY[9],INST_MEMORY[8]}   = 32'b00001111_00000001_00000000_00000011;
        // loadi 2 0X03
        {INST_MEMORY[15],INST_MEMORY[14],INST_MEMORY[13],INST_MEMORY[12]} = 32'b00000101_00000010_00000000_00000011;
        // loadi 3 0xAA
        {INST_MEMORY[19],INST_MEMORY[18],INST_MEMORY[17],INST_MEMORY[16]} = 32'b00000101_00000011_00000000_10101010;
        // swd 3 2
        {INST_MEMORY[23],INST_MEMORY[22],INST_MEMORY[21],INST_MEMORY[20]} = 32'b00010000_00000000_00000011_00000010;
        // lwd 4 2
        {INST_MEMORY[27],INST_MEMORY[26],INST_MEMORY[25],INST_MEMORY[24]} = 32'b00001110_00000100_00000000_00000010;

        CLK = 1'b1;
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;

        #1
        RESET = 1'b0;

        #37
        RESET = 1'b0;
        #4
        RESET = 1'b0;

        #200
        $finish;
    end
    
    // clock signal generation
    always
    begin
      #4 CLK = ~CLK;
    end              

endmodule