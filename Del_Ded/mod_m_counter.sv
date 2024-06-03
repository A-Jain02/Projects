module mod_m_counter 
  #(parameter M = 10) 
  (
    input logic clk, reset;
    output logic [N-1:0]q;
    output logic max_tick;
  );

  local parameter N = $clog2(M);
  
  
