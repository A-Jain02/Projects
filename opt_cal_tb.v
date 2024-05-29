`timescale 1ns / 1ps

module calculator_tst ; 
  reg [3:0] a ;
  reg [3:0] b ;  
  reg [2:0] oper ; 

  wire [7:0] out; 

  calculator uut ( 
    .a(a) ,
    .b(b) ,
    .oper(oper) ,
    .out(out) ,
  );

  initial begin 
    a = 4'b1001 , b = 4'b0011 , oper = 3'b000 ;
    #10 
    a = 4'b1001 , b = 4'b0011 , oper = 3'b001 ;
    #10
    a = 4'b1001 , b = 4'b0011 , oper = 3'b010 ;
    #10
    a = 4'b1001 , b = 4'b0011 , oper = 3'b011 ;
    #10
    a = 4'b1001 , b = 4'b0011 , oper = 3'b100 ;
    #10
    a = 4'b1001 , b = 4'b0011 , oper = 3'b101 ;
    #10
    a = 4'b1001 , b = 4'b0011 , oper = 3'b111 ;
    #10 $finish;
    end

  initial begin 
    $display("\n \n \n");
      $monitor(" t = %3d , a = %b , b = %b , oper = %b , out = %b " , $time , a , b , oper , out );
  end 
endmodule
    

  
  
