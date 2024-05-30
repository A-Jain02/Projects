`timescale 1ns/ 1ps

module var_shift ( clk , dir , clr , en , in , shift , q ) 
  
  input clk , dir , clr , en ;
  input reg [5:0] shift ; 
  input reg [31:0] in ; 
  output reg [31:0] q ;
  
  always @ (posedge clk)  
    if(!clr) // clear pin is active low always
        q <= 0;  // if clear then output resets
      else
        begin
          if(en) // output enable
            case (dir)
              0 : { in[31-shift:0] , q[31:shift] };  // right shift
              1 : { q[31-shift:0] , in[31:31-(shift-1) };  // left shift
            endcase
          else  // output disable
            q <= q ;
        end 
endmodule

                
              
              
        
  
  

  
