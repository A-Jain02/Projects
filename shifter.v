module var_shift #(parameter N = 32) ( input [N-1:0]a,
                                      input clk , dir , clr , en ,
                                      output reg[N-1:0] q ) 
  always @ (posedge clk)  
      if(!clr)
        q <= 0;
      else 
        begin 
          if(en)
            case (dir)
              0 : { 0 , q[N-1:1]};
              1 : { q[N-2:0] , 0};
            endcase
          else 
            q <= q ; 
        end 
endmodule

                
              
              
        
  
  

  
