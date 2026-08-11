`timescale 1ps/1ps

module tb_example_replay;
    reg        clk;
    reg        rst_n;
    reg        enable;
    reg        I;
    wire [7:0] O;
    wire       success;

    // Bits are listed in the same chronological order in which they appear
    // on I at enabled rising clock edges in example_inputs.vcd.
    localparam [120:0] FIRST_INPUT =
        121'b0010101000000010110000101001100000000010000001110110000100101100001110011000000010110000001011100000000010000011001110000;
    localparam [120:0] SECOND_INPUT =
        121'b1101011000010011110000000001000001000011000011101110000100001100001001011000000101110000110011100000000010000000000100000;

    integer bit_index;
    integer cycle_index;
    integer mismatches;
    reg [7:0] expected_O;

    puzzle dut (
        .I(I),
        .clk(clk),
        .enable(enable),
        .rst_n(rst_n),
        .O(O),
        .success(success)
    );

    always #5000 clk = ~clk;

    task automatic send_input(input [120:0] bits);
        begin
            for (bit_index = 0; bit_index < 121; bit_index = bit_index + 1) begin
                I = bits[120-bit_index];
                #10000;
            end
        end
    endtask

    function automatic [7:0] expected_output(input integer cycle);
        begin
            case (cycle)
                125, 281: expected_output = 8'h54; // T
                126, 282: expected_output = 8'h52; // R
                127, 283: expected_output = 8'h59; // Y
                128, 284: expected_output = 8'h20; // space
                129, 285: expected_output = 8'h41; // A
                130, 286: expected_output = 8'h47; // G
                131, 287: expected_output = 8'h41; // A
                132, 288: expected_output = 8'h49; // I
                133, 289: expected_output = 8'h4e; // N
                default:  expected_output = 8'h00;
            endcase
        end
    endfunction

    // Sample one delta after each active clock edge, after the sequential and
    // combinational cell models have settled.
    always @(posedge clk) begin
        #1;
        expected_O = expected_output(cycle_index);
        if (O !== expected_O) begin
            $display("MISMATCH cycle=%0d time=%0t O=%02h expected=%02h",
                     cycle_index, $time, O, expected_O);
            mismatches = mismatches + 1;
        end
        if (success !== 1'b0) begin
            $display("MISMATCH cycle=%0d time=%0t success=%b expected=0",
                     cycle_index, $time, success);
            mismatches = mismatches + 1;
        end
        cycle_index = cycle_index + 1;
    end

    initial begin
        $dumpfile("replayed_outputs.vcd");
        $dumpvars(1, tb_example_replay);

        clk = 1'b0;
        rst_n = 1'b0;
        enable = 1'b0;
        I = 1'b0;
        cycle_index = 0;
        mismatches = 0;

        #30000 rst_n = 1'b1;
        #10000 enable = 1'b1;
        send_input(FIRST_INPUT);
        enable = 1'b0;

        #310000 rst_n = 1'b0;
        #30000 rst_n = 1'b1;
        #10000 enable = 1'b1;
        send_input(SECOND_INPUT);
        enable = 1'b0;

        #310000;
        if (cycle_index != 312 || mismatches != 0)
            $fatal(1, "FAIL: cycles=%0d mismatches=%0d", cycle_index, mismatches);
        $display("PASS: %0d rising edges checked; O and success match example_inputs.vcd",
                 cycle_index);
        $finish;
    end
endmodule
