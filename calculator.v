module cal_add( a, b, c, Sum)
  input [3:0] a, b;
  output reg [3:0]Sum; 
  output reg c;

  always @ ( a or b )
    begin 
      { c , Sum } = a + b;
    end 
endmodule

module cal_sub( a, b, Diff, Bout)
  input [3:0] a, b;
  output reg [3:0]Diff; 
  output reg Bout;

  always @ ( a or b )
    begin 
      { Bout, Diff } = a - b; 
    end 
endmodule

module cal_mul( a , b , Prod , C) 
  input [3:0] a, b;
  output reg [7:0]Prod;
  output reg C;

  always @ ( a or b ) 
    begin 
      
    end
  

endmodule 









module array2(a, b, c)
  input [1:0]a, b;
  output reg [3:0]c;
  output reg [3:0]temp;

  always @ ( a or b )
    begin 
      c[0] = a[0] & b[0];
      temp[0] = a[1] & b[0];
      temp[1] = a[0] & b[1];
      temp[2] = a[1] & b[1];
      ha z1(temp[0],temp[1],c[1],temp[3]);
      ha z2(temp[2],temp[3],c[2],c[3]);
    end
endmodule
  
module ha( a, b, s, cout)
   input [3:0] a, b;
  output reg [3:0]s; 
  output reg cout;

  always @ ( a or b )
    begin 
      s = a ^ b ;
      cout = a & b ; 
    end 
endmodule

     
        
      
     
    
