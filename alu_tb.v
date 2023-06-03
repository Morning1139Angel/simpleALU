module alu_tb;
  parameter WIDTH = 8;
  parameter HOLD = 0;
  parameter CLEAR = HOLD + 1;
  parameter ADD = CLEAR + 1;
  parameter SUB = ADD + 1;
  parameter AND = SUB + 1;
  parameter NEG = AND + 1;
  parameter NOT = NEG + 1;
  parameter XOR = NOT + 1;

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
    
    // Test case 1: HOLD
    in = 0;
    control = HOLD;
    #10;

    // Test case 2: CLEAR
    in = 0;
    control = CLEAR;
    #10;

    // Test case 3: ADD
    in = 5;
    control = ADD;
    #10;

    // Test case 4: SUB
    in = 3;
    control = SUB;
    #10;
    // Test case 5: NEG
    in = 0;
    control = NEG;
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


    $finish;
  end

  initial begin
        $dumpfile("./vcd/alu.vcd");
        $dumpvars(0, alu_tb);
    end
    
endmodule