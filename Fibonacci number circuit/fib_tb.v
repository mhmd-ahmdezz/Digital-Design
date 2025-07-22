`timescale 1ns / 1ps 
module fib_tb();
//declare the local , reg , and wire identifiers
reg clk ,reset_n ,start ;
reg [4:0]i;
wire [19:0]f;
wire ready , done_tick ;
//Instantiate the module under test
fib uut(
    .clk(clk),
    .reset_n(reset_n),
    .start(start),
    .i(i),
    .f(f),
    .ready(ready),
    .done_tick(done_tick)
); 
//Generate the clock 
localparam T = 10 ;
always 
begin
    clk = 1'b0 ;
    #(T/2);
    clk = 1'b1 ;
    #(T/2);
end
//create the waveforms file 
initial 
begin
    $dumpfile("fib_tb.vcd");
    $dumpvars(0,fib_tb);
end
//Create the stimulus using initial and always keyword
initial 
begin
    reset_n = 1'b0 ;
    #2 reset_n = 1'b1 ;
    i = 'd9 ;
    start = 1'b1 ;
    wait(done_tick);
    i = 'd4;
    repeat(2) @(posedge clk);
    wait(done_tick) ;
    #T $finish;
end
endmodule