`timescale 1ns / 1ps

module var_shift_tb ;
  reg clk ; 
  reg clr ;
  reg dir ;  
  reg [ N-1 : 0 ] q;

  var_shift dut(
    .clk(clk) ,
    .clr(clr) ,
    .dir(dir) ,
    .q(q)
  );

  initial 
    begin 

    end

endmodule

