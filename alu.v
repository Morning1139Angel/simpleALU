module alu #(parameter WIDTH = 8)
            (input[WIDTH-1 :0] in,
             input[2: 0] control,
             input clk,
             output reg[WIDTH-1: 0] accumulator,
             output[3: 0] flags);
    
    `include "alu_instruction_codes.v"
    
    reg[WIDTH-1:0] tempResult;
    reg carry, overflow, temp_sign;
    wire acc_sign, in_sign, zero;
    
    assign acc_sign  = accumulator[WIDTH-1];
    assign in_sign   = in[WIDTH-1];
    assign zero      = ~|accumulator;
    
    assign flags = {carry, zero, overflow, acc_sign};
    
    initial begin
        accumulator = 0;
        tempResult  = 0;
        carry       = 0;
        overflow    = 0;
    end
    
    always @(posedge clk) begin
        carry    = 0;
        overflow = 0;
        
        case (control)
            HOLD : begin
                accumulator <= accumulator;
            end
            CLEAR : begin
                accumulator <= 0;
            end
            ADD : begin
                {carry, tempResult} = accumulator + in;
                temp_sign = tempResult[WIDTH-1];
                overflow            = (in_sign != acc_sign) ? 0 : (temp_sign ^ acc_sign);
                accumulator <= tempResult;
            end
            SUB : begin
                {carry, tempResult} = accumulator - in;
                temp_sign = tempResult[WIDTH-1];
                overflow            = (in_sign == acc_sign) ? 0 : (temp_sign ^ acc_sign);
                accumulator <= tempResult;
            end
            AND : begin
                accumulator <= accumulator & in;
            end
            NEG : begin
                accumulator <= -accumulator;
            end
            NOT : begin
                accumulator <= ~accumulator;
            end
            XOR : begin
                accumulator <= accumulator ^ in;
            end
            default : begin
                accumulator <= accumulator;
            end
        endcase
    end
endmodule
