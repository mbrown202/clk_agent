class clk_sequencer extends uvm_sequencer #(data_packet); //sequencer handle
  `uvm_sequencer_utils(clk_sequencer) //sequencer factory
  
  function new(string name, uvm_component parent); //constructor
    super.new(name, parent);
  endfunction: new
  
endclass: clk_sequencer	


