`timescale 1ns / 1ns 
module clk_divider_by_n_dual_edge_ff_tb();
//declare the local , reg , and wire identifier
localparam n = 8 ;
reg clk , rst_n ;
wire out_clk ;
//Instantiate the module under test
clk_divider_by_n_dual_edge_ff #(.n(n)) uut(clk ,rst_n , out_clk);
//Counter 
integer count_high_out_clk = 0 , count_low_out_clk = 0 ;
integer count_high_clk = 0 , count_low_clk = 0 ;
//Generate the clock 
localparam T = 10 ;
always 
begin
    clk = 1'b0 ;
    #(T/2) ;
    clk = 1'b1 ;
    #(T/2) ;
end
//Initial Block to Kill the hanging 
initial 
    #100000 $finish ;
//Tasks : 
// task check;
//     integer i ;
//     begin
//         for(i=0;;i=i+1)
//     end
// endtask
//Create the stimuli using initial 
initial 
begin
    rst_n = 1'b0 ;
    #2 rst_n = 1'b1 ;
    repeat(3*n)
    begin
        @(posedge clk)
        begin
            if(clk)
                count_high_clk = count_high_clk + 1 ;
            else 
                count_low_clk = count_low_clk + 1 ;
            if(out_clk)
                count_high_out_clk = count_high_out_clk + 1 ;
            else 
                count_low_out_clk = count_low_out_clk + 1 ;
        end
        @(negedge clk)
        begin
            if(clk)
                count_high_clk = count_high_clk + 1 ;
            else 
                count_low_clk = count_low_clk + 1 ;
            if(out_clk)
                count_high_out_clk = count_high_out_clk + 1 ;
            else 
                count_low_out_clk = count_low_out_clk + 1 ;
        end
    end
    if(count_high_out_clk == count_low_out_clk)
        $display("Count_high_out_clk %d is equal to cout_low_out_clk %d " , count_high_out_clk , count_low_out_clk) ;
    else 
        $display("Count_high_out_clk %d is not equal to cout_low_out_clk %d " ,count_high_out_clk , count_low_out_clk) ;
    if(count_high_clk == count_low_clk)
        $display("Count_high_clk %d is equal to cout_low_clk %d " , count_high_clk , count_low_clk) ;
    else 
        $display("Count_high_clk %d is not equal to cout_low_clk %d " ,count_high_clk , count_low_clk) ;
    #2 $finish ;
end
initial 
begin
    $dumpfile("clk_divider_by_n_dual_edge_ff_tb.vcd");
    $dumpvars(0,clk_divider_by_n_dual_edge_ff_tb);
end
endmodule