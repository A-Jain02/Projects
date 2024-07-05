`timescale 1ns / 1ps

module timer_input #( parameter BITS = 11 )
  (
    input clk , reset_n , enable,
    output done 
  ) ; 

  reg [BITS - 1 : 0 ] counter ;
  reg baud_clk_reg;

  always @(posedge clk)
  begin 
    if (~reset_n)
      Q_reg <= 0;
    else if (enable) 
      Q_reg <= Q_next ;
    else 
      Q_reg <= Q_reg ;
  end

  assign done = baud_clk_reg



endmodule 
      
  

  
