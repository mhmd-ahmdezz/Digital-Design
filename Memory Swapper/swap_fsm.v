`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2025 06:59:18 PM
// Design Name: 
// Module Name: swap_fsm
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


module swap_fsm
    (
        input clk , reset_n , swap ,
        output [1:0]sel ,
        output w
    );
    reg [1:0] state_reg , state_next ;
    parameter s0 = 0 , s1 = 1 , s2 = 2 , s3 = 3  ;
    always @(posedge clk , negedge reset_n)
    begin
        if(!reset_n)
            state_reg <= s0 ;
        else 
            state_reg <= state_next ;
    end 
    always @(*)
    begin
        case(state_reg)
            s0 : state_next = (swap) ? s1 : s0 ;
            s1 : state_next = s2 ;
            s2 : state_next = s3 ;
            s3 : state_next = s0 ;
            default : state_next = s0 ;
         endcase 
    end
    
    assign sel = state_reg ;
    assign w = (state_reg != s0) ;
endmodule
