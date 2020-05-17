`include "alu.v"

module testBench;

reg [7:0] DATA1, DATA2; // inputs to the alu
reg [2:0] SELECT;      // select input for the alu
wire [7:0] RESULT;    // outputs from the mux

alu myALU(DATA1, DATA2, RESULT, SELECT); // initialize the alu object

initial
begin
    $dumpfile("testalu.vcd"); // dumping the variables
    $dumpvars(0, testBench);
end

initial
begin
    DATA1 = 28;
    DATA2 = 38;
    SELECT = 0;
    #5 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 1;
    #5 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 2;
    #5 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 3;
    #5 // delay of 1ns
    
    #1
    $finish;
end

endmodule