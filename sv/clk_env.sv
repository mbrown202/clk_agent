class clk_env extends uvm_env;
  agent_object ao;
  
  `uvm_component_utils(clk_env)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ao = agent_object::type_id::create("agent", this); //call the agent
    `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
  endfunction: build_phase
endclass: clk_env