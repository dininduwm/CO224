`include "barrelShifter.v"

module barrelShifter_tb;

 // Inputs
 reg [7:0] Ip;
 reg [7:0] shift_mag;
 reg shift_dir;
 reg [1:0] shift_mode;

 // Outputs
 wire [7:0] Op;

 barrelShifter uut (Ip, Op, shift_mag, shift_mode);

 initial // instruction array
    begin
      // generate files needed to plot the waveform using GTKWave
      $dumpfile("barrelShifter.vcd");
      $dumpvars(0, barrelShifter_tb);
    end

 initial 
    begin
        // Initialize Inputs
        Ip    = 8'd15;
        shift_mag = 8'd1;
        shift_mode = 2'd0;

        #5
        shift_mag = 8'd9;

        #5
        shift_mode = 2'd1;
      
        #5
        shift_mode = 2'd2;

        #5
        shift_mode = 2'd3;
      

        #10
        $finish;
    end

endmodule