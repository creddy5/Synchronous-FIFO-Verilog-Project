`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2025 22:38:59
// Design Name: 
// Module Name: sync_fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_fifo_tb(

    );
     // ===========================================================
    // Parameters
    // ===========================================================
    parameter DATA_WIDTH = 4;
    parameter FIFO_DEPTH = 8;
    parameter ADDR_WIDTH = 3; // log2(8) = 3

    // ===========================================================
    // Testbench Signals
    // ===========================================================
    reg CLK;
    reg RST;
    reg W_EN;
    reg R_EN;
    reg [DATA_WIDTH-1:0] DATA_IN;
    wire [DATA_WIDTH-1:0] DATA_OUT;
    wire FULL;
    wire EMPTY;

    // ===========================================================
    // Instantiate DUT (Device Under Test)
    // ===========================================================
    sync_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .CLK(CLK),
        .RST(RST),
        .W_EN(W_EN),
        .R_EN(R_EN),
        .DATA_IN(DATA_IN),
        .DATA_OUT(DATA_OUT),
        .FULL(FULL),
        .EMPTY(EMPTY)
    );

    // ===========================================================
    // Clock Generation (10ns period)
    // ===========================================================
    always #5 CLK = ~CLK;

    // ===========================================================
    // Stimulus Block
    // ===========================================================
    initial begin
        // Initialize signals
        CLK = 0;
        RST = 1;
        W_EN = 0;
        R_EN = 0;
        DATA_IN = 0;

        // Create waveform dump (for GTKWave or Vivado)
        $dumpfile("sync_fifo_tb.vcd");
        $dumpvars(0, sync_fifo_tb);

        // Apply reset
        #10;
        RST = 0;
        $display("==== FIFO TEST START ====");

        // -----------------------------
        // Write 8 values to FIFO
        // -----------------------------
        $display("Writing phase...");
        repeat (8) begin
            @(posedge CLK);
            if (!FULL) begin
                W_EN = 1;
                DATA_IN = DATA_IN + 1;
                $display("Time %0t: Writing %0d (FULL=%b, EMPTY=%b)", $time, DATA_IN, FULL, EMPTY);
            end else begin
                $display("Time %0t: FIFO FULL, cannot write", $time);
            end
        end
        @(posedge CLK);
        W_EN = 0;

        // Wait a bit
        #10;
        $display("After write phase: FULL=%b, EMPTY=%b at %0t", FULL, EMPTY, $time);

        // -----------------------------
        // Read all 8 values from FIFO
        // -----------------------------
        $display("Reading phase...");
        repeat (8) begin
            @(posedge CLK);
            if (!EMPTY) begin
                R_EN = 1;
                $display("Time %0t: Reading %0d (FULL=%b, EMPTY=%b)", $time, DATA_OUT, FULL, EMPTY);
            end else begin
                $display("Time %0t: FIFO EMPTY, cannot read", $time);
            end
        end
        @(posedge CLK);
        R_EN = 0;

        // -----------------------------
        // Check empty condition
        // -----------------------------
        #10;
        $display("After read phase: FULL=%b, EMPTY=%b at %0t", FULL, EMPTY, $time);

        $display("==== FIFO TEST COMPLETE ====");
        $stop;
    end
    
    
endmodule
