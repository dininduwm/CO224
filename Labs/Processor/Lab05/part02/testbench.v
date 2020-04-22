`include "reg_file.v"
//`timescale 1ns/10ps

module testBench;

reg [7:0] IN;  // 8 bit data input
reg [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS; // 3 bit data inputs
reg WRITE, CLK, RESET; // 1 bit data inputs
wire [7:0] OUT1, OUT2; // 8 bit data outputs

reg_file myRegFile (IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET); // initialize the alu object

initial
begin
    $dumpfile("testreg_file.vcd"); // dumping the variables
    $dumpvars(1, testBench);
end

initial
begin
    IN = 28;
    INADDRESS = 1;
    OUT1ADDRESS = 0;
    OUT2ADDRESS = 1;
    WRITE = 1;
    
    CLK = 0;
    #2 // delay of 1ns
    CLK = 1;
    #2 // delay of 1ns

    #1
    $finish;
end

endmodule