`include "cpu.v"

module testbenchCPU;
    
    //input registers
    wire [31:0] INS;
    reg CLK, RESET; 
    reg [31:0] instructions [255:0] ; //instruction array

    wire[7:0] PC;
    
    cpu mycpu(PC, INS, CLK, RESET); //initialize the cpu

    initial // instruction array
    begin
      instructions[0] = 32'h0505000A;
      instructions[1] = 32'h04000005;
      instructions[2] = 32'h05010005;
      instructions[3] = 32'h01030001; 
    end

    assign #2 INS = instructions[PC/4]; //fetching instruction
       
    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		    $dumpvars(0, testbenchCPU);
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;

        #1
        RESET = 1'b0;

        #100
        $finish;
    end
    
    // clock signal generation
    always
    begin
      #7 CLK = ~CLK;       
    end              

endmodule