`timescale 1ns/1ps

module tb_strassen;

  parameter WIDTH = 16;

  reg  [WIDTH-1:0] A11, A12, A21, A22;
  reg  [WIDTH-1:0] B11, B12, B21, B22;

  wire [2*WIDTH-1:0] C11, C12, C21, C22;

  // Instantiate the strassen_2x2 module
  strassen #(.WIDTH(WIDTH)) uut (
    .A11(A11), .A12(A12), .A21(A21), .A22(A22),
    .B11(B11), .B12(B12), .B21(B21), .B22(B22),
    .C11(C11), .C12(C12), .C21(C21), .C22(C22)
  );

  initial begin
    // Test case 1
    A11 = 16'd1;  A12 = 16'd3;
    A21 = 16'd7;  A22 = 16'd5;
    B11 = 16'd6;  B12 = 16'd8;
    B21 = 16'd4;  B22 = 16'd2;

    #10;  // wait for combinational output
    $display("Test case 1:");
    $display("Input A = [%d %d; %d %d]", A11, A12, A21, A22);
    $display("Input B = [%d %d; %d %d]", B11, B12, B21, B22);
    $display("Output C = [%d %d; %d %d]", C11, C12, C21, C22);

    // Expected:
    // C11 = 18, C12 = 14, C21 = 62, C22 = 66

    // Test case 2
    A11 = 16'd2;  A12 = 16'd0;
    A21 = 16'd1;  A22 = 16'd4;
    B11 = 16'd5;  B12 = 16'd1;
    B21 = 16'd3;  B22 = 16'd7;

    #10;
    $display("Test case 2:");
    $display("Input A = [%d %d; %d %d]", A11, A12, A21, A22);
    $display("Input B = [%d %d; %d %d]", B11, B12, B21, B22);
    $display("Output C = [%d %d; %d %d]", C11, C12, C21, C22);

    // Expected:
    // C11 = 10, C12 = 7, C21 = 17, C22 = 29

    #10;
    $finish;
  end

endmodule
