`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 06:35:04 PM
// Design Name: 
// Module Name: data_path_tb
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


module data_path_tb();
localparam bit = 5 ;
reg clk , load_reg ,shift_reg ,add_reg ,dec_p ;
reg [bit-1:0]I_B , I_Q ;
wire [((2*bit)-1):0]product ;
wire Q0 , zero ;
data_path #(.bit(bit)) uut(
    .clk(clk),
    .load_reg(load_reg),
    .shift_reg(shift_reg),
    .add_reg(add_reg),
    .dec_p(dec_p),
    .I_B(I_B),
    .I_Q(I_Q),
    .product(product),
    .zero(zero),
    .Q0(Q0)
);
localparam T = 20;
always 
begin
    clk = 1'b0 ;
    #(T/2);
    clk = 1'b1;
    #(T/2);
end
initial 
begin
    I_B = 5'b10111;
    I_Q = 5'b10011;
    @(negedge clk);
    load_reg = 1'b1 ;
    add_reg = 1'b0;
    shift_reg = 1'b0 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg = 1'b0 ;
    add_reg = 1'b1 ;
    shift_reg = 1'b0 ;
    dec_p = 1'b0 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b1 ;
    shift_reg = 1'b0 ;
    dec_p = 1'b0 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b1 ;
    shift_reg = 1'b0 ;
    dec_p = 1'b0 ;
    @(negedge clk);
    load_reg= 1'b0 ;
    add_reg = 1'b0 ;
    shift_reg = 1'b1 ;
    dec_p = 1'b1 ;
    @(negedge clk);
    $stop;  
end
endmodule
