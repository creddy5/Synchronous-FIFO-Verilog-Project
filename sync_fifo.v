`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2025 21:50:34
// Design Name: 
// Module Name: sync_fifo
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


module sync_fifo #(
    parameter DATA_WIDTH=4,
    parameter FIFO_DEPTH=8,
    parameter ADDR_WIDTH=3
    )(
     input  wire                   CLK,       // Clock
    input  wire                   RST,       // Asynchronous Reset
    input  wire                   W_EN,      // Write Enable
    input  wire                   R_EN,      // Read Enable
    input  wire [DATA_WIDTH-1:0]  DATA_IN,   // Data Input
    output reg  [DATA_WIDTH-1:0]  DATA_OUT,  // Data Output
    output wire                   FULL,      // FIFO Full Flag
    output wire                   EMPTY      // FIFO Empty Flag
);

    reg [DATA_WIDTH-1:0] MEM [0:FIFO_DEPTH-1];
    reg [ADDR_WIDTH:0] W_PTR;
    reg [ADDR_WIDTH:0] R_PTR;

    // Write Operation
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            W_PTR <= 0;
        end else if (W_EN && !FULL) begin
            MEM[W_PTR[ADDR_WIDTH-1:0]] <= DATA_IN;
            W_PTR <= W_PTR + 1;
        end
    end

    // Read Operation
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            R_PTR <= 0;
            DATA_OUT <= 0;
        end else if (R_EN && !EMPTY) begin
            DATA_OUT <= MEM[R_PTR[ADDR_WIDTH-1:0]];
            R_PTR <= R_PTR + 1;
        end
    end

    // Status Flag Logic
    // FIFO is empty when both pointers are equal
    assign EMPTY = (W_PTR == R_PTR);

    // FIFO is full when MSBs differ and lower bits are equal
    assign FULL = (W_PTR[ADDR_WIDTH] != R_PTR[ADDR_WIDTH]) &&
                  (W_PTR[ADDR_WIDTH-1:0] == R_PTR[ADDR_WIDTH-1:0]);

endmodule
