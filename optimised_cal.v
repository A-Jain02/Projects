module calculator (a,b,oper, out);
  input [3:0] a , b;
  input [1:0] oper;
  output reg [7:0] out; 
  output reg [7:0] sum, diff , prod , div , rem ;

  assign out = sum | diff | prod | div ;

  case (oper)
  
