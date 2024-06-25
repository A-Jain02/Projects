`timescale 1ns / 1ps 

module True_DPR_tb;

  reg clk, en_a , en_b , we_a , we_b ; 
  reg [ DATA_SIZE - 1 : 0 ] din_a, din_b;
  reg [ ADDR_SIZE - 1 : 0 ] addr_a , addr_b ;
  wire [ DATA_SIZE - 1 : 0 ] dout_a, dout_b ;

  module True_DPR dut (
    .clk (clk) ,
    .en_a (en_a),
    .en_b (en_b),
    .we_a (we_a),
    .we_b (we_b),
    .din_a (din_a),
    .din_b (din_b),
    .addr_a (addr_a),
    .addr_b (addr_b),
    .dout_a (dout_a),
    .dout_b (dout_b)
  );
  
