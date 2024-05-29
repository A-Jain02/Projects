`timescale 1ns / 1ps

module calculator_tst ; 
  reg [3:0] a ;
  reg [3:0] b ;  
  reg [2:0] oper ; 

  wire [7:0] out; 

  calculator dut( 
    .a(a) ,
    .b(b) ,
    .oper(oper) ,
    .out(out)
    );

  initial begin 
    a = 4'b1111 ;
    b = 4'b0110 ;
    oper = 3'b000;
    #120 $finish;
    end 
    always #10 oper = oper + 3'b001; 
   
  initial begin 
    $display("\n \n \n");
    $monitor(" t = %3d , a = %b , b = %b , oper = %b , out = %b \n " , $time , a , b , oper , out );

  end 
endmodule
    

  
  
