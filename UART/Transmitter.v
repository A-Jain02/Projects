`timescale 1ns / 1ps 

module uart_tx #( parameter DBIT = 8 , SB_TICK = 16)
  (
    input clk , reset_n , tx_start,
    input [ DBIT - 1 : 0 ] tx_din ,
    output tx_done_tick ,
    output tx 
  );

   localparam idle = 0 , start = 1 , data = 2 , stop = 3;
  
    reg [ 2 : 0 ] n_reg , n_next;  // counter for DBITS
    reg [ 3 : 0 ] s_reg , s_next;  // counter for s_tick
    reg [ DBIT - 1 : 0 ] b_reg , b_next ; // stores the received data bits 
    reg [ 1 : 0 ] state , state_next ; // the 4 states
    reg tx , tx_next ; // tracking the transmitted bit

    // state and reg initialization
    always @(posedge clk)
      begin  
          if (~reset_n) begin
            state <= idle;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
          end 
          else begin 
            state <= state_next ; 
            s_reg <= s_next ;
            n_reg <= n_next ;
            b_reg <= b_next ;
          end
      end

  always @*
    begin
        state_next <= state ;
        s_next <= s_reg ;
        n_next <= n_reg ;
        b_next <= b_reg ; 
        tx_done_tick = 1'b0;

    case (state) 
      idle:
        begin
          tx_next = 1'b1;
          if(tx_start)
            begin
              s_next = 0;
              b_next = tx_din;
              state_next = start ;
            end
        end
  
      start : 
        begin
          tx_next = 1'b0;
          if(s_tick)
              if(s_reg == 15) 
                begin 
                  s_next = 0;
                  n_next = 0;
                  state_next = data ;
                end
            else 
              s_next = s_reg + 1;
        end
  
      data : 
        begin 
          tx_next = b_reg[0] ; 
          if(s_tick)
              if(s_reg == 15)
                begin
                  s_next = 0;
                  b_next = { 1'b0 , b_reg[ DBIT -1 : 1 ] };
                  if( n_reg == (DBIT - 1))
                    state_next = stop;
                else
                  n_next = n_reg + 1;
                end
              else
                s_next = s_reg + 1;
        end
  
      stop : 
        begin
          tx_next = 1'b1;
          if(s_tick)
            if(s_next == (SB_TICK - 1)) begin
                tx_done_tick = 1;
                state_next = idle;
              end
            else
              s_next = s_reg + 1;
        end
  
      default : state_next = idle ;
  
    endcase 
  end
endmodule
      
            
    
            
          
        
          
          
        
    
        
            
          
        
        
      
  
    

  
