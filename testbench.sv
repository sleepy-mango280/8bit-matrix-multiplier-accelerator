module testbench;

    logic clk;
    logic rst;
    logic start;

    logic [7:0] A00, A01, A10, A11;
    logic [7:0] B00, B01, B10, B11;

    logic [15:0] C00, C01, C10, C11;
    logic done;

    matrix_multiplier_2x2_8bit dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A00(A00),
        .A01(A01),
        .A10(A10),
        .A11(A11),
        .B00(B00),
        .B01(B01),
        .B10(B10),
        .B11(B11),
        .C00(C00),
        .C01(C01),
        .C10(C10),
        .C11(C11),
        .done(done)
    );

    always

    initial begin
        clk = 0;
        rst = 1;
        start = 0;

        A00 = 8'd2;
        A01 = 8'd3;
        A10 = 8'd4;
        A11 = 8'd5;

        B00 = 8'd6;
        B01 = 8'd7;
        B10 = 8'd8;
        B11 = 8'd9;

        rst = 0;

        start = 1;

        start = 0;

        wait(done);

        $display("C00 = %d", C00);
        $display("C01 = %d", C01);
        $display("C10 = %d", C10);
        $display("C11 = %d", C11);

        $finish;
    end

endmodule
