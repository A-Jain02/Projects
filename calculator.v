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

module cal_mul( a , b , Prod) 
  input [3:0]a, b;
  output [7:0]Prod;
     
  wire [3:0]q0,q1,q2,q3,q4,temp1;
     
  wire [7:0]Prod;
  wire [5:0]q5,q6,temp2,temp3,temp4;
     
  array2 z1(a[1:0],b[1:0],q0[3:0]);
  array2 z2(a[3:2],b[1:0],q1[3:0]);
  array2 z3(a[1:0],b[3:2],q2[3:0]);
  array2 z4(a[3:2],b[3:2],q3[3:0]);
   
  assign temp1 ={2'b0,q0[3:2]};
  assign q4 = q1[3:0]+temp1;
  assign temp2 ={2'b0,q2[3:0]};
  assign temp3 ={q3[3:0],2'b0};
  assign q5 = temp2+temp3;
  assign temp4={2'b0,q4[3:0]};
  assign q6 = temp4+q5;
   
  assign Prod[1:0]=q0[1:0];
  assign Prod[7:2]=q6[5:0];
  
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

module cal_div( a, b, Div , Rem )
  input [3:0] a , b; 
  output [

     
        
      
     
    
