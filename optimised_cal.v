module calculator (a,b,oper,out);
  input [3:0] a , b;
  input [2:0] oper;
  output reg [7:0] out; 
  reg [7:0] sum, diff , prod , div , mod , neg;

  assign out = sum | diff | prod | div | mod | neg ;

  always @ (*)
    begin
      case (oper) 
    
        3'b000 : begin 
          sum <= a + b ; 
          diff <= 7'b0 ;
          prod <= 7'b0 ; 
          div <= 7'b0 ; 
          mod <= 7'b0 ;
          neg <= 7'b0 ;
        end

        3'b001 : begin 
          sum <= 7'b0 ; 
          diff <= a-b ;
          prod <= 7'b0 ; 
          div <= 7'b0 ; 
          mod <= 7'b0 ;
          neg <= 7'b0 ;
        end

        3'b010 : begin 
          sum <= 7'b0 ; 
          diff <= 7'b0 ;
          prod <= a * b ; 
          div <= 7'b0 ; 
          mod <= 7'b0 ; 
          neg <= 7'b0 ;
        end

        3'b011 : begin  
          if ( b == 4'b0000) 
            $display ("Invalid operation!!");
        end
          else begin   
            sum <= 7'b0 ; 
            diff <= 7'b0 ;
            prod <= 7'b0 ; 
            div <= a / b ; 
            mod <= 7'b0 ;
            neg <= 7'b0 ;
        end

        3'b100 : begin 
          if ( b == 4'b0000) 
            $display ("Invalid operation!!");
        end
          else begin
            sum <= 7'b0 ; 
            diff <= 7'b0 ;
            prod <= 7'b0 ; 
            div <= 7'b0 ; 
            mod <= a % b ; 
            neg <= 7'b0 ;
        end

         3'b101 : begin 
          sum <= 7'b0 ; 
          diff <= 7'b0 ;
          prod <= 7'b0 ; 
          div <= 7'b0 ; 
          mod <= 7'b0 ;
          neg <= ~ a; 
        end

        default : $display(" Not a valid operation " );
      endcase
    end
endmodule

        
          
        
          
  
