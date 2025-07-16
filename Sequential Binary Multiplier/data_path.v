`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2025 09:59:10 AM
// Design Name: 
// Module Name: data_path
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


module data_path
#(parameter bit = 5)
(
    input clk , load_reg , add_reg ,shift_reg ,dec_p ,
    input [bit-1:0]I_B , I_Q ,
    output [((2*bit)-1):0]product ,
    output Q0 , zero 
);
//Storage ELements 
reg [bit-1:0] A_reg , A_next , B_reg , B_next , Q_reg ,Q_next ;
reg C_reg , C_next ;
reg [($clog2(bit)-1):0]p_reg , p_next ;
always @(posedge clk)
begin
        A_reg <= A_next ;
        B_reg <= B_next ;
        C_reg <= C_next ;
        Q_reg <= Q_next ;
        p_reg <= p_next ;          
end
//Next State Logic 
always @(*)
begin
    C_next = C_reg ;
    A_next = A_reg ;
    B_next = B_reg ;
    Q_next = Q_reg ;
    p_next = p_reg ;
    if(load_reg)
    begin
        C_next = 1'b0 ;
        A_next = 5'd0 ;
        B_next = I_B  ;
        Q_next = I_Q  ;
        p_next = bit  ;
    end
    if(add_reg)
    begin
        {C_next , A_next } = A_reg + B_reg ;
    end
    if(shift_reg)
    begin
        C_next = 1'b0 ;
        A_next = {C_reg , A_reg[bit-1:1]};
        Q_next = {A_reg[0] , Q_reg[bit-1:1]};
    end
    if(dec_p)
        p_next = (p_reg == 0) ? p_reg : (p_reg-1) ;
end
//Output Logic 
assign Q0 = Q_reg[0];
assign zero = (p_reg == 'd0) ;
assign product = {C_reg , A_reg , Q_reg};
endmodule
