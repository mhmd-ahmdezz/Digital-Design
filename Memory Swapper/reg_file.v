`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2025 06:53:01 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file
    #(parameter ADDR_WIDTH = 7 , DATA_WIDTH = 8)
    (
        input clk , we ,
        input [ADDR_WIDTH-1:0]address_w , address_r ,
        input [DATA_WIDTH-1:0]data_w , 
        output [DATA_WIDTH-1:0]data_r
    );
    reg [DATA_WIDTH-1:0] memory[0:(2**ADDR_WIDTH)-1] ;
    always @(posedge clk)
    begin
        if(we)
            memory[address_w] <= data_w ;
    end
    assign data_r = memory[address_r] ;
endmodule
