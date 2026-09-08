// -------------------------------------------------------------
// counter_tb.sv  
// Author: Haspard Murphy <hmurphy@g.hmc.edu>
// Date:   2026-09-07
// Course: HMC E155, Lab 1
// Purpose: Testbench for counter module 
// -------------------------------------------------------------

module counter_tb;
    logic       clk = 0;
    logic       reset, enable;
    logic [3:0] count;
    logic       tick;
    int         errors = 0;

    counter #(.N(4), .MAX(9)) dut (
        .clk(clk), .reset(reset), .enable(enable),
        .count(count), .tick(tick)
    );

    always begin
     clk = 1; #5;
     clk = 0; #5;
     end

    initial begin 
        // reset clears count
        reset = 1; 
        enable = 0;
        #10
        assert (count === 4'd0) 
            $display("PASSED! At time: %0t.", $time);
            else $error("FAILED! At time: %0t.", $time) errors++;

        // disabled — count holds
        reset = 0;
        @(posedge clk); @(posedge clk); 
        #1;
        if (count !== 4'd0) errors++;

        // enable — count increments
        enable = 1;
        @(posedge clk); 
        #1; 
        if (count !== 4'd1) errors++;
        @(posedge clk); 
        #1; 
        if (count !== 4'd2) errors++;

        // advance to MAX — tick asserts
        repeat (7) @(posedge clk); 
        #1;
        if (count !== 4'd9 || tick !== 1'b1) errors++;

        // wrap — count clears, tick drops
        @(posedge clk); 
        #1;
        if (count !== 4'd0 || tick !== 1'b0) errors++;

        if (errors == 0) $display("counter PASSED");
        else $display("counter FAILED: %0d errors", errors);
        $finish;
    end
endmodule