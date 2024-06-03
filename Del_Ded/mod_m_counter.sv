module mod_m_counter 
  #(parameter M = 10) 
  (
    input logic clk, reset;
    output logic [N-1:0]q;
    output logic max_tick;
  );

  localparam N = $clog2(M);

  logic [N-1:0] r_reg , r_next ;

  always_ff @( posedge clk , posedge reset )
    begin 
      if(reset)
        r_reg <= 0;
      else 
        r_reg <= r_next;
    end

  assign r_next = ( r_reg == (M - 1)) ? 0 : r_reg + 1 ;

  assign q = r_reg ;

  assign max_tick = ( r_reg == (M - 1)) ? 1'b1 : 1'b0;
endmodule 

  
    

  
  
  
