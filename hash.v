module hash(clk, rst, mode, num, cmplt);
    
    parameter num_size = 10;
    parameter table_size = 10;
    parameter index_bits = 4; // as 2^4 options

    input clk, rst;
    input [1:0] mode;
    input [num_size-1:0] num;

    output cmplt;

    reg [num_size-1:0] hash_table [0:table_size-1];
    reg [1:0] state;
    reg [index_bits-1:0] index;
    reg set;
    
    logic [1:0] next_state;
    logic [index_bits-1:0] index_ff;
    logic [num_size-1:0] hash_table_ff;
    logic set_ff;

    always_ff @(posedge clk) begin
         if (rst) begin
            for (i = 0; i < table_size; i++) begin
                    hash_table[i] <= 10'd0;
            end
            state <= 2'd0;
            index <= 4'd0; // index bits used
            set <= 1'b0;
        end
        else begin
            hash_table[index] <= (set) ? hash_table_ff : hash_table[index];
            state <= next_state;
            index <= index_ff;
            set <= set_ff;
        end
    end
    
     always_comb begin
        // default values
        next_state = state;
        index_ff = index;
        set_ff = 1'b0;
        
        case(state)
            2'd0 : begin // Nada
                if (mode == 2'b01) begin
                   index_ff = num % table_size;
                   set_ff = 1'b1;
                   next_state <= 2'd1;
                end
            
            end
        endcase
     end

endmodule