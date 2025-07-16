`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2025 10:27:41 AM
// Design Name: 
// Module Name: control_unit
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
// Finite State Machine Controller
//////////////////////////////////////////////////////////////////////////////////


module control_unit
#(parameter bit = 5)
(
    input clk , reset_n ,start ,Q0 , zero , // zero is asserted if P is equal to zero and not asserted otherwise
    output ready ,load_reg , shift_reg , add_reg , dec_p 
);
//Storage Elements 
reg [1:0]state_reg , state_next ;
localparam s_idle =0 , s_add = 1 , s_shift = 2;
always @(posedge clk , negedge reset_n)
begin
    if(!reset_n)
        state_reg <= s_idle ;
    else 
        state_reg <= state_next ;
end
//Next state Logic 
always @(*)
begin
    case(state_reg)
        s_idle : state_next = (start) ? s_add : s_idle;
        s_add  : state_next = s_shift ;
        s_shift: state_next = (zero) ? s_idle : s_add;
        default : state_next = state_reg ;
    endcase
end
//Output Logic 
assign ready = (state_reg == s_idle);
assign load_reg = ((state_reg == s_idle) && (start)) ;
assign dec_p = (state_reg == s_add);
assign add_reg = ((state_reg == s_add) && (Q0));
assign shift_reg = (state_reg == s_shift) ;
endmodule
