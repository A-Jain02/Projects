
`timescale 1ns / 1ps

module uart_tb();

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_ready;

    // Parameters
    parameter CLOCK_FREQ = 50000000;  // 50 MHz system clock
    parameter BAUD_RATE = 115200;     // Desired baud rate

    // Instantiate UART Transmitter
    uart_tx #(.CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Instantiate UART Receiver
    uart_rx #(.CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(tx),  // Connect transmitter output to receiver input
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // Generate clock signal
    always #10 clk = ~clk;  // 50 MHz clock

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        // Reset
        #100;
        rst = 0;

        // Transmit data
        #100;
        tx_data = 8'hA5;  // Data to transmit
        tx_start = 1;
        #20;
        tx_start = 0;

        // Wait for transmission to complete
        wait(!tx_busy);

        // Wait for receiver to be ready
        wait(rx_ready);

        // Check received data
        if (rx_data == 8'hA5) begin
            $display("Test Passed: Received data matches transmitted data");
        end else begin
            $display("Test Failed: Received data does not match transmitted data");
        end

        // Finish simulation
        #100;
        $finish;
    end

endmodule
