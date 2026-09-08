// -------------------------------------------------------------
// seven_segment_decoder_tb.sv  
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for seven_segment_decoder
// -------------------------------------------------------------
`timescale 1ns/1ns
`default_nettype none

module seven_segment_decoder_tb;
    logic [3:0] data;
    logic [6:0] segments;
    int         errors = 0;

    seven_segment_decoder dut (.data(data), .segments(segments));
    
    initial begin
        data = 4'h0; #1; if (segments !== 7'b0000001) errors++;
        data = 4'h1; #1; if (segments !== 7'b1001111) errors++;
        data = 4'h2; #1; if (segments !== 7'b0010010) errors++;
        data = 4'h3; #1; if (segments !== 7'b0000110) errors++;
        data = 4'h4; #1; if (segments !== 7'b1001100) errors++;
        data = 4'h5; #1; if (segments !== 7'b0100100) errors++;
        data = 4'h6; #1; if (segments !== 7'b0100000) errors++;
        data = 4'h7; #1; if (segments !== 7'b0001111) errors++;
        data = 4'h8; #1; if (segments !== 7'b0000000) errors++;
        data = 4'h9; #1; if (segments !== 7'b0000100) errors++;
        data = 4'hA; #1; if (segments !== 7'b0001000) errors++;
        data = 4'hB; #1; if (segments !== 7'b1100000) errors++;
        data = 4'hC; #1; if (segments !== 7'b0110001) errors++;
        data = 4'hD; #1; if (segments !== 7'b1000010) errors++;
        data = 4'hE; #1; if (segments !== 7'b0110000) errors++;
        data = 4'hF; #1; if (segments !== 7'b0111000) errors++;

        if (errors == 0) $display("decoder PASSED");
        else $display("decoder FAILED: %0d errors", errors);
        $finish;
    end
endmodule