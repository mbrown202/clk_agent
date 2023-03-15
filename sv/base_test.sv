class base_test extends uvm_test;
  `uvm_component_utils(base_test) //factory

  clk_env env; //loading env

  function new(string name, uvm_component parent); //constructor
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = clk_env::type_id::create("env", this); //call the env
  endfunction:build_phase 
  
  virtual task run_phase(uvm_phase phase);
    clk_freq_change seq;
	
    uvm_top.print_topology(); //helps with debug
    `uvm_info(get_type_name(), "I am running", UVM_LOW)
    
    super.run_phase(phase);
    phase.raise_objection(this);
    seq = clk_freq_change::type_id::create("seq");
    seq.start(env.ao.sqr); //connects base test to sqr
    phase.drop_objection(this);
    
    //phase.phase_done.set_drain_time(this, 1500); //allows all elements to complete after final objection
  endtask: run_phase
endclass: base_test
