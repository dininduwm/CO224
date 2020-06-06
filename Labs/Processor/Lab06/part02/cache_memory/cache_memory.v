`include "data_memory.v"

module cache_memory(
	clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait
);
    input				clock;
    input           	reset;
    input           	read;
    input           	write;
    input[7:0]      	address;
    input[7:0]     	    writedata;
    output reg [7:0]	readdata;
    output reg      	busywait;

    //Declare cache memory array 256x8-bits 
    reg [31:0] data_array [8:0];
    //Declare tag array 256x8-bits 
    reg [2:0] tag_array [8:0];
    //Declare valid bit array 256x8-bits 
    reg [1:0] dirtyBit_array [8:0];
    //Declare valid bit array 256x8-bits 
    reg [1:0] validBit_array [8:0];

    parameter IDLE = 2'b00, MEM_READ = 2'b01, MEM_WRITE = 2'b10;
    reg [1:0] state, next_state;

    // variables to handle state changes
    reg CURRENT_DIRTY, CURRENT_VALID, TAG_MATCH;

    // tempory variable to hold the data from the cache
    reg [7:0] tempory_data;

    // variables to hold the values of the memory module
    reg MAIN_MEM_READ, MAIN_MEM_WRITE;
    reg [5:0] MAIN_MEM_ADDRESS;
    reg [31:0] MAIN_MEM_WRITE_DATA;
    wire [31:0] MAIN_MEM_READ_DATA;
    wire MAIN_MEM_BUSY_WAIT;

    //initiating the memory module
    data_memory myDataMem (clock, reset, MAIN_MEM_READ, MAIN_MEM_WRITE, MAIN_MEM_ADDRESS,
            MAIN_MEM_WRITE_DATA, MAIN_MEM_READ_DATA, MAIN_MEM_BUSY_WAIT);

    // decoding the address
    wire [2:0] tag, index;
    wire [1:0] offset;
    assign tag = address[7:5];
    assign index = address[4:2];
    assign offset = address[1:0];

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if (!CURRENT_VALID && read && !write)  
                    next_state = MEM_READ;
                else if (CURRENT_VALID && TAG_MATCH && read && !write)
                    next_state = IDLE;
                else if (CURRENT_VALID && !CURRENT_DIRTY && !TAG_MATCH && read && !write)
                    next_state = MEM_READ;
                else if (CURRENT_VALID && CURRENT_DIRTY && !TAG_MATCH && read && !write)
                    next_state = MEM_WRITE;
            
            MEM_READ:
                if (MAIN_MEM_BUSY_WAIT)
                    next_state = MEM_READ;
                else    
                    begin
                        next_state = IDLE;
                        // put the read data to the cache
                        data_array[index] = MAIN_MEM_READ_DATA;
                        tag_array[index] = tag;
                        validBit_array[index] = 1'b1;
                        dirtyBit_array[index] = 1'b0;
                    end


            MEM_WRITE:
                if (MAIN_MEM_BUSY_WAIT)
                    next_state = MEM_WRITE;
                else    
                    next_state = IDLE;
            
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                // set main memory read and write signal to low
                MAIN_MEM_READ = 1'b0;
                MAIN_MEM_WRITE = 1'b0;

                if (read)
                begin
                  #1
                  if (tag_array[index] == tag) // tag comparisan
                    TAG_MATCH = 1'b1;
                  else
                    TAG_MATCH = 1'b0;

                  CURRENT_VALID = validBit_array[index];
                  CURRENT_DIRTY = dirtyBit_array[index];
                  // fetching data
                  case(offset)
                    2'b00:
                        tempory_data = data_array[index][7:0];
                    2'b01:
                        tempory_data = data_array[index][15:8];
                    2'b10:
                        tempory_data = data_array[index][23:16];
                    2'b11:
                        tempory_data = data_array[index][31:24];
                  endcase

                  #1 
                  if (TAG_MATCH && CURRENT_VALID)
                  begin
                    // TODO: Set the busy wait to 0
                    readdata = tempory_data; // output the data
                  end

                end
                
            end
         
            MEM_READ: 
            begin
                MAIN_MEM_READ = 1'b1;
                MAIN_MEM_WRITE = 1'b0;

                MAIN_MEM_ADDRESS = {tag, index};
            end

            MEM_WRITE: 
            begin
                MAIN_MEM_READ = 1'b0;
                MAIN_MEM_WRITE = 1'b1;
            end
            
        endcase
    end

    integer i;

    // sequential logic for state transitioning 
    always @(posedge clock, reset)
    begin
        if(reset)
        begin
            state = IDLE;
            next_state = IDLE;
            busywait = 1'b0;
            for (i=0;i<8; i=i+1) // resetting the registers
                begin
                    data_array[i] = 0;
                    validBit_array[i] = 0;
                    dirtyBit_array[i] = 0;
                end
        end
        else
            state = next_state;
    end

    /* Cache Controller FSM End */

endmodule