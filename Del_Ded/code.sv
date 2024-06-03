`timescale 1ns / 1ps

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

  // clock and reset 
  always_ff @(posedge clk, posedge reset)
    begin 
      if(reset)
        state_reg <= zero;
      else 
        state_reg <= state_next;
    end

  // next state logic
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
              state_next = wait1_2;
            else
              state_next = wait1_1;
          else 
            state_next = zero ;
        
        wait1_2:
          if(sw)
            if(m_tick)
              state_next = one;
            else
              state_next = wait1_2;
          else 
            state_next = zero ;

        one:
          if(~sw)
            state_next = wait0_0 ; 
          else
            state_next = one;

        wait0_0:
          if(~sw)
            if(m_tick)
              state_next = wait0_1;
            else
              state_next = wait0_0;
          else 
            state_next = one ;

        wait0_1:
          if(~sw)
            if(m_tick)
              state_next = wait0_2;
            else
              state_next = wait0_1;
          else 
            state_next = one ;

        wait0_2:
          if(~sw)
            if(m_tick)
              state_next = zero;
            else
              state_next = wait0_2;
          else 
            state_next = one ;
        default: state_next = zero;
      endcase    
    end

  // moore output
  assign db = ( (state_next == one) ||   
               (state_next == wait0_0) || 
               (state_next == wait0_1) || 
               (state_next == wait0_2) 
              );    
    end
                
    
                  

          
        

  
  
