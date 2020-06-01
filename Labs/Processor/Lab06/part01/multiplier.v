/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module multiplier(DATA1, DATA2, RESULT);

input [7:0] DATA1, DATA2; //declare inputs
output reg [7:0] RESULT;      //declare outputs

wire [7:0] SHIFT0, SHIFT1, SHIFT2, SHIFT3, SHIFT4, SHIFT5, SHIFT6, SHIFT7; //intermediate wires to hold the values of the shifts
reg [7:0] RES0, RES1, RES2, RES3, RES4, RES5, RES6, RES7; //registers to hold the values of shifts needed to take the multiplication result

assign SHIFT0 = {DATA1[7], DATA1[6], DATA1[5], DATA1[4], DATA1[3], DATA1[2], DATA1[1], DATA1[1'b0]};
assign SHIFT1 = {DATA1[6], DATA1[5], DATA1[4], DATA1[3], DATA1[2], DATA1[1], DATA1[1'b0], 1'b0};
assign SHIFT2 = {DATA1[5], DATA1[4], DATA1[3], DATA1[2], DATA1[1], DATA1[1'b0], 1'b0, 1'b0};
assign SHIFT3 = {DATA1[4], DATA1[3], DATA1[2], DATA1[1], DATA1[0], 1'b0, 1'b0, 1'b0};
assign SHIFT4 = {DATA1[3], DATA1[2], DATA1[1], DATA1[0], 1'b0, 1'b0, 1'b0, 1'b0};
assign SHIFT5 = {DATA1[2], DATA1[1], DATA1[0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
assign SHIFT6 = {DATA1[1], DATA1[0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
assign SHIFT7 = {DATA1[0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};

always @(*) //this block is used to deter mine whether which set of shifts needed to be added.
begin  // for this we can also use a multiplexer unit
  if (DATA2[0]) 
    RES0 = SHIFT0;
  else 
    RES0 = 8'd0;

  if (DATA2[1]) 
    RES1 = SHIFT1;
  else 
    RES1 = 8'd0;

  if (DATA2[2]) 
    RES2 = SHIFT2;
  else 
    RES2 = 8'd0;

  if (DATA2[3]) 
    RES3 = SHIFT3;
  else 
    RES3 = 8'd0;

  if (DATA2[4]) 
    RES4 = SHIFT4;
  else 
    RES4 = 8'd0;

  if (DATA2[5]) 
    RES5 = SHIFT5;
  else 
    RES5 = 8'd0;

  if (DATA2[6]) 
    RES6 = SHIFT6;
  else 
    RES6 = 8'd0;

  if (DATA2[7]) 
    RES7 = SHIFT7;
  else 
    RES7 = 8'd0;
end

always @ (*) #3 RESULT = RES0 + RES1 + RES2 + RES3 + RES4 + RES5 + RES6 + RES7; //add the final result

endmodule