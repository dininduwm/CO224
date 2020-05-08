module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

input [7:0] IN;  // 8 bit data input
input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS; // 3 bit data inputs
input WRITE, CLK, RESET; // 1 bit data inputs
output [7:0] OUT1, OUT2; // 8 bit data outputs

reg [7:0] registers [7:0]; // 8x8 register file

reg [7:0] OUT1CURR, OUT2CURR; //take the current value of the output to give after delay

integer i;

assign #2 OUT1 = registers[OUT1ADDRESS]; //writing data to outputs
assign #2 OUT2 = registers[OUT2ADDRESS]; //writing data to outputs

always @ (posedge CLK) // this code block run when we are in a positive clock edge
begin
    // write input to the in address
    if (WRITE == 1)
        #2 registers[INADDRESS] = IN;     
end


// combinational logic output for reset signal (level triggered input)
always @ (*)
begin
    if (RESET == 1)
    begin
        #2 
        for (i = 0; i < 8; i++) //looping through register file and setting them to 0s
        begin
            registers[i] = 0;
        end   
    end
    
end

endmodule