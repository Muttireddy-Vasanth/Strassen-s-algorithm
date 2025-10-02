module multiplier #(
    parameter WIDTH = 16
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [2*WIDTH-1:0] product
);

    assign product = a * b;

endmodule


module strassen #(
    parameter WIDTH = 16
)(
    input  wire [WIDTH-1:0] A11, A12, A21, A22,
    input  wire [WIDTH-1:0] B11, B12, B21, B22,
    output wire [2*WIDTH-1:0] C11, C12, C21, C22
);

    // Intermediate sums and differences extended by 1 bit for overflow safety
    wire [WIDTH:0] s1 = A11 + A22;
    wire [WIDTH:0] s2 = B11 + B22;
    wire [WIDTH:0] s3 = A21 + A22;
    wire [WIDTH:0] s4 = B12 - B22;
    wire [WIDTH:0] s5 = B21 - B11;
    wire [WIDTH:0] s6 = A11 + A12;
    wire [WIDTH:0] s7 = B22;
    wire [WIDTH:0] s8 = A21 - A11;
    wire [WIDTH:0] s9 = B11 + B12;
    wire [WIDTH:0] s10 = A12 - A22;
    wire [WIDTH:0] s11 = B21 + B22;

    // Wires for products M1 to M7, with output width doubled
    wire [2*WIDTH+1:0] M1, M2, M3, M4, M5, M6, M7;

    // Instantiate multiplier modules
    multiplier #(WIDTH+1) mul1 (.a(s1),   .b(s2),   .product(M1));
    multiplier #(WIDTH+1) mul2 (.a(s3),   .b(B11),  .product(M2));
    multiplier #(WIDTH+1) mul3 (.a(A11),  .b(s4),   .product(M3));
    multiplier #(WIDTH+1) mul4 (.a(A22),  .b(s5),   .product(M4));
    multiplier #(WIDTH+1) mul5 (.a(s6),   .b(s7),   .product(M5));
    multiplier #(WIDTH+1) mul6 (.a(s8),   .b(s9),   .product(M6));
    multiplier #(WIDTH+1) mul7 (.a(s10),  .b(s11),  .product(M7));

    // Compute output matrix sub-blocks using Strassen recombination
    assign C11 = M1 + M4 - M5 + M7;
    assign C12 = M3 + M5;
    assign C21 = M2 + M4;
    assign C22 = M1 - M2 + M3 + M6;

endmodule


module multiplier #(
    parameter WIDTH = 16
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [2*WIDTH-1:0] product
);

    assign product = a * b;

endmodule
