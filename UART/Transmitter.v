`timescale 1ns / 1ps 

module uart_tx #( parameter DBIT = 8 , SB_TICK = 16)
  (
    input clk , reset_n , tx_start,
    input [ DBIT - 1 : 0 ] tx_din ,
    output tx_done_tick ,
    output tx 
  );


  
