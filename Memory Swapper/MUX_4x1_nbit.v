`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2025 06:49:28 PM
// Design Name: 
// Module Name: MUX_4x1_nbit
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


module MUX_4x1_nbit
    #(parameter bit = 4)
    (
        input [bit-1:0]w0,w1,w2,w3,
        input [1:0]s,
        output reg [bit-1:0]f
    );
    always @(*)
    begin
        f = 'bx ;
        case(s)
            2'd0 : f = w0;
            2'd1 : f = w1;
            2'd2 : f = w2;
            2'd3 : f = w3;
            default : f = 'bx;
        endcase
    end
endmodule
