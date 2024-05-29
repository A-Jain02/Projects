module cal_add( a, b, c, s)
  input [3:0] a, b;
  output reg [3:0]s; 
  output reg c;

  always @ ( a or b )
    begin 
      { c, s} = a + b; 
    end 
endmodule

module cal_sub( a, b, D, Bout)
  input [3:0] a, b;
  output reg [3:0]D; 
  output reg Bout;

  always @ ( a or b )
    begin 
      { Bout, D} = a - b; 
    end 
endmodule

module 
