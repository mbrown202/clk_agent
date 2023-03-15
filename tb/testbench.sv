 `include "uvm_macros.svh"
 `include "clk_pkg.sv"
  
module top;
   import clk_pkg::*;
   import uvm_pkg::*;
      
  clk_inf ivif(); //connecting interface
  dummy_dut dut(.clk(ivif.clk)); //connecting dut
  
   initial begin 
     $dumpfile("dump.vcd"); 
     $dumpvars; 
     
     uvm_config_db#(virtual clk_inf)::set(uvm_root::get() , "", "clk_inf", ivif); //interface
     run_test("base_test"); //remove testname later 
   end 
endmodule 