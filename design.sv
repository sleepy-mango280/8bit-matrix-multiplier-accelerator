module matrix_multiplier_2x2_8bit (
    input  logic        clk,
    input  logic        rst,
    input  logic        start,

    input  logic [7:0]  A00,
    input  logic [7:0]  A01,
    input  logic [7:0]  A10,
    input  logic [7:0]  A11,

    input  logic [7:0]  B00,
    input  logic [7:0]  B01,
    input  logic [7:0]  B10,
    input  logic [7:0]  B11,

    output logic [15:0] C00,
    output logic [15:0] C01,
    output logic [15:0] C10,
    output logic [15:0] C11,

    output logic        done
);

    logic sel;
    logic busy;

    logic [7:0] m1_a, m1_b;
    logic [7:0] m2_a, m2_b;
    logic [7:0] m3_a, m3_b;
    logic [7:0] m4_a, m4_b;

    logic [15:0] product1;
    logic [15:0] product2;
    logic [15:0] product3;
    logic [15:0] product4;

    logic [15:0] saved1;
    logic [15:0] saved2;
    logic [15:0] saved3;
    logic [15:0] saved4;

    always_comb begin
        if (sel == 1'b0) begin
            m1_a = A00;
            m1_b = B00;
            m2_a = A00;
            m2_b = B01;
            m3_a = A10;
            m3_b = B00;
            m4_a = A10;
            m4_b = B01;
        end
        else begin
            m1_a = A01;
            m1_b = B10;
            m2_a = A01;
            m2_b = B11;
            m3_a = A11;
            m3_b = B10;
            m4_a = A11;
            m4_b = B11;
        end
    end

    assign product1 = m1_a * m1_b;
    assign product2 = m2_a * m2_b;
    assign product3 = m3_a * m3_b;
    assign product4 = m4_a * m4_b;

    always_ff @(posedge clk) begin
        if (rst) begin
            sel <= 1'b0;
            busy <= 1'b0;
            done <= 1'b0;

            saved1 <= 16'd0;
            saved2 <= 16'd0;
            saved3 <= 16'd0;
            saved4 <= 16'd0;

            C00 <= 16'd0;
            C01 <= 16'd0;
            C10 <= 16'd0;
            C11 <= 16'd0;
        end
        else begin
            done <= 1'b0;

            if (!busy && start) begin
                saved1 <= product1;
                saved2 <= product2;
                saved3 <= product3;
                saved4 <= product4;

                sel <= 1'b1;
                busy <= 1'b1;
            end
            else if (busy) begin
                C00 <= saved1 + product1;
                C01 <= saved2 + product2;
                C10 <= saved3 + product3;
                C11 <= saved4 + product4;

                done <= 1'b1;
                sel <= 1'b0;
                busy <= 1'b0;
            end
        end
    end

endmodule
