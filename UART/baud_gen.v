`timescale 1ns / 1ps

module timer_input #( parameter BITS = 11 )
  (
    input clk , reset_n , enable ,
    input [BITS - 1 : 0 ] FINAL_VALUE,
    output done 
  ) ; 

  reg [BITS -1 : 0 ] Q_reg , Q_next;

  always @(posedge clk)
  begin 
    if (~reset_n)
      Q_reg <= 0;
    else if (enable) 
      Q_next <= Q_reg ;
    else 
      Q_reg <= Q_reg ;
  end

  assign done = Q_reg == FINAL_VALUE

    always @*
      Q_next = done ? 'b0 : Q_reg + 1;

endmodule 
      
  

  
