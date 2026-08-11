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

    function automatic [7:0] expected_output(
        input expected_success,
        input integer index
    );
        begin
            if (expected_success) begin
                case (index)
                     0: expected_output = "(";
                     1: expected_output = "*";
                     2: expected_output = " ";
                     3: expected_output = "T";
                     4: expected_output = "W";
                     5: expected_output = "O";
                     6: expected_output = " ";
                     7: expected_output = "S";
                     8: expected_output = "T";
                     9: expected_output = "A";
                    10: expected_output = "R";
                    11: expected_output = "S";
                    12: expected_output = " ";
                    13: expected_output = "*";
                    14: expected_output = ")";
                    default: expected_output = 8'h00;
                endcase
            end else begin
                case (index)
                    0: expected_output = "T";
                    1: expected_output = "R";
                    2: expected_output = "Y";
                    3: expected_output = " ";
                    4: expected_output = "A";
                    5: expected_output = "G";
                    6: expected_output = "A";
                    7: expected_output = "I";
                    8: expected_output = "N";
                    default: expected_output = 8'h00;
                endcase
            end
        end
    endfunction

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
        input expected_success,
        input integer output_length,
        input integer case_number
    );
        integer bit_index;
        integer output_index;
        integer initial_mismatches;
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
                $write("%c", O);
                if (O !== expected_output(expected_success, output_index)) begin
                    $display("\nMISMATCH case=%0d output_index=%0d O=%02h expected=%02h",
                             case_number, output_index, O,
                             expected_output(expected_success, output_index));
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
        $dumpfile("success_outputs.vcd");
        $dumpvars(1, tb_success);

        clk = 1'b0;
        rst_n = 1'b1;
        enable = 1'b0;
        I = 1'b0;
        mismatches = 0;

        run_case(FIRST_FAILURE_INPUT,  1'b0,  9, 1);
        run_case(SUCCESS_INPUT,        1'b1, 15, 2);
        run_case(SECOND_FAILURE_INPUT, 1'b0,  9, 3);

        if (mismatches != 0)
            $fatal(1, "FAIL: %0d mismatches", mismatches);
        $display("PASS: failure -> success -> failure regression completed");
        $finish;
    end
endmodule
