module uart_rx (
    input wire clk,             // System clock
    input wire rst,             // Reset signal
    input wire rx,              // UART receive line
    output reg [7:0] rx_data,   // Received data
    output reg rx_ready         // Data ready signal
);

    parameter CLOCK_FREQ = 50000000;  // 50 MHz system clock
    parameter BAUD_RATE = 115200;     // Desired baud rate

    reg [3:0] bit_cnt = 0;
    reg [9:0] shift_reg = 10'b1111111111;
    reg rx_busy = 0;
    reg [15:0] baud_counter = 0;

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
            rx_busy <= 0;
            rx_ready <= 0;
            baud_counter <= 0;
        end else begin
            if (!rx_busy && !rx) begin  // Start bit detected
                rx_busy <= 1;
                baud_counter <= 0;
            end

            if (rx_busy && baud_clk) begin
                baud_counter <= baud_counter + 1;
                if (baud_counter == 8) begin  // Sample in the middle of the bit period
                    shift_reg <= {rx, shift_reg[9:1]};
                    bit_cnt <= bit_cnt + 1;
                    baud_counter <= 0;
                end

                if (bit_cnt == 10) begin
                    rx_busy <= 0;
                    bit_cnt <= 0;
                    if (shift_reg[0] == 1 && shift_reg[9] == 1) begin  // Valid start and stop bits
                        rx_data <= shift_reg[8:1];  // Data bits
                        rx_ready <= 1;
                    end
                end
            end

            if (rx_ready) begin
                rx_ready <= 0;
            end
        end
    end

endmodule
