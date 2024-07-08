module baud_generator (
    input wire clk,         // System clock
    input wire rst,         // Reset signal
    output wire baud_clk    // Baud rate clock output
);

    parameter CLOCK_FREQ = 50000000;  // 50 MHz system clock
    parameter BAUD_RATE = 115200;     // Desired baud rate

    // Calculate the divisor
    localparam integer DIVISOR = CLOCK_FREQ / (16 * BAUD_RATE);

    reg [15:0] counter = 0;
    reg baud_clk_reg = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            baud_clk_reg <= 0;
        end else if (counter == DIVISOR) begin
            counter <= 0;
            baud_clk_reg <= ~baud_clk_reg;
        end else begin
            counter <= counter + 1;
        end
    end

    assign baud_clk = baud_clk_reg;

endmodule

