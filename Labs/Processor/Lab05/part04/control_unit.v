/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module control_unit(OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP, jump, beq, RESET);

    parameter [7:0] ADD   = 8'h00, 
                    SUB   = 8'h01,
                    AND   = 8'h02,
                    OR    = 8'h03,
                    MOV   = 8'h04,
                    LOADI = 8'h05,
                    J     = 8'h06,
                    BEQ   = 8'h07;

    input [7:0] OP; //input op code
    input RESET, ALUCOMP; // RESET input and alu comparator signal
    output reg twoscompMUXSEL, immeMUXSEL, regWRITEEN, jump, beq; //output registers
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
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        SUB:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        AND:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b010;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        OR:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b011;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        MOV:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        LOADI:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        J:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
                jump = 1'b1;           //jump instruction
                beq = 1'b0;            //beq instruction
            end

        BEQ:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b1;            //beq instruction
            end
        endcase
    end

    always @ (*) //if reset set the pc select
    begin
      if (RESET) 
      begin
        jump = 1'b0;
        beq = 1'b0;
      end
    end

endmodule