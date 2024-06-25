`timescale 1ns/1ps



module True_DPR ( clk , en_a , en_b , we_a, we_b , din_a , din_b, dout_a, dout_b, addr_a, addr_b );

  #parameter ADDR_SIZE = 8 ;
  #parameter RAM_WIDTH = 8 ;
  #parameter RAM_SIZE = 1 << ADDR_WIDTH ;
  
  
