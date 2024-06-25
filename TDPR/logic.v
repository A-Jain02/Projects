`timescale 1ns/1ps



module True_DPR ( clk , en_a , en_b , we_a, we_b , din_a , din_b, dout_a, dout_b, addr_a, addr_b );

  #parameter ADDR_SIZE = 8 ;
  #parameter DATA_SIZE = 8 ;
  #parameter RAM_SIZE = 1 << ADDR_WIDTH ;

  input clk, en_a , en_b , we_a , we_b ; 
  input [ DATA_SIZE - 1 : 0 ] din_a, din_b;
  input [ ADDR_SIZE - 1 : 0 ] addr_a , addr_b ;
  output reg [ DATA_SIZE - 1 : 0 ] dout_a, dout_b ;
  
  
