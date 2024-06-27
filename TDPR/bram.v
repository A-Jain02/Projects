module top_level (
    input wire clk,                   // Single clock input
    input wire en_a,                  // Enable signal for port A
    input wire en_b,                  // Enable signal for port B
    input wire [7:0] addr_a,          // Address input for port A
    input wire [7:0] addr_b,          // Address input for port B
    input wire [7:0] data_in_a,       // Data input for port A
    input wire [7:0] data_in_b,       // Data input for port B
    input wire we_a,                  // Write enable/read enable for port A (1: Write, 0: Read)
    input wire we_b,                  // Write enable/read enable for port B (1: Write, 0: Read)
    output wire [7:0] data_out_a,     // Data output for port A
    output wire [7:0] data_out_b      // Data output for port B
);

    // Instantiate the Block Memory Generator
    blk_mem_gen_0 your_memory (
        .clka(clk),
        .wea(we_a),
        .addra(addr_a),
        .dina(data_in_a),
        .douta(data_out_a),
        .ena(en_a),
        .clkb(clk),
        .web(we_b),
        .addrb(addr_b),
        .dinb(data_in_b),
        .doutb(data_out_b),
        .enb(en_b)
    );

endmodule
