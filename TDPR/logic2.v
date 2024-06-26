module true_dual_port_ram (
    input wire clk,                   // Single clock input
    input wire en_a,                  // Enable signal for port A
    input wire en_b,                  // Enable signal for port B
    input wire [ADDR_WIDTH-1:0] addr_a, // Address input for port A
    input wire [ADDR_WIDTH-1:0] addr_b, // Address input for port B
    input wire [DATA_WIDTH-1:0] data_in_a, // Data input for port A
    input wire [DATA_WIDTH-1:0] data_in_b, // Data input for port B
    input wire we_a,                  // Write enable/read enable for port A (1: Write, 0: Read)
    input wire we_b,                  // Write enable/read enable for port B (1: Write, 0: Read)
    output reg [DATA_WIDTH-1:0] data_out_a, // Data output for port A
    output reg [DATA_WIDTH-1:0] data_out_b  // Data output for port B
);
    parameter DATA_WIDTH = 8;          // Width of data bus
    parameter ADDR_WIDTH = 8;          // Width of address bus
    parameter RAM_DEPTH = 1 << ADDR_WIDTH; // Depth of RAM (number of locations)

    // Memory array
    reg [DATA_WIDTH-1:0] ram [0:RAM_DEPTH-1];

    // Previous output registers to hold data when enable is low
    reg [DATA_WIDTH-1:0] prev_data_out_a;
    reg [DATA_WIDTH-1:0] prev_data_out_b;

    // Port A operations
    always @(posedge clk) begin
        if (en_a) begin
            if (we_a && (!we_b || addr_a != addr_b)) begin
                ram[addr_a] <= data_in_a;  // Write operation for port A when no collision or different addresses
            end
            if (!we_a) begin
                if (we_a && addr_a == addr_b) begin
                    data_out_a <= data_in_a; // Read-after-write case for port A
                end else begin
                    data_out_a <= ram[addr_a]; // Normal read operation for port A
                end
            end
            prev_data_out_a <= data_out_a;
        end else begin
            data_out_a <= prev_data_out_a; // Show previous value when enable is low
        end
    end

    // Port B operations
    always @(posedge clk) begin
        if (en_b) begin
            if (we_b && (!we_a || addr_a != addr_b)) begin
                ram[addr_b] <= data_in_b;  // Write operation for port B when no collision or different addresses
            end
            if (!we_b) begin
                if (we_b && addr_a == addr_b) begin
                    data_out_b <= data_in_b; // Read-after-write case for port B
                end else begin
                    data_out_b <= ram[addr_b]; // Normal read operation for port B
                end
            end
            prev_data_out_b <= data_out_b;
        end else begin
            data_out_b <= prev_data_out_b; // Show previous value when enable is low
        end
    end
     // Maintain previous data output when enable is low
    always @(posedge clk) begin
        if (!en_a) begin
            data_out_a <= data_out_a; // Keep previous value when enable is low for port A
        end
        if (!en_b) begin
            data_out_b <= data_out_b; // Keep previous value when enable is low for port B
        end
    end

    // Collision handling logic for simultaneous writes to the same address
    always @(posedge clk) begin
        if (en_a && en_b && we_a && we_b && addr_a == addr_b) begin
            // Conflict resolution policy: prioritize port A
            ram[addr_a] <= data_in_a; // Alternatively, implement other policies if needed
        end
    end
endmodule
