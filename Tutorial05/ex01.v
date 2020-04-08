module testCircuit(in1, in2, sel, out);
  input [3:0] in1, in2;
  input sel;
  output [3:0] out;

  reg [3:0] out;

  always @ (in1, in2, sel)
  begin
    if (sel == 0)
        out = in1 + in2;
    else
        out = in1 - in2;
  end

endmodule

module testbench;
  reg [3:0] in1, in2;
  reg sel;
  wire [3:0] out;

  testCircuit myTest(in1, in2, sel, out);

  initial
  begin
    $dumpfile("testCircuit.vcd");
    $dumpvars(0, testbench);
  end

  initial
  begin
    in1 = 4'b0011;
    in2 = 4'b0001;
    sel = 0;
    #10
    sel = 1;
    #10
    $finish;
  end
endmodule