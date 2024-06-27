module tb_top_level;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

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

    // Instantiate the top-level module
    top_level uut (
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
        en_a <= 0;
        en_b <= 0;
        addr_a <= 0;
        addr_b <= 0;
        data_in_a <= 0;
        data_in_b <= 0;
        we_a <= 0;
        we_b <= 0;

        // Wait for the global reset
        #10;

        // Test Case 1: Write and read from port A
        en_a <= 1; en_b <= 0;
        addr_a <= 8'h01; data_in_a <= 8'hAA; we_a <= 1; // Write 0xAA to address 0x01
        #10;
        we_a <= 0; addr_a <= 8'h01; // Read from address 0x01
        #10;

        // Test Case 2: Write and read from port B
        en_a <= 0; en_b <= 1;
        addr_b <= 8'h02; data_in_b <= 8'hBB; we_b <= 1; // Write 0xBB to address 0x02
        #10;
        we_b <= 0; addr_b <= 8'h02; // Read from address 0x02
        #10;

        // Test Case 3: Simultaneous write to different addresses
        en_a <= 1; en_b <= 1;
        addr_a <= 8'h03; data_in_a <= 8'hCC; we_a <= 1; // Write 0xCC to address 0x03
        addr_b <= 8'h04; data_in_b <= 8'hDD; we_b <= 1; // Write 0xDD to address 0x04
        #10;
        we_a <= 0; addr_a <= 8'h03; // Read from address 0x03
        we_b <= 0; addr_b <= 8'h04; // Read from address 0x04
        #10;

        // Test Case 4: Simultaneous read from different addresses
        en_a <= 1; en_b <= 1;
        we_a <= 0; addr_a <= 8'h01; // Read from address 0x01
        we_b <= 0; addr_b <= 8'h02; // Read from address 0x02
        #10;

        // Test Case 5: Simultaneous write to the same address
        en_a <= 1; en_b <= 1;
        addr_a <= 8'h05; data_in_a <= 8'hEE; we_a <= 1; // Write 0xEE to address 0x05
        addr_b <= 8'h05; data_in_b <= 8'hFF; we_b <= 1; // Write 0xFF to address 0x05
        #10;
        we_a <= 0; addr_a <= 8'h05; // Read from address 0x05
        we_b <= 0; addr_b <= 8'h05; // Read from address 0x05
        #10;

        // Disable ports
        en_a <= 0;
        en_b <= 0;
        #10;

        // End simulation
        $stop;
    end

endmodule

