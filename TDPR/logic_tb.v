`timescale 1ns / 1ps 

module True_DPR_tb;

  wire clk, en_a , en_b , we_a , we_b ; 
  reg [ DATA_SIZE - 1 : 0 ] din_a, din_b;
  reg [ ADDR_SIZE - 1 : 0 ] addr_a , addr_b ;
  reg [ DATA_SIZE - 1 : 0 ] dout_a, dout_b ;
  
