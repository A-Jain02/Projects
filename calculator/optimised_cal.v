module calculator (a,b,oper,out);
  input [3:0] a , b;
  input [2:0] oper;
  output reg [7:0]out; 

  always @ (*)
    begin
      case (oper) 
    
        3'b000 : begin 
        out <= a + b; 
        end

        3'b001 : begin 
        out <= a - b ; 
         end

        3'b010 : begin 
        out <= a * b;
          end

        3'b011 : begin  
          if ( b == 4'b0000) begin
            $display ("Invalid operation!!");
        end
          else  
          begin
          out <= a / b ;   
           end
        end

        3'b100 : begin 
          if ( b == 4'b0000) begin
            $display ("Invalid operation!!");
          end
          else 
          begin
          out = a % b ;
          end
         end

         3'b101 : begin 
         out = ~a ;
         end
         default : out = 7'b0;   
      endcase
    end
endmodule

        
          
        
          
  
