`timescale 1ns / 1ps

module var_shift_tb ;
  parameter N = 32 ;
  reg clk ; 
  reg clr ;
  reg dir ;
  reg en ;
  wire [ N-1 : 0 ] q;

  var_shift dut(
    .clk(clk) ,
    .clr(clr) ,
    .dir(dir) ,
    .en(en) ,
    .q(q)
  );

  initial
    #10 clk ~= clk // 20 ns each period
    
    begin 

    end

endmodule

