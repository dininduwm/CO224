/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "cpu.v"

module testbenchCPU;
    
    //input registers
    wire [31:0] INS;
    reg CLK, RESET; 
    reg [7:0] INST_MEMORY [1023:0] ; //instruction array

    wire[31:0] PC;
    
    cpu mycpu(PC, INS, CLK, RESET); //initialize the cpu

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
         // loadi 0 0x0A
        {INST_MEMORY[3],INST_MEMORY[2],INST_MEMORY[1],INST_MEMORY[0]}     = 32'b00000101_00000000_00000000_00001010;
        // mov 1 0
        {INST_MEMORY[7],INST_MEMORY[6],INST_MEMORY[5],INST_MEMORY[4]}     = 32'b00000100_00000001_00000000_00000000;
        // loadi 2 0x05
        {INST_MEMORY[11],INST_MEMORY[10],INST_MEMORY[9],INST_MEMORY[8]}   = 32'b00000101_00000010_00000000_00000101;
        // add 3 1 2
        {INST_MEMORY[15],INST_MEMORY[14],INST_MEMORY[13],INST_MEMORY[12]} = 32'b00000000_00000011_00000001_00000010;
        // sub 3 1 2
        {INST_MEMORY[19],INST_MEMORY[18],INST_MEMORY[17],INST_MEMORY[16]} = 32'b00000001_00000011_00000001_00000010;
        // or 3 1 2
        {INST_MEMORY[23],INST_MEMORY[22],INST_MEMORY[21],INST_MEMORY[20]} = 32'b00000011_00000011_00000001_00000010;
        // and 3 1 2
        {INST_MEMORY[27],INST_MEMORY[26],INST_MEMORY[25],INST_MEMORY[24]} = 32'b00000010_00000011_00000001_00000010;

        CLK = 1'b1;
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;

        #1
        RESET = 1'b0;

        #37
        RESET = 1'b1;
        #4
        RESET = 1'b0;

        #140
        $finish;
    end
    
    // clock signal generation
    always
    begin
      #7 CLK = ~CLK;       
    end              

endmodule