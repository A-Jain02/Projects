`timescale 1ns / 1ps 

module uart_tb () ; 

`include " uart_tx.v"
`include " uart_rx.v"

  reg clk ;
  reg reset_n ;
  reg tx_start ; 
  reg [ DBIT - 1 : 0 ] tx_data ;
  wire [ DBIT - 1 : 0 ] rx_data ;
  wire rx_done_tick;
  wire tx_done_tick;
  wire tx;

  
  



  

  
  
