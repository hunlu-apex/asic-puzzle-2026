`timescale 1ps/1ps

module tb_success;
    reg        clk;
    reg        rst_n;
    reg        enable;
    reg        I;
    wire [7:0] O;
    wire       success;

    // Chronological order: bit 120 is sampled first.
    localparam [120:0] FIRST_FAILURE_INPUT =
        121'b0010101000000010110000101001100000000010000001110110000100101100001110011000000010110000001011100000000010000011001110000;
    localparam [120:0] SUCCESS_INPUT =
        121'b0000000101010000100000000000010101010000000000001010000001000001000000100000101000010000000100000010000010010001010000000;
    localparam [120:0] SECOND_FAILURE_INPUT =
        121'b1101011000010011110000000001000001000011000011101110000100001100001001011000000101110000110011100000000010000000000100000;

    // One representative input recovered for each distinct output trace.
    // SUCCESS_INPUT above is also the recovered (* TWO STARS *) input.
    localparam [120:0] TRY_AGAIN_INPUT =
        121'b1111111111111110111111000011010101111110000111000000000010010000000000000000100010000000100111101000000100100100000111001;
    localparam [120:0] EMPTY_SKY_INPUT = {121{1'b0}};
    localparam [120:0] BIG_BANG_INPUT = {121{1'b1}};
    localparam [120:0] TWO_NOT_TOUCH_INPUT =
        121'b0101000000000000010100000000010100010100000010000100000000000100010000010000101100000000000000001100001100000010000001000;

    integer mismatches;

    puzzle dut (
        .I(I),
        .clk(clk),
        .enable(enable),
        .rst_n(rst_n),
        .O(O),
        .success(success)
    );

    always #5000 clk = ~clk;

    task automatic reset_dut;
        begin
            enable = 1'b0;
            I = 1'b0;
            rst_n = 1'b0;
            repeat (3) @(posedge clk);
            @(negedge clk);
            rst_n = 1'b1;
        end
    endtask

    task automatic run_case(
        input [120:0] bits,
        input [8*15-1:0] expected_message,
        input expected_success,
        input integer output_length,
        input integer case_number
    );
        integer bit_index;
        integer output_index;
        integer initial_mismatches;
        reg [7:0] expected_byte;
        begin
            initial_mismatches = mismatches;
            reset_dut();

            // Leave one idle rising edge after reset, matching example_inputs.vcd.
            @(negedge clk);
            enable = 1'b1;
            for (bit_index = 0; bit_index < 121; bit_index = bit_index + 1) begin
                I = bits[120-bit_index];
                #10000;
            end
            enable = 1'b0;
            I = 1'b0;

            // The first output byte and result appear on the next rising edge.
            @(posedge clk);
            #1;
            $write("case %0d: O=\"", case_number);
            for (output_index = 0; output_index < output_length;
                 output_index = output_index + 1) begin
                if (output_index != 0) begin
                    @(posedge clk);
                    #1;
                end
                expected_byte = expected_message[
                    8*(output_length-output_index)-1 -: 8
                ];
                $write("%c", O);
                if (O !== expected_byte) begin
                    $display("\nMISMATCH case=%0d output_index=%0d O=%02h expected=%02h",
                             case_number, output_index, O, expected_byte);
                    mismatches = mismatches + 1;
                end
                if (success !== expected_success) begin
                    $display("\nMISMATCH case=%0d output_index=%0d success=%b expected=%b",
                             case_number, output_index, success, expected_success);
                    mismatches = mismatches + 1;
                end
            end
            $display("\" success=%b", success);

            // Each message is followed by a zero byte; success remains sticky.
            @(posedge clk);
            #1;
            if (O !== 8'h00 || success !== expected_success) begin
                $display("MISMATCH case=%0d terminator O=%02h success=%b",
                         case_number, O, success);
                mismatches = mismatches + 1;
            end

            if (mismatches == initial_mismatches)
                $display("case %0d PASS", case_number);
        end
    endtask

    initial begin
        $dumpfile("all_outputs.vcd");
        $dumpvars(1, tb_success);

        clk = 1'b0;
        rst_n = 1'b1;
        enable = 1'b0;
        I = 1'b0;
        mismatches = 0;

        // Preserve the original failure -> success -> failure regression.
        run_case(FIRST_FAILURE_INPUT,  "TRY AGAIN",       1'b0,  9, 1);
        run_case(SUCCESS_INPUT,        "(* TWO STARS *)", 1'b1, 15, 2);
        run_case(SECOND_FAILURE_INPUT, "TRY AGAIN",       1'b0,  9, 3);

        // Exercise the remaining representatives from the exhaustive search.
        // SUCCESS_INPUT above already covers the fifth distinct trace.
        run_case(TRY_AGAIN_INPUT,      "TRY AGAIN",       1'b0,  9, 4);
        run_case(EMPTY_SKY_INPUT,      "EMPTY SKY",       1'b0,  9, 5);
        run_case(BIG_BANG_INPUT,       "BIG BANG",        1'b0,  8, 6);
        run_case(TWO_NOT_TOUCH_INPUT,  "TWO NOT TOUCH",   1'b0, 13, 7);

        if (mismatches != 0)
            $fatal(1, "FAIL: %0d mismatches", mismatches);
        $display("PASS: all 7 cases completed in one testbench run");
        $finish;
    end
endmodule
