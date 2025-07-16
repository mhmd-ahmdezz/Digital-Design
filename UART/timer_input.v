`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 03:52:15 PM
// Design Name: 
// Module Name: timer_input
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


module timer_input
#(parameter bit = 4)
(
    input clk , reset_n ,enable ,
    input [bit-1:0]final_value,
    output done    
);
//Storage Elments 
reg [bit-1:0]Q_reg,Q_next ;
always @(posedge clk , negedge reset_n)
begin
    if(!reset_n)
        Q_reg <= 'd0 ;
    else if(enable)
        Q_reg <= Q_next ;
    else 
        Q_reg <= Q_reg ;
end

//Output Logic
assign done = (Q_reg == final_value);

//Next State Logic 
always @(*)
begin
    Q_next = (done) ? 'd0 : Q_reg + 1 ;
end


endmodule
