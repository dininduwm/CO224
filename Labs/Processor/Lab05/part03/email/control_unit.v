module control_unit(OP, twoscompMUXSEL, immeMUXSEL, regWRITEEN, aluOP);
    input [7:0] OP; //input op code
    output reg twoscompMUXSEL, immeMUXSEL, regWRITEEN; //output registers
    output reg [2:0] aluOP;

    always @ (*)
    begin
      case (OP)
        'h00: 
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        'h01: 
            begin
                twoscompMUXSEL = 1'b1; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b001;        //cpu op code  
            end

        'h02: 
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b010;        //cpu op code  
            end

        'h03: 
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b011;        //cpu op code  
            end

        'h04: 
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b0;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end

        'h05: 
            begin
                twoscompMUXSEL = 1'b0; //twos compliment select mux
                immeMUXSEL = 1'b1;     //immediate value select mux
                regWRITEEN = 1'b1;     //regwrite enable pin
                aluOP = 3'b000;        //cpu op code  
            end
        endcase
    end

endmodule