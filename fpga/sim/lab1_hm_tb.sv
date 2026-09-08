// -------------------------------------------------------------
// lab01_tb.sv
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for Lab 1 top-level module
// -------------------------------------------------------------
`timescale 1ns/1ns
`default_nettype none

module lab1_hm_tb;
    logic [3:0] s;
    logic [2:0] led;
    logic [6:0] seg;
    int         errors = 0;

    lab1_hm #(.blink_max(4)) dut (.s(s), .led(led), .seg(seg));
    
endmodule