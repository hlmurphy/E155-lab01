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

    initial begin
        #100;   // let HSOSC power up

        s = 4'h0; #10;
        if (led[0] !== 1'b0 || led[1] !== 1'b0 || seg !== 7'b0000001) errors++;

        s = 4'h5; #10;   // led[0]=s0^s1=1, led[1]=s2&s3=0, seg=decoder(5)
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0100100) errors++;

        s = 4'hA; #10;   // led[0]=1, led[1]=0, seg=decoder(A)
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0001000) errors++;

        s = 4'hC; #10;   // led[0]=0, led[1]=1, seg=decoder(C)
        if (led[0] !== 1'b0 || led[1] !== 1'b1 || seg !== 7'b0110001) errors++;

        s = 4'hF; #10;   // led[0]=0, led[1]=1, seg=decoder(F)
        if (led[0] !== 1'b0 || led[1] !== 1'b1 || seg !== 7'b0111000) errors++;

        #500;   // let led[2] toggle a few times — eyeball in waveform

        if (errors == 0) $display("lab1_hm PASSED");
        else             $display("lab1_hm FAILED: %0d errors", errors);
        $finish;
    end
endmodule