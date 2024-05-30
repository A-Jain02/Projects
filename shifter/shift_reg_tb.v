`timescale 1ns / 1ps

module var_shift_tb ;
  reg clk ; 
  reg clr ;
  reg dir ;
  reg en ;
  reg [31 : 0] in;
  reg [5 : 0] shift ;
  wire [31 : 0] q;

  var_shift dut(
    .clk(clk) ,
    .clr(clr) ,
    .dir(dir) ,
    .en(en) ,
    .in(in) ,
    .shift(shift) ,
    .q(q)
  );

  always #10 clk ~= clk // 20 ns each period
    
  initial
    begin 

    end
endmodule

