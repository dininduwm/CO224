module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

input [7:0] IN;  // 8 bit data input
input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS; // 3 bit data inputs
input WRITE, CLK, RESET; // 1 bit data inputs
output [7:0] OUT1, OUT2; // 8 bit data outputs

reg [7:0] OUT1, OUT2; // registers for the output

reg [7:0] registers [7:0]; // 8x8 register file

always @ (posedge CLK) // this code block run when we are in a positive clock edge
begin
    // write input to the in address
    if (WRITE == 1)
        registers[INADDRESS] = IN; 
    // writing for the outputs
    OUT1 = registers[OUT1ADDRESS]; 
    OUT2 = registers[OUT2ADDRESS];
  
end

endmodule