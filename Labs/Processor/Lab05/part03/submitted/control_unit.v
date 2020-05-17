/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module control_unit(OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP);

    parameter [7:0] ADD   = 8'h00, 
                    SUB   = 8'h01,
                    AND   = 8'h02,
                    OR    = 8'h03,
                    MOV   = 8'h04,
                    LOADI = 8'h05;

    input [7:0] OP; //input op code
    output reg twoscompMUXSEL, immeMUXSEL, regWRITEEN; //output registers
    output reg [2:0] aluOP;

    always @ (*)
    begin
      case (OP)
        ADD:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        SUB:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        AND:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b010;        //cpu op code  
            end

        OR:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b011;        //cpu op code  
            end

        MOV:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end

        LOADI:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end
        endcase
    end

endmodule