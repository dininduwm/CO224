//`include "logicalShifterLeft.v"
//`include "logicalShifterRight.v"
`include "rotateShifterRight.v"

module barrelShifter_tb;

 // Inputs
 reg [7:0] Ip;
 reg [7:0] shift_mag;

 // Outputs
 wire [7:0] Op;

 // Instantiate the Unit Under Test (UUT)
 //logicalShifterLeft uut (.INPUT(Ip), .OUTPUT(Op), .LSHIFT(shift_mag));
 rotateShifterRight uut (.INPUT(Ip), .OUTPUT(Op), .RSHIFT(shift_mag));

 initial // instruction array
    begin
      // generate files needed to plot the waveform using GTKWave
      $dumpfile("barrelShifter.vcd");
      $dumpvars(0, barrelShifter_tb);
    end

 initial 
    begin
        // Initialize Inputs
        Ip    = 8'd5;
        shift_mag = 8'd1;

        #5
        shift_mag = 8'd7;

        #5
        shift_mag = 8'd8;

        #5

        // Add stimulus here
        Ip    = 8'd16;
        shift_mag = 8'd2;

        #20;
        Ip    = -8'd4;
        shift_mag = 8'd2;

        #10
        $finish;
    end

endmodule