`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 02:02:38 PM
// Design Name: 
// Module Name: uart
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


module uart
#(parameter DBIT = 8 , SB_TICK = 16)
(
    input clk ,reset_n ,
    //Rx 
    input rx , rd_uart ,
    output [DBIT-1:0]r_data ,
    output rx_empty ,
    //Tx 
    input [DBIT-1:0]w_data ,
    input wr_uart ,
    output tx_full , tx ,
    //Baud rate Generator 
    input [10:0]final_value // to store 650 to make  
);

//Baud rate Generator
wire tick ;
timer_input #(.bit(11)) baud_rate_generator(
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .final_value(final_value),
    .done(tick)
);
//Receiver 
wire [DBIT-1:0]rx_dout ;
wire rx_done_tick ;
uart_rx #(.DBIT(DBIT) , .SB_TICK(SB_TICK)) receiver(
    .clk(clk),
    .reset_n(reset_n),
    .rx(rx),
    .s_tick(tick),
    .rx_dout(rx_dout),
    .rx_done_tick(rx_done_tick)
);

fifo_generator_0 rx_fifo (
  .clk(clk),      // input wire clk
  .srst(~reset_n),    // input wire srst
  .din(rx_dout),      // input wire [7 : 0] din
  .wr_en(rx_done_tick),  // input wire wr_en
  .rd_en(rd_uart),  // input wire rd_en
  .dout(r_data),    // output wire [7 : 0] dout
  .full(),    // output wire full
  .empty(rx_empty)  // output wire empty
);

//Transmitter 

wire [DBIT-1:0]tx_din ;
wire tx_done_tick ;
wire tx_fifo_empty ;

uart_tx #(.DBIT(DBIT) , .SB_TICK(SB_TICK)) transmitter(
    .clk(clk),
    .reset_n(reset_n),
    .s_tick(tick),
    .tx_start(~tx_fifo_empty),
    .tx_din(tx_din),
    .tx_done_tick(tx_done_tick),
    .tx(tx)
);

fifo_generator_0 tx_fifo (
  .clk(clk),      // input wire clk
  .srst(~reset_n),    // input wire srst
  .din(w_data),      // input wire [7 : 0] din
  .wr_en(wr_uart),  // input wire wr_en
  .rd_en(tx_done_tick),  // input wire rd_en
  .dout(tx_din),    // output wire [7 : 0] dout
  .full(tx_full),    // output wire full
  .empty(tx_fifo_empty)  // output wire empty
);
endmodule
