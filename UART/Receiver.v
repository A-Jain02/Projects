`timescale 1ns / 1ps


/*uart_rx #( .DBIT(DBIT), .SB_TICK(SB_TICK)) receiver ( 
    .clk(clk),
    .reset_n(reset_n),
    .rx(rx),
    .s_tick(tick),
    .rx_done_tick(rx_done_tick),
    .rx_dout(rx_dout)
  ); */

module uart_rx #( parameter DBIT = 8 , SB_TICK = 16) 
  (
    input clk , reset_n , s_tick, rx ,
    output [ DBIT - 1 : 0 ] rx_dout ,
    output reg rx_done_tick 
  );

  parameter idle = 0 , start = 1 , data = 2 , stop = 3;
  
  reg [ 2 : 0 ] n_reg , n_next;  // counter for DBITS
  reg [ 3 : 0 ] s_reg , s_next;  // counter for s_tick
  reg [ DBIT - 1 : 0 ] r_reg , r_next ;
  reg [ 1 : 0 ] state , state_next ;
