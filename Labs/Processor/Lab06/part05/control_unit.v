/*
Author - W M D U Thilakarathna
Reg No - E/16/366
*/

module control_unit(OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP, jump, beq, bne, alu_shiftMUXSEL, bShifterOpCode, memReadEn, memWriteEn, memMUXSEL, RESET);

    parameter [7:0] ADD   = 8'h00, 
                    SUB   = 8'h01,
                    AND   = 8'h02,
                    OR    = 8'h03,
                    MOV   = 8'h04,
                    LOADI = 8'h05,
                    J     = 8'h06,
                    BEQ   = 8'h07,
                    BNE   = 8'h08,
                    SLL   = 8'h09,
                    SRL   = 8'h0A,
                    SRA   = 8'h0B,
                    ROR   = 8'h0C,
                    MUL   = 8'h0D,
                    LWD   = 8'h0E,
                    LWI   = 8'h0F,
                    SWD   = 8'h10,
                    SWI   = 8'h11;

    input [7:0] OP; //input op code
    input RESET, ALUCOMP; // RESET input and alu comparator signal
    output reg twoscompMUXSEL, immeMUXSEL, regWRITEEN, jump, beq, bne, alu_shiftMUXSEL, memReadEn, memWriteEn, memMUXSEL; //output registers
    output reg [2:0] aluOP;
    output reg [1:0] bShifterOpCode;

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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        J:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b111;        //cpu op code  
                jump = 1'b1;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
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
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        BNE:
            begin
                #1
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b1;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        SLL:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b1;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b11;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end
        
        SRL:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b111;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b1;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        SRA:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b111;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b1;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b01;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        ROR:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b111;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b1;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b10;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        MUL:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b100;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        LWD:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b1;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b1;      //memory read enable
            end

        LWI:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b1;      //memory select mux
                memWriteEn = 1'b0;     //memory write enable
                memReadEn = 1'b1;      //memory read enable
            end

        SWD:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b1;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end

        SWI:
            begin
                #1
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b0;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
                jump = 1'b0;           //jump instruction
                beq = 1'b0;            //beq instruction
                bne = 1'b0;            //bne instruction
                alu_shiftMUXSEL = 1'b0;//select the out of alu or the barrel shifter
                bShifterOpCode = 2'b00;//barrel shifter op code
                memMUXSEL = 1'b0;      //memory select mux
                memWriteEn = 1'b1;     //memory write enable
                memReadEn = 1'b0;      //memory read enable
            end
        endcase
    end

    always @ (*) //if reset set the pc select
    begin
      if (RESET) 
      begin
        jump = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
      end
    end

endmodule