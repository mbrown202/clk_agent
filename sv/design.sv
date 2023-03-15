// Code your design here
module dummy_dut(input clk);
  initial begin 
    $strobe("dut clk is toggling = %b", clk); 
  end
endmodule



interface clk_inf;
 logic clk;
endinterface: clk_inf 

