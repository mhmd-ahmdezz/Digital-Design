`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 06:15:07 PM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb();
localparam bit = 5 ;
reg clk ,reset_n , start , Q0 ,zero ;
wire ready , load_reg ,shift_reg ,add_reg ,dec_p ;
control_unit #(.bit(bit)) uut(
    .clk(clk),
    .reset_n(reset_n),
    .start(start),
    .Q0(Q0),
    .zero(zero),
    .ready(ready),
    .load_reg(load_reg),
    .shift_reg(shift_reg),
    .add_reg(add_reg),
    .dec_p(dec_p)
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
    start = 1'b0 ;
    #2 reset_n = 1'b1 ;
    zero = 1'b0 ;
    start = 1'b1 ;
    Q0 = 1'b1 ;
    @(posedge clk);
    Q0 = 1'b0 ;
    @(posedge clk);
    Q0 = 1'b1 ;
    @(posedge clk);
    zero = 1'b1 ;
    repeat(2) @(negedge clk);
     $stop ;
    
end
endmodule
