`timescale 1ns / 1ps 

module True_DPR_tb;

  //PARAMETERS
  parameter ADDR_SIZE = 8 ;
  parameter DATA_SIZE = 8 ;
  parameter RAM_SIZE = 1 << ADDR_SIZE ;

  //INPUTS
  reg clk, en_a , en_b , we_a , we_b ; 
  reg [ DATA_SIZE - 1 : 0 ] din_a, din_b;
  reg [ ADDR_SIZE - 1 : 0 ] addr_a , addr_b ;

  //OUTPUTS
  wire [ DATA_SIZE - 1 : 0 ] dout_a, dout_b ;

  module True_DPR #(.ADDR_SIZE(ADDR_SIZE), .DATA_SIZE(DATA_SIZE), .RAM_SIZE(RAM_SIZE)) dut (
    .clk (clk),
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

    always #5 clk ~= clk ; // clock generation 

    initial begin 
      clk <= 0, en_a <= 0, en_b <= 0 , we_a <=0, we_b <=0;
      din_a <= 0 , din_b <=0 , addr_a <= 0 , addr_b <= 0;
    end

    #10

    initial begin 
      en_a = 1 , en_b =0;
      #5
      we_a = 1 , addr_a = 8'h01 , din_a = 8'hA1; 
      #10
      we_a = 0 , addr_a = 8'h01 ; 
    end
    
      
      
      
      
      
  
