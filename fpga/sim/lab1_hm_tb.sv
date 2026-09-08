// -------------------------------------------------------------
// lab01_tb.sv
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for Lab 1 top-level module
// -------------------------------------------------------------
`timescale 1ns/1ns
`default_nettype none
`define N_TV 16

module lab01_tb;
    logic tb_clk = 0;
    logic tb_reset;
    logic [3:0] s;
    logic [2:0] led;
    logic [6:0] seg;
    logic [6:0] seg_expected;
    logic led0_expected;
    logic led1_expected;
    logic [31:0] vectornum, errors;
    logic [12:0] testvectors[10000:0]; //format s[3:0]_led[0]_led[1]_seg[6:0]

    lab1_hm #(.blink_max(4)) dut (
        .s(s), .led(led), .seg(seg));
    always begin
        tb_clk = 1;
        #5;
        tb_clk = 0;
        #5;
    end

    initial begin
        $readmemb("C:/Users/hmurphy/Downloads/E155/lab1_murphy/lab01_sim/lab1_hm_testvectors.tv", testvectors, 0, `N_TV - 1 ); // Load test vectors from a file
        vectornum = 0;
        errors = 0;
        tb_reset = 1;
        #20;
        tb_reset = 0;
    end

     always @(posedge tb_clk) begin
        #1;
        {s, led1_expected, led0_expected, seg_expected} = testvectors[vectornum];
    end

    // Check results on negedge tb_clk
    always @(negedge tb_clk) begin
        if (~tb_reset) begin
            if (led[0] !== led0_expected || led[1] !== led1_expected ||seg !== seg_expected) begin
                $display("Error at vec %0d: s=%b", vectornum, s);
                $display("  led[0]=%b (%b expected)", led[0], led0_expected);
                $display("  led[1]=%b (%b expected)", led[1], led1_expected);
                $display("  seg=%b (%b expected)",    seg,    seg_expected);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 13'bx) begin
                $display("%0d tests completed with %0d errors.", vectornum, errors);
                $finish;
            end
        end
    end

endmodule


