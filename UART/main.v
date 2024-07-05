`timescale 1ns / 1ps 

module UART 
  # (parameter DBIT = 8 ; //data bits 
            SB_TICK = 16; // stop bits 
)
(
  input clk , reset_n ;

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
  input [10:0] TIMER_FINAL_VALUE;

);

  //timer as baug rate generator

  wire tick;
  timer_input #( .BITS(11)) baud_rate_generator (
    .clk(clk),
    .reset_n(reset_n),
    .done(tick)
  );

  //receiver module 

  wire rx_done_tick;
  wire [ DBIT - 1 : 0 ] rx_dout;
  uart_rx #( .DBIT(DBIT), .SB_TICK(SB_TICK)) receiver ( 
    .clk(clk),
    .reset_n(reset_n),
    .rx(rx),
    .s_tick(tick),
    .rx_done_tick(rx_done_tick),
    .rx_dout(rx_dout)
  );

  fifo_generator_0 rx_FIFO( 
    .clk(clk),
    .srst(~reset_n),
    .din(rx_dout),
    .wr_en(rx_done_tick),
    .full(),
    .dout(rx_data),
    .rd_en(rx_uart),
    .empty(rx_empty)
  );


  //transmitter module 
  wire [DBIT - 1 : 0 ]tx_din ;
  wire tx_fifo_empty , tx_done_tick ;
  uart_tx #( .DBIT(DBIT), .SB_TICK(SB_TICK)) transmitter ( 
    .clk(clk),
    .reset_n(reset_n),
    .tx(tx),
    .s_tick(tick),
    .tx_start(~tx_fifo_empty),
    .tx_din(dout),
    tx_done_tick(rd_en)
  );
    
  
  fifo_generator_0 tx_FIFO(
    .clk(clk),
    .srst(~reset_n),
    .din(w_data),
    .wr_en(wr_uart),
    .full(tx_full),
    .dout(tx_din),
    .rd_en(tx_done_tick),
    .empty(tx_fifo_empty)
  );

endmodule
    
  


  
