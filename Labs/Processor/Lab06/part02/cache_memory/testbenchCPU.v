/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

`include "cache_memory.v"

module testbenchCPU;
    
    //input registers
    wire [31:0] INS;
    reg CLK, RESET; 
    reg [7:0] INST_MEMORY [1023:0] ; //instruction array

    wire[31:0] PC;

    reg memReadEn, memWriteEn; // memory read or write enable signals
    reg [7:0] ADDRESS; // address of the data memory
    reg [7:0] WRITE_DATA; // read and write data of the memory module
    wire [7:0] READ_DATA;
    wire BUSY_WAIT; // busy wait signal of the CPU
    
    cache_memory myCacheMemory(CLK, RESET, memReadEn, memWriteEn, ADDRESS, WRITE_DATA, READ_DATA, BUSY_WAIT); // initialize the memory module

    initial // instruction array
    begin
      //monitor command to check the content od the register file
      /*
      $monitor($time, " REG0: %b  REG1: %b  REG2: %b  REG3: %b  REG4: %b  REG5: %b  REG6: %b  REG7: %b ",
                          mycpu.myreg.REGISTERS[0], mycpu.myreg.REGISTERS[1], mycpu.myreg.REGISTERS[2], 
                          mycpu.myreg.REGISTERS[3], mycpu.myreg.REGISTERS[4], mycpu.myreg.REGISTERS[5], 
                          mycpu.myreg.REGISTERS[6], mycpu.myreg.REGISTERS[7]);
      */
      // generate files needed to plot the waveform using GTKWave
      $dumpfile("cache_wavedata.vcd");
      $dumpvars(0, testbenchCPU);
    end
        
    initial
    begin
        CLK = 1'b1;
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;

        #1
        RESET = 1'b0;

        ADDRESS = 8'b0000_0001;
        memReadEn = 1'b1;       
        memWriteEn = 1'b0;

        #200 
        ADDRESS = 8'b0000_0010;
        memReadEn = 1'b0;

        #5
        memReadEn = 1'b1;

        #10
        ADDRESS = 8'b1000_0010;

        #400
        $finish;
    end
    
    // clock signal generation
    always
    begin
      #4 CLK = ~CLK;
    end              

endmodule