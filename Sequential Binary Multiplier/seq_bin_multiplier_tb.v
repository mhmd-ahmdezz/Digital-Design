`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2025 11:02:27 AM
// Design Name: 
// Module Name: seq_bin_multiplier_tb
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


module seq_bin_multiplier_tb();
localparam bit = 7 ;
reg start,clk ,reset_n  ;
reg [bit-1:0]I_B , I_Q  ;
wire ready ;
wire[(2*bit)-1:0]product;
seq_bin_multiplier #(.bit(bit)) uut(
    .start(start),
    .clk(clk),
    .reset_n(reset_n),
    .I_B(I_B),
    .I_Q(I_Q),
    .ready(ready),
    .product(product)
);
localparam T = 20 ;
always 
begin
    clk = 1'b0 ;
    #(T/2);
    clk = 1'b1 ;
    #(T/2);
end
initial 
begin
    reset_n = 1'b0 ;
    I_B = 7'd100 ;
    I_Q = 7'd100 ;
    #2 reset_n = 1'b1 ;
    start = 1'b1 ;
    repeat((2*bit)+2) @(posedge clk);
    wait(ready == 1'b1);
    reset_n = 1'b0 ;
    #2 reset_n = 1'b1 ;
    I_B = 7'd81 ;
    I_Q = 7'd9  ;
    repeat((2*bit)+2) @(posedge clk);
    $stop ;
end
endmodule
