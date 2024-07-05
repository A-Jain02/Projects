`timescale 1ns / 1ps

module uart_rx #( parameter DBIT = 8 , SB_TICK = 16) 
  (
    input clk , reset_n , rx ,
    output [ DBIT - 1 : 0 ] rx_dout ,
    output reg rx_done_tick 
  );

    localparam idle = 0 , start = 1 , data = 2 , stop = 3;
  
    reg [ 2 : 0 ] n_reg ;  // counter for DBITS
    reg [ 3 : 0 ] s_reg ;  // counter for s_tick
    reg [ DBIT - 1 : 0 ] b_reg  ; // stores the received data bits 
    reg [ 1 : 0 ] state ; // the 4 states

    wire s_tick;
    timer_input #( .BITS(10), .CLOCK_FREQ(CLOCK_FREQ), .BAUD_RATE(BAUD_RATE)) baud_rate_generator (
    .clk(clk),
    .reset_n(reset_n),
    .done(s_tick)
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
            rx_done_tick =  1'b0;    
            case (state) 
                idle : 
                    if ( ~rx ) begin
                        s_next = 0 ; 
                        state_reg = start ;
                    end
                
                start : 
                    if(s_tick)
                        if ( s_reg == 7 ) begin
                            n_reg = 0 ;
                            s_reg = 0;
                            state_reg = data ;
                        end
                    else 
                        s_reg = s_reg + 1;
                
                data : 
                    if(s_tick)
                        if( s_reg  == 15 ) begin
                            s_reg = 0;
                            b_reg = { rx , b_reg[ DBIT - 1 : 1] }
                            if( n_reg == ( DBIT - 1))begin
                                state_reg = stop ;
                            end
                            else 
                                n_reg = n_reg + 1;
                        end
                        else
                            s_reg = s_reg + 1;
                stop : 
                    if (s_tick)
                        if(s_reg == (SB_TICK - 1)) begin
                            rx_done_tick = 1'b1;
                            state = idle;
                        end
                        else 
                            s_reg = s_reg + 1;
                default : state = idle ;
            endcase
      end

  assign rx_dout = b_reg ;
        
endmodule 
        
                   
                    
                        
        
                    
            
            
        
            
        

        
            
                  
            
            
    
