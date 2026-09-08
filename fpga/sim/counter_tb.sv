// -------------------------------------------------------------
// counter_tb.sv  
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for counter module 
// -------------------------------------------------------------
`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module counter_tb;
    // Testbench signals
    logic clk = 0;
    logic reset;
    logic enable;
    logic [3:0] count;
    logic tick;

    counter #(.N(4), .MAX(9)) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .tick(tick)
    );
    always #5 clk = ~clk;

    initial begin
        // Test 1: reset
        reset = 1;
        enable = 0;
        #20;

        // Test 2: release reset, still disabled
        reset = 0;
        #30;

        // Test 3: enable counting
        enable = 1;
        #200;

        // Test 4: disable counting
        enable = 0;
        #30;

        // Test 5: reset re-enabled 
        reset = 1;
        #20;
        $finish;
    end

endmodule