module tb_true_dual_port_ram;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;

    // Inputs
    reg clk;
    reg en_a;
    reg en_b;
    reg [ADDR_WIDTH-1:0] addr_a;
    reg [ADDR_WIDTH-1:0] addr_b;
    reg [DATA_WIDTH-1:0] data_in_a;
    reg [DATA_WIDTH-1:0] data_in_b;
    reg we_a;
    reg we_b;

    // Outputs
    wire [DATA_WIDTH-1:0] data_out_a;
    wire [DATA_WIDTH-1:0] data_out_b;

    // Instantiate the RAM module
    true_dual_port_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RAM_DEPTH(RAM_DEPTH)
    ) uut (
        .clk(clk),
        .en_a(en_a),
        .en_b(en_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .data_in_a(data_in_a),
        .data_in_b(data_in_b),
        .we_a(we_a),
        .we_b(we_b),
        .data_out_a(data_out_a),
        .data_out_b(data_out_b)
    );

    // Clock generation
    always begin
        clk = 0;
        #5 clk = 1;
        #5 clk = 0;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        en_a = 0; en_b = 0;
        addr_a = 0; addr_b = 0;
        data_in_a = 0; data_in_b = 0;
        we_a = 0; we_b = 0;

        // Wait for the global reset
        #10;

        // Test Case 1: Write and read from port A
        en_a = 1; en_b = 0;
        addr_a = 8'h01; data_in_a = 8'hAA; we_a = 1; // Write 0xAA to address 0x01
        #10;
        we_a = 0; addr_a = 8'h01; // Read from address 0x01
        #10;

        // Test Case 2: Write and read from port B
        en_a = 0; en_b = 1;
        addr_b = 8'h02; data_in_b = 8'hBB; we_b = 1; // Write 0xBB to address 0x02
        #10;
        we_b = 0; addr_b = 8'h02; // Read from address 0x02
        #10;

        // Test Case 3: Simultaneous writes to different addresses
        en_a = 1; en_b = 1;
        addr_a = 8'h03; data_in_a = 8'hCC; we_a = 1;
        addr_b = 8'h04; data_in_b = 8'hDD; we_b = 1;
        #10;
        we_a = 0; we_b = 0;
        addr_a = 8'h03; addr_b = 8'h04; // Read from addresses 0x03 and 0x04
        #10;

        // Test Case 4: Simultaneous write to the same address
        en_a = 1; en_b = 1;
        addr_a = 8'h05; addr_b = 8'h05;
        data_in_a = 8'hEE; we_a = 1; // Write 0xEE from port A
        data_in_b = 8'hFF; we_b = 1; // Write 0xFF from port B
        #10;
        we_a = 0; we_b = 0;
        addr_a = 8'h05; addr_b = 8'h05; // Read from address 0x05
        #10;

        // Test Case 5: Read-after-write functionality
        en_a = 1; en_b = 1;
        addr_a = 8'h06; addr_b = 8'h06;
        data_in_a = 8'h11; we_a = 1; // Write 0x11 from port A
        #10;
        we_a = 0; we_b = 0;
        addr_a = 8'h06; addr_b = 8'h06; // Read from address 0x06
        #10;

        // Test Case 6: No operation when enable is low, show previous value
        en_a = 0; en_b = 0;
        addr_a = 8'h07; addr_b = 8'h07;
        data_in_a = 8'h22; we_a = 1;
        data_in_b = 8'h33; we_b = 1;
        #10;
    end 
endmodule
