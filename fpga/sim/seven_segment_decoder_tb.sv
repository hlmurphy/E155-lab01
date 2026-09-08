// -------------------------------------------------------------
// seven_segment_decoder_tb.sv  
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for seven_segment_decoder
// -------------------------------------------------------------
`timescale 1ns/1ns
`default_nettype none
`define N_TV 16

module seven_segment_decoder_tb;

    // Testbench signals
    logic clk = 0;
    logic reset;
    logic [3:0] data;
    logic [6:0] segments, segments_expected;
    logic [31:0] vectornum, errors;
    logic [10:0] testvectors[10000:0]; //format data[3:0]_expected_segments[6:0]


    // Instantiate the seven_segment_decoder
    seven_segment_decoder dut (
        .data(data),
        .segments(segments)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $readmemb("decoder_testvectors.tv", testvectors, 0, `N_TV-1); 
        vectornum = 0;
        errors = 0;
        reset = 1;
        #20;
        reset = 0;
    end

    always @(posedge clk) begin
        #1;
        {data, segments_expected} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin   // skip during reset window
            if (segments !== segments_expected) begin
                $display("Error: data=%h", data);
                $display("  segments=%b (%b expected)", segments, segments_expected);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 11'bx) begin
                $display("%d tests completed with %d errors.", vectornum, errors);
                $finish;
            end
        end
    end

endmodule

