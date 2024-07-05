`timescale 1ns / 1ps

module timer_input #( parameter BITS = 10 )
  (
    input clk , reset_n ,
    output done 
  ) ; 

  parameter CLOCK_FREQ = 100_000_000;  // 100 MHz system clock
  parameter BAUD_RATE = 9_600;     // Desired baud rate

    // Calculate the divisor
  localparam integer DIVISOR = CLOCK_FREQ / (16 * BAUD_RATE);  // approx value = 651

  reg [BITS - 1 : 0 ] counter ;
  reg baud_clk_reg;

  always @(posedge clk)
  begin 
    if (~reset_n) begin
      counter <= 0;
      baud_clk_reg <= 0;
    end
    else if (counter == DIVISOR ) begin
      counter <= 0;
      baud_clk_reg = ~baud_clk_reg ;
    end
    else 
      counter <= counter + 1;
  end

  assign done = baud_clk_reg;

endmodule 
      
  

  
