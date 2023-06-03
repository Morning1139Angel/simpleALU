`include "alu.v"

module alu_tb;
  parameter WIDTH = 8;
  `include "alu_instruction_codes.v"

  reg [WIDTH-1:0] in;
  reg [2:0] control;
  reg clk;
  wire [WIDTH-1:0] accumulator;
  wire [3:0] flags;

  alu #(.WIDTH(WIDTH)) dut (
    .in(in),
    .control(control),
    .clk(clk),
    .accumulator(accumulator),
    .flags(flags)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Accumulator = %h, Flags = %b", accumulator, flags);
    
    // Test case 1: ADD
    in = 5;
    control = ADD;
    #10;

    // Test case 2: HOLD
    in = 0;
    control = HOLD;
    #10;

    // Test case 3: SUB
    in = 3;
    control = SUB;
    #10;
    // Test case 4: NEG
    in = 0;
    control = NEG;
    #10;

    // Test case 5: CLEAR
    in = 0;
    control = CLEAR;
    #10;

    // Test case 6: NOT
    in = 0;
    control = NOT;
    #10;

    // Test case 7: XOR
    in = 9;
    control = XOR;
    #10;

    // Test case 8: AND
    in = 12;
    control = AND;
    #10;

    // Test case 9: possitive SUM overflow
    //store 120 = 01111000 
    in = 0;
    control = CLEAR;
    #10;

    in = 120;
    control = ADD;
    #10;

    // add 57 = 00111001
    in = 57;
    control = ADD;
    #10;


    // Test case 10: negative SUM overflow
    //store -120 = 10001000 
    in = 0;
    control = CLEAR;
    #10;

    in = -120;
    control = ADD;
    #10;

    // add -57 = 11001001
    in = -57;
    control = ADD;
    #10;

    $finish;
  end

  initial begin
        $dumpfile("./vcd/alu.vcd");
        $dumpvars(0, alu_tb);
    end
    
endmodule