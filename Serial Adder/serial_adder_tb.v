`timescale 1ns / 1ps
module serial_adder_tb();
//declare the local reg and wire identifiers 
localparam  bit = 4 ;
reg clk ,ctrl ;
reg [bit-1:0] I_A , I_B ;
wire [bit-1:0]result;
//Create the dumpfile and dumpvars to generate the waves 
initial
begin
    $dumpfile("serial_adder_tb.vcd");
    $dumpvars(0,serial_adder_tb);
end
//instantiate the unit under test
serial_adder #(.bit(bit)) uut
(
    .clk(clk),
    .I_A(I_A),
    .I_B(I_B),
    .ctrl(ctrl),
    .result(result)
);
//Generate the clock 
localparam T = 20 ;
always 
begin
    clk = 1'b0 ;
    #(T/2);
    clk = 1'b1 ;
    #(T/2); 
end
// create the stimlu to simulate the uut 
initial 
begin
    I_A = 'd4 ;
    I_B = 'd6 ;
    ctrl = 1'b0 ;
    @(posedge clk) ctrl = 1'b1 ;
    repeat(bit) @(posedge clk);
    ctrl = 1'b0 ;
    I_A = 'd14 ;
    I_B = 'd7 ;
    @(posedge clk) ctrl = 1'b1 ;
    ctrl = 1'b1 ;
    repeat(bit+1) @(posedge clk) ;
    ctrl = 1'b0 ;
    I_A = 'd9 ;
    I_B = 'd6 ;
    @(posedge clk) ctrl = 1'b1 ;
    ctrl = 1'b1 ;
    repeat(bit+1) @(posedge clk) ;
    $finish ;
end
endmodule