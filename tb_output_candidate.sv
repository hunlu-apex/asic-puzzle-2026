`timescale 1ps/1ps

module tb_output_candidate;
    reg         clk;
    reg         rst_n;
    reg         enable;
    reg         I;
    wire [7:0]  O;
    wire        success;
    reg [120:0] input_bits;
    reg         result_success;
    integer     bit_index;
    integer     output_index;
    integer     output_samples;
    string      vcd_file;

    puzzle dut (
        .I(I),
        .clk(clk),
        .enable(enable),
        .rst_n(rst_n),
        .O(O),
        .success(success)
    );

    always #5000 clk = ~clk;

    initial begin
        if (!$value$plusargs("BITS=%b", input_bits))
            $fatal(1, "missing +BITS=<121-bit-binary-value>");
        if (!$value$plusargs("SAMPLES=%d", output_samples))
            output_samples = 74;
        if (!$value$plusargs("VCD=%s", vcd_file))
            vcd_file = "candidate_output.vcd";

        $dumpfile(vcd_file);
        $dumpvars(1, tb_output_candidate);

        clk = 1'b0;
        rst_n = 1'b0;
        enable = 1'b0;
        I = 1'b0;

        #30000 rst_n = 1'b1;
        #10000 enable = 1'b1;
        for (bit_index = 0; bit_index < 121; bit_index = bit_index + 1) begin
            I = input_bits[120-bit_index];
            #10000;
        end

        enable = 1'b0;
        I = 1'b0;

        @(posedge clk);
        #1;
        result_success = success;
        $write("TRACE_HEX=");
        for (output_index = 0; output_index < output_samples;
             output_index = output_index + 1) begin
            if (output_index != 0) begin
                @(posedge clk);
                #1;
            end
            $write("%02x", O);
        end
        $display("");
        $display("SUCCESS=%b", result_success);
        $finish;
    end
endmodule
