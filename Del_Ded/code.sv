module delayed_debouncer (
  input logic sw ;
  input logic clk ;
  input logic reset ;
  output logic db ;
);
  logic m_tick;
  mod_m_counter #(.M(1_000_000)) ticker ( 
                  .clk(clk)
                  .reset(reset)
                  .q();
                  max_tick(m_tick)
  );
  

  typedef enum { edge

  
  
