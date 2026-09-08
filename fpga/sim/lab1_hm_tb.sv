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

        s = 4'h1; #10;
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b1001111) errors++;

        s = 4'h2; #10;
        if (led[0] !== 1'b0 || led[1] !== 1'b0 || seg !== 7'b0010010) errors++;

        s = 4'h3; #10;
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0000110) errors++;

        s = 4'h4; #10;
        if (led[0] !== 1'b0 || led[1] !== 1'b0 || seg !== 7'b1001100) errors++;

        s = 4'h5; #10;   // led[0]=s0^s1=1, led[1]=s2&s3=0, seg=decoder(5)
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0100100) errors++;

        s = 4'h6; #10;   // led[0]=s0^s1=0, led[1]=s2&s3=1, seg=decoder(6)
        if (led[0] !== 1'b0 || led[1] !== 1'b1 || seg !== 7'b0100000) errors++;

        s = 4'h7; #10;   // led[0]=s0^s1=1, led[1]=s2&s3=1, seg=decoder(7)
        if (led[0] !== 1'b1 || led[1] !== 1'b1 || seg !== 7'b0001111) errors++;

        s = 4'h8; #10;   // led[0]=s0^s1=0, led[1]=s2&s3=0, seg=decoder(8)
        if (led[0] !== 1'b0 || led[1] !== 1'b0 || seg !== 7'b0000000) errors++;

        s = 4'h9; #10;   // led[0]=s0^s1=1, led[1]=s2&s3=0, seg=decoder(9)
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0000100) errors++;

        s = 4'hA; #10;   // led[0]=1, led[1]=0, seg=decoder(A)
        if (led[0] !== 1'b1 || led[1] !== 1'b0 || seg !== 7'b0001000) errors++;

        s = 4'hB; #10;   // led[0]=1, led[1]=1, seg=decoder(B)
        if (led[0] !== 1'b1 || led[1] !== 1'b1 || seg !== 7'b1100000) errors++;

        s = 4'hC; #10;   // led[0]=0, led[1]=1, seg=decoder(C)
        if (led[0] !== 1'b0 || led[1] !== 1'b1 || seg !== 7'b0110001) errors++;

        s = 4'hD; #10;   // led[0]=1, led[1]=1, seg=decoder(D)
        if (led[0] !== 1'b1 || led[1] !== 1'b1 || seg !== 7'b1000010) errors++;

        s = 4'hE; #10;   // led[0]=1, led[1]=1, seg=decoder(E)
        if (led[0] !== 1'b1 || led[1] !== 1'b1 || seg !== 7'b0110000) errors++;

        s = 4'hF; #10;   // led[0]=0, led[1]=1, seg=decoder(F)
        if (led[0] !== 1'b0 || led[1] !== 1'b1 || seg !== 7'b0111000) errors++;

        #1000;   // let led[2] toggle a few times — eyeball in waveform

        if (errors == 0) $display("lab1_hm PASSED");
        else             $display("lab1_hm FAILED: %0d errors", errors);
        $finish;
    end
endmodule