module uart_tx (
    input wire clk,             // System clock
    input wire rst,             // Reset signal
    input wire tx_start,        // Start transmission signal
    input wire [7:0] tx_data,   // Data to be transmitted
    output wire tx,             // UART transmit line
    output wire tx_busy         // Transmitter busy signal
);

    parameter CLOCK_FREQ = 50000000;  // 50 MHz system clock
    parameter BAUD_RATE = 115200;     // Desired baud rate

    reg [3:0] bit_cnt = 0;
    reg [9:0] shift_reg = 10'b1111111111;
    reg tx_busy_reg = 0;
    reg tx_reg = 1;

    wire baud_clk;
    baud_generator #(.CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) baud_gen (
        .clk(clk),
        .rst(rst),
        .baud_clk(baud_clk)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_cnt <= 0;
            shift_reg <= 10'b1111111111;
            tx_busy_reg <= 0;
            tx_reg <= 1;
        end else if (tx_start && !tx_busy_reg) begin
            shift_reg <= {1'b1, tx_data, 1'b0};  // Start bit (0), data bits, stop bit (1)
            bit_cnt <= 0;
            tx_busy_reg <= 1;
        end else if (tx_busy_reg && baud_clk) begin
            if (bit_cnt == 10) begin
                tx_busy_reg <= 0;
            end else begin
                shift_reg <= {1'b1, shift_reg[9:1]};
                bit_cnt <= bit_cnt + 1;
            end
        end
    end

    assign tx = shift_reg[0];
    assign tx_busy = tx_busy_reg;

endmodule



// initial begin
    $monitor($time, "   The Outputs:  Data Out = %h  Error Flag = %b  Tx Active Flag = %b  Tx Done Flag = %b  Rx Active Flag = %b  Rx Done Flag = %b  The Inputs:   Reset = %b  Send = %b  Data In = %h  Parity Type = %b  Baud Rate = %b ",
    data_out_tb[7:0], error_flag_tb[2:0], tx_active_flag_tb, tx_done_flag_tb, rx_active_flag_tb, rx_done_flag_tb, reset_n_tb, send_tb,
    data_in_tb[7:0], parity_type_tb[1:0], baud_rate_tb[1:0]);
end

