module delayed_debouncer (
  input logic sw ;
  input logic clk ;
  input logic reset ;
  output logic db ;
);
  logic m_tick;
  mod_m_counter #(.M(1_000_000)) ticker (  // (we need 10 ms counter. so 10 ns req 1 mil ticks to get to 10 ms. Hence the 1000000)
                  .clk(clk)
                  .reset(reset)
                  .q();
                  max_tick(m_tick)
  );
  
  typedef enum { zero , wait1_0, wait1_1, wait1_2, one, wait0_0, wait0_1, wait0_2} state_type ;
                
  //signal declarations 
  state_type state_reg, state_next; 

  always_ff @(posedge clk, posedge reset)
    begin 
      if(reset)
        state_reg <= zero;
      else 
        state_reg <= state_next;
    end

  always_comb
    begin 
      case(state_reg)
        zero: 
          if(sw) 
            state_next = wait1_0;
          else
            state_next = zero;
        wait1_0:
          if(sw)
            if(m_tick)
              state_next = wait1_1;
            else
              state_next = wait1_0;
          else 
            state_next = zero ;
        
         wait1_1:
          if(sw)
            if(m_tick)
              state_next = wait1_1;
            else
              state_next = wait1_0;
          else 
            state_next = zero ;
        
         wait1_2:
          if(sw)
            if(m_tick)
              state_next = wait1_1;
            else
              state_next = wait1_0;
          else 
            state_next = zero ;
        
    end
  
  
                
      
    end
                
    
                  

          
        

  
  
