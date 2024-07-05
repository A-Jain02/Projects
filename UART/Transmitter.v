`timescale 1ns / 1ps 

module uart_tx #( parameter DBIT = 8 , SB_TICK = 16)
  (
    input clk , reset_n , tx_start,
    input [ DBIT - 1 : 0 ] tx_din ,
    output tx_done_tick ,
    output reg tx 
  );

   localparam idle = 0 , start = 1 , data = 2 , stop = 3;
  
    reg [ 2 : 0 ] n_reg ;  // counter for DBITS
    reg [ 3 : 0 ] s_reg ;  // counter for s_tick
    reg [ DBIT - 1 : 0 ] b_reg  ; // stores the received data bits 
    reg [ 1 : 0 ] state  ; // the 4 states
    reg tx_next ; // tracking the transmitted bit

    wire tick;
    timer_input #( .BITS(11)) baud_rate_generator (
    .clk(clk),
    .reset_n(reset_n),
    .done(tick)
    );

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
            tx_done_tick = 1'b0;
            case (state) 
                  idle:
                    begin
                      tx_next = 1'b1;
                      if(tx_start)
                        begin
                          s_reg = 0;
                          b_reg = tx_din;
                          state = start ;
                        end
                    end
              
                  start : 
                    begin
                      tx_next = 1'b0;
                      if(s_tick)
                          if(s_reg == 15) 
                            begin 
                              s_reg = 0;
                              n_reg = 0;
                              state = data ;
                            end
                        else 
                          s_reg = s_reg + 1;
                    end
              
                  data : 
                    begin 
                      tx_next = b_reg[0] ; 
                      if(s_tick)
                          if(s_reg == 15)
                            begin
                              s_reg = 0;
                              b_reg = { 1'b0 , b_reg[ DBIT -1 : 1 ] };
                              if( n_reg == (DBIT - 1))
                                state = stop;
                            else
                              n_reg = n_reg + 1;
                            end
                          else
                            s_reg = s_reg + 1;
                    end
              
                  stop : 
                    begin
                      tx_next = 1'b1;
                      if(s_tick)
                        if(s_reg == (SB_TICK - 1)) begin
                            tx_done_tick = 1;
                            state = idle;
                          end
                        else
                          s_reg = s_reg + 1;
                    end
              
                  default : statea = idle ;
            endcase 
  end
endmodule
      
            
    
            
          
        
          
          
        
    
        
            
          
        
        
      
  
    

  
