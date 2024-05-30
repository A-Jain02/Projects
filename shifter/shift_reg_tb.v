`timescale 1ns / 1ps

module var_shift_tb ;
  reg clk ; 
  reg clr ;
  reg dir ;
  reg en ;
  reg [31 : 0] in;
  reg [5 : 0] shift ;
  wire [31 : 0] q;

  var_shift dut(
    .clk(clk) ,
    .clr(clr) ,
    .dir(dir) ,
    .en(en) ,
    .in(in) ,
    .shift(shift) ,
    .q(q)
  );

  always #10 clk ~= clk // 20 ns each period
    
    initial begin
      clk <= 0;
      en <= 0;
      dir <= 0;
      clr <= 0;
      shift <= 6'b0; 
      in <= 32'h7105c1a6;
   end
    
  initial
    begin 
      clr <= 0 ; 
      #20 clr <= 1 ; 
          en <= 1 ; 
          shift = 6'b011011  // shift it by 27 bits
      repeat (shift) @ ( posedge clk )  // not sure if this format works ( bracket must have a decimal number i.e. number of clock cycles )
        $finish;
    end
  initial 
    $monitor ("time = %3d , in=%h, en=%0b, dir=%0b, shift=%b, out=%h \n" , $time , in , en , dir , shift, out);
  end 
endmodule

