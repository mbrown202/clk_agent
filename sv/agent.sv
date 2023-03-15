class agent_object extends uvm_agent;
	driver_object		 drv;
    uvm_sequencer #(data_packet) sqr;

    `uvm_component_utils(agent_object) //register w/ factory
	function new(string name, uvm_component parent); //constructor
	  super.new(name, parent);
	endfunction
  
	virtual function void build_phase(uvm_phase phase);
	  drv = driver_object::type_id::create("drv", this);
	  sqr = new("sqr", this);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
	 drv.seq_item_port.connect(sqr.seq_item_export);  //connecting sequencer to driver
      `uvm_info(get_full_name(), "Connect stage complete.", UVM_LOW)
	endfunction
  
endclass: agent_object
