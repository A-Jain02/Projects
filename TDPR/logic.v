`timescale 1ns/1ps



module True_DPR ( clk , en_a , en_b , we_a, we_b , din_a , din_b, dout_a, dout_b, addr_a, addr_b );

  #parameter ADDR_SIZE = 8 ;
  #parameter DATA_SIZE = 8 ;
  #parameter RAM_SIZE = 1 << ADDR_SIZE ;

  input clk, en_a , en_b , we_a , we_b ; 
  input [ DATA_SIZE - 1 : 0 ] din_a, din_b;
  input [ ADDR_SIZE - 1 : 0 ] addr_a , addr_b ;
  output reg [ DATA_SIZE - 1 : 0 ] dout_a, dout_b ;

  reg [ DATA_SIZE - 1 : 0 ] ram [ 0 : RAM_SIZE - 1 ] ;

  always (@posedge clk) begin
    if (en_a) begin 
      if ( we_a && ( !we_b || (addr_a != addr_b) )) begin 
        ram [ addr_a ] <= din_a ; 
      end
      else (!we_a) begin 
        dout_a <= ram [addr_a] ;
      end
    end
    else begin
      dout_a <= {DATA_SIZE{1'bz}};
    end 
  end

  always (@posedge clk) begin
    if (en_b) begin 
      if ( we_b && ( !we_a || addr_a != addr_b )) begin 
        ram [ addr_b ] <= din_b ; 
      end
      else (!we_b) begin 
        dout_b <= ram [addr_b] ;
      end
    end
    else begin
      dout_b <= {DATA_SIZE{1'bz}};
    end 
  end

  always (@posedge clk) begin 
    if ( en_a && en_b && we_a && we_b && (addr_a == addr_b)) begin
      ram[addr_a] <= din_a ;
    end 
  end
endmodule

    
  
      
        
  
  
  
  
