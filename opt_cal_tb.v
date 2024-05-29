`timescale 1ns / 1ps

module calculator_tst ; 
  reg [3:0] a ;
  reg [3:0] b ;  
  reg [2:0] oper ; 

  wire [7:0] out; 

  calculator uut ( 
    .a(a) ,
    .b(b) ,
    .oper(oper) ,
    .out(out) ,
  );

  
  
