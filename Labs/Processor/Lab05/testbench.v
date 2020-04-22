`include "alu.v"
`timescale 1ns/10ps

module testBench;

reg [7:0] DATA1, DATA2; // inputs to the mux
reg [2:0] SELECT;
wire [7:0] RESULT;    // outputs from the mux

alu myALU(DATA1, DATA2, RESULT, SELECT);

initial
begin
    $dumpfile("testalu.vcd");
    $dumpvars(0, testBench);
end

initial
begin
    DATA1 = 28;
    DATA2 = 38;
    SELECT = 0;
    #1 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 1;
    #1 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 2;
    #1 // delay of 1ns

    DATA1 = 28;
    DATA2 = 38;
    SELECT = 3;
    #1 // delay of 1ns
    #1
    $finish;
end

endmodule