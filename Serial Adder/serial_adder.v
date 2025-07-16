`timescale 1ns / 1ps 
module serial_adder
#(parameter bit = 4 )
(
    input clk , ctrl , // //Control Signal for Registers A & B and reset_n for D Flip flop
    input [bit-1:0]I_A , I_B , //Parallel Loads for Registers A and B 
    output [bit-1:0]result 
);
//Storage Elements 
reg [bit-1:0]Q_reg_A , Q_next_A , Q_reg_B , Q_next_B ;
reg Q_next_D , Q_reg_D ,sum , carry_out;
always @(posedge clk , negedge ctrl)
begin
    Q_reg_A <= Q_next_A ;
    Q_reg_B <= Q_next_B ;
    if(!ctrl)
        Q_reg_D <= 1'b0;
    else
        Q_reg_D <= Q_next_D ;
end
//Next state Logic 
always @(*)
begin
    {carry_out , sum} = Q_reg_A[0] + Q_reg_B[0] + Q_reg_D ;
    Q_next_D = carry_out ;
    Q_next_A = ctrl ? { sum , Q_reg_A[bit-1:1]} : I_A ;
    Q_next_B = ctrl ? {1'b0 , Q_reg_B[bit-1:1]} : I_B ;
    
end
//Output Logic
assign result = Q_reg_A   ;
endmodule