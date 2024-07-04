`timescale 1ns / 1ps 

module UART 
  # (parameter DBIT = 8 ; //data bits 
            SB_TICK = 16; // stop bits 
)
(
  input clk , rst_n ;

  // receiver ports
  output [ DBIT - 1 : 0 ] rx_data; 
  input rx_uart;
  input rx;
  output rx_empty;

  // transmitter port 
  input [ DBIT - 1 : 0 ] w_data ;
  input w_uart; 
  output tx_full;
  output tx;

  // baud clk generator
  input [10:0] FINAL_VALUE
  


  
