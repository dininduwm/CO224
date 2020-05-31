`include "multiplier.v"

module tbMul;

    reg [7:0] DATA1, DATA2;
    wire [7:0] RESULT;

    multiplier m(DATA1, DATA2, RESULT);

    initial
    begin
      $dumpfile("mul_wavedata.vcd");
      $dumpvars(0, tbMul);
    end

    initial
    begin
      DATA1 = 8'd3;
      DATA2 = 8'd5;
      #2
      DATA1 = 8'd10;
      DATA2 = 8'd5;
      #2
      DATA1 = 8'd8;
      DATA2 = 8'd5;
      #2
      DATA1 = 8'd5;
      DATA2 = 8'd5;
      #2
      $finish;
    end

endmodule