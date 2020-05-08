/*
    op codes
    00000000 - add
    00000001 - sub
    00000010 - and
    00000011 - or
    00000100 - mov
    00000101 - loadi
    */

module control_unit(OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP);
    input [7:0] OP; //input op code
    output reg twoscompMUXSEL, immeMUXSEL, regWRITEEN; //output registers
    output reg [2:0] aluOP;

    always @ (*)
    begin
      case (OP)
        'h00: //add
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        'h01: //sub
            begin
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        'h02: //and
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b010;        //cpu op code  
            end

        'h03: //or
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b011;        //cpu op code  
            end

        'h04: //mov
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end

        'h05: //loadi
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end
        endcase
    end

endmodule