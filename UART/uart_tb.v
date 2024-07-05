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


  // Parameters
    parameter CLOCK_FREQ = 100000000;  // 50 MHz system clock
    parameter BAUD_RATE = 9600;     // Desired baud rate

  // Instantiate UART Transmitter
    uart_tx #(.CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
      .tx_done_tick(tx_done_tick)
    );

   // Instantiate UART Receiver
    uart_rx #(.CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(tx),  // Connect transmitter output to receiver input
        .rx_data(rx_data),
      .rx_done_tick(rx_done_tick)
    );

   // Generate clock signal
    always #10 clk = ~clk;  // 100 MHz clock

  
  
  



  

  
  
