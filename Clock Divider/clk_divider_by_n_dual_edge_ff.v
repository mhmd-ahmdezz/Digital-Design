
module clk_divider_by_n_dual_edge_ff 
#(parameter n = 3)
(
	input clk , rst_n ,
  output reg out_clk 
);
//Counter to count the half cylces of input clock
reg [$clog2(n):0] counter ;

always @(negedge rst_n)
begin
    out_clk <= 1'b0 ;
    counter <=  'd0 ;
end

always @(posedge clk)
begin
    //Default Values 
    out_clk <= 1'b0 ;
    counter <= 'd0 ;
    if(counter < n)
    begin
    out_clk <= 1'b1 ;
    counter <= counter + 1 ; 
    end
    else if(counter == n)
    begin
    out_clk <= 1'b0 ;
    counter <= counter + 1 ;
    end
    else if(counter < 2*n) 
    begin
    out_clk <= 1'b0 ;
    counter <= counter + 1 ;
    end
    else if(counter == 2*n)
    begin
    out_clk <= 1'b1 ;
    counter <= 'd1; 
    end
end
always @(negedge clk)
begin
    //Default Values 
    out_clk <= 1'b0 ;
    counter <= 'd0 ;
    if(counter < n)
    begin
    out_clk <= 1'b1 ;
    counter <= counter + 1 ; 
    end
    else if(counter == n)
    begin
    out_clk <= 1'b0 ;
    counter <= counter + 1 ;
    end
    else if(counter < 2*n) 
    begin
    out_clk <= 1'b0 ;
    counter <= counter + 1 ;
    end
    else if(counter == 2*n)
    begin
    out_clk <= 1'b1 ;
    counter <= 'd1; 
    end
end
// always @(posedge clk , negedge clk , negedge rst_n)
//   begin
//     //Default Values 
//     out_clk <= 1'b0 ;
//     counter <= 'd0 ;
//     if(!rst_n)
//     begin
//       out_clk <= 1'b0 ;
//       counter <=  'd0 ;
//     end
//     else 
//     begin
//       if(counter < n)
//       begin
//         out_clk <= 1'b1 ;
//         counter <= counter + 1 ; 
//       end
//       else if(counter == n)
//       begin
//         out_clk <= 1'b0 ;
//         counter <= counter + 1 ;
//       end
//       else if(counter < 2*n) 
//       begin
//         out_clk <= 1'b0 ;
//         counter <= counter + 1 ;
//       end
//       else if(counter == 2*n)
//       begin
//         out_clk <= 1'b1 ;
//         counter <= 'd1; 
//       end
//     end
//   end
endmodule