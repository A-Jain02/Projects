module var_shift #(parameter N = 32) ( clk , dir , clr , en , in , q) 
  
  input clk , dir , clr , en ;
  input reg [N-1:0] in ; 
  output reg [N-1:0] q ;
  always @ (posedge clk)  
    if(!clr) // clear pin is active low always
        q <= 0;  // if clear then output resets
      else
        begin
          if(en) // output enable
            case (dir)
              0 : { 0 , q[N-1:1] };  // right shift
              1 : { q[N-2:0] , 0 };  // left shift
            endcase
          else  // output disable
            q <= q ;
        end 
endmodule

                
              
              
        
  
  

  
