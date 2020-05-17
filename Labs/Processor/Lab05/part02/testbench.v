`include "reg_file.v"

module reg_file_tb;
    
    //input registers
    reg [7:0] WRITEDATA;
    reg [2:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [7:0] REGOUT1, REGOUT2;
    
    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);
       
    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("reg_file_wavedata_my.vcd");
		$dumpvars(0, reg_file_tb);
        
        // assign values with time to input signals to see output 
        RESET = 1'b0;
        WRITEENABLE = 1'b0;

        #2
        READREG1 = 3'd0;
        READREG2 = 3'd1;

        #2
        RESET = 1'b1;

        #5
        READREG1 = 3'd2;
        READREG2 = 3'd3;

        #4
        RESET = 1'b0;  
        WRITEENABLE = 1'b1;  

        #1
        WRITEREG = 3'd2;
        WRITEDATA = 8'd95;        
        
        #9
        WRITEENABLE = 1'b0;     

        #4
        WRITEREG = 3'd3;
        WRITEDATA = 8'd50;  

        #5
        WRITEENABLE = 1'b1;

        #10
        WRITEENABLE = 1'b0;

        #6
        READREG1 = 3'd4;
        READREG2 = 3'd5;
        WRITEDATA = 8'd45;
        WRITEREG = 3'd5;

        #1
        WRITEENABLE = 1'b1;

        #3
        WRITEENABLE = 1'b0;

        #6
        RESET = 1'b1;

        #6
        RESET = 1'b0;

        
        #20
        $finish;
    end
    
    // clock signal generation
    always
        #5 CLK = ~CLK;
        

endmodule
