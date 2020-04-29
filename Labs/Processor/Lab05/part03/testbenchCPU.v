`include "cpu.v"
//`timescale 1ns/10ps

module testbenchCPU;

reg [31:0] INS;  // 8 bit data input
reg CLK;

cpu myCPU (INS, CLK); // initialize the cpu object

initial
begin
    $dumpfile("testcpu_file.vcd"); // dumping the variables
    $dumpvars(2, testbenchCPU);
end

initial
begin
    INS = 32'hFF030201;
    
    CLK = 0;
    #2 // delay of 1ns
    CLK = 1;
    #2 // delay of 1ns

    #1
    $finish;
end

endmodule