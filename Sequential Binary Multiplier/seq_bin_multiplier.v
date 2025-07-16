`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2025 10:55:51 AM
// Design Name: 
// Module Name: seq_bin_multiplier
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


module seq_bin_multiplier
#(parameter bit = 5)
(
    input start , clk , reset_n ,
    input [bit-1:0]I_B , I_Q , 
    output ready, 
    output [(2*bit)-1:0]product 
);
wire  Q0 ,zero;
wire load_reg , shift_reg ,add_reg ,dec_p ;
control_unit #(.bit(bit)) cu (
    .clk(clk),
    .start(start),
    .reset_n(reset_n),
    .zero(zero),
    .Q0(Q0),
    .load_reg(load_reg),
    .add_reg(add_reg),
    .shift_reg(shift_reg),
    .dec_p(dec_p),
    .ready(ready)
);
data_path #(.bit(bit)) dp(
    .clk(clk),
    .load_reg(load_reg),
    .add_reg(add_reg),
    .shift_reg(shift_reg),
    .dec_p(dec_p),
    .I_B(I_B),
    .I_Q(I_Q),
    .zero(zero),
    .Q0(Q0),
    .product(product)
);
endmodule
