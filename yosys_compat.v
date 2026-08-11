module pulldown(output Y);
    assign Y = 1'b0;
endmodule

module pullup(output Y);
    assign Y = 1'b1;
endmodule


module sky130_fd_sc_hd__udp_mux_2to1 (
    output X,
    input A0,
    input A1,
    input S
);
    assign X = S ? A1 : A0;
endmodule


module sky130_fd_sc_hd__udp_dff$P (
    output reg Q,
    input D,
    input CLK
);
    always @(posedge CLK)
        Q <= D;
endmodule


module sky130_fd_sc_hd__udp_dff$PR (
    output reg Q,
    input D,
    input CLK,
    input RESET
);
    always @(posedge CLK or posedge RESET)
        if (RESET)
            Q <= 1'b0;
        else
            Q <= D;
endmodule


module sky130_fd_sc_hd__udp_dff$PS (
    output reg Q,
    input D,
    input CLK,
    input SET
);
    always @(posedge CLK or posedge SET)
        if (SET)
            Q <= 1'b1;
        else
            Q <= D;
endmodule
