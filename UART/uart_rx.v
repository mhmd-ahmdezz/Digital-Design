`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 10:37:59 AM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
#(parameter DBIT = 8 , SB_TICK = 16)
(
    input clk ,reset_n ,rx ,s_tick ,
    output [DBIT-1:0]rx_dout ,
    output reg rx_done_tick
);
//Storage Elements

//States 
reg [1:0] state_reg , state_next ;
localparam idle = 0 , start = 1  , data = 2 ,stop = 3 ;

//Registers 
reg [3:0] s_reg , s_next ; //Keep track of the baud rate ticks (16 Total)
reg [DBIT-1:0] b_reg , b_next ; // Stores the data bits 
reg [($clog2(DBIT)-1) :0]n_reg ,n_next; //Keep track of the number of bits received
 
 always @(posedge clk , negedge reset_n)
 begin
    if(!reset_n)
    begin
        state_reg <= idle ;
        s_reg <= 0;
        n_reg <= 0;
        b_reg <= 0;
    end
    else 
    begin
        state_reg <= state_next ;
        s_reg <= s_next ;
        n_reg <= n_next ;
        b_reg <= b_next ; 
    end
 end
 
//Next State Logic

always @(*)
begin
    state_next = state_reg ;
    s_next = s_reg ;
    n_next = n_reg ;
    b_next = b_reg ;
    rx_done_tick = 1'b0 ;
    case(state_reg)
    idle : 
        begin
            if(!rx)
            begin
                s_next = 0 ;
                state_next = start;
            end
            else 
                state_next = idle ;
        end
    start:
        begin
            if(s_tick)
            begin
                if(s_reg == 7)
                begin
                    s_next = 0 ;
                    n_next = 0 ;
                    state_next = data ;
                end
                else 
                begin    
                    s_next = s_reg + 1;
                    state_next = start ;
                end    
            end
            else 
                state_next = start ;    
        end
    data : 
        begin
            if(s_tick)
            begin
                if(s_reg == 15)
                begin
                    s_next = 0 ;
                    b_next = {rx , b_reg[DBIT-1:1]}; //Shifting Right
                    if(n_reg == (DBIT-1))
                        state_next = stop ;
                    else
                    begin 
                        n_next = n_reg + 1 ;
                        state_next = data ;
                    end
                end
            end
            else
                state_next = data ;
        end
    stop : 
    begin
        if(s_tick)
        begin
            if(s_reg == (SB_TICK-1))
            begin
                rx_done_tick = 1'b1 ;
                state_next = idle ;
            end
            else 
                s_next = s_reg + 1 ;
                state_next = stop ;
        end
        else 
            state_next = stop ;
    end
    default : state_next = idle;
    endcase 
end

//Output Logic

assign rx_dout = b_reg ;

endmodule
