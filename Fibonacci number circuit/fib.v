`timescale 1ns / 1ps 
module fib(
    input clk , reset_n , start ,
    input [4:0]i, // for input iterations need
    output [19:0]f, // Output 
    output reg ready , done_tick
);
//Storage Elements

reg [1:0]state_reg , state_next ;
reg [19:0]t1_reg ,t1_next , t0_reg , t0_next ;
reg [4:0]n_reg , n_next ; 

localparam idle = 2'b00 , op = 2'b01 ,done = 2'b10 ;

always @(posedge clk,negedge reset_n)
begin
    if(!reset_n)
    begin
        state_reg <= idle ;
        t1_reg <= 'd1 ;
        t0_reg <= 'd0 ;
        n_reg <= 'd0 ;
    end
    else 
    begin
        state_reg <= state_next ;
        t1_reg <= t1_next ;
        t0_reg <= t0_next ;
        n_reg <= n_next ;
    end
end
//Next state Logic 
always @(*)
begin
    //Default Values 
    state_next = state_reg;
    t1_next = t1_reg ;
    t0_next = t0_reg ;
    n_next = n_reg ;
    ready = 1'b0 ;
    done_tick = 1'b0 ;
    case(state_reg)
        idle:
        begin
            ready = 1'b1 ;
            if(start == 1)
            begin
                t0_next = 'd0 ;
                t1_next = 'd1 ;
                n_next = i ;
                state_next = op ;
            end
        end
        op:
        begin
            if(n_reg == 0)
            begin
                t1_next = 'd0 ;
                state_next = done ;
            end
            else if(n_reg == 1)
            begin
                state_next = done ;
            end
            else 
            begin
                t1_next = t1_reg + t0_reg ;
                t0_next = t1_reg ;
                n_next = n_reg - 1 ;
                state_next = op ;
            end
        end
        done :
        begin
            done_tick = 1'b1 ;
            state_next = idle ;
        end
        default : state_next = idle ;
    endcase

end
//Output Logic
assign f = t1_reg ;
endmodule