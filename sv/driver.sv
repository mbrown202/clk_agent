class driver_object extends uvm_driver #(data_packet); //specialized w/ packet_data type
    `uvm_component_utils(driver_object) //register w/ factory
    function new(string name, uvm_component parent); //constructor
      super.new(name, parent);
    endfunction

    virtual clk_inf vif;//send transactions from sequencer to DUT through vif
    
    data_packet pd; //variables are now global
  
    virtual function void build_phase(uvm_phase phase);
      if (!uvm_config_db #(virtual clk_inf)::get(this, "", "clk_inf", vif)) //connect inf to driver
      `uvm_fatal("DRIVER", "Driver failed to get virtual interface") //failing, need to grab from top (testbench.sv))
      
      pd=new(); //creates obj to be able to set clk_enable
      pd.clk_enable = 0; //default value
    endfunction

    virtual task run_phase (uvm_phase phase);
      vif.clk = 0;
      fork
         get_seq_item();
         drive_clk();
      join   
    endtask: run_phase 

    virtual task drive_clk();
      int clk_phase_time; //can only delay int
      
      forever begin
        `uvm_info(get_full_name(), $sformatf("made it to drive clk"), UVM_LOW)
        if (pd.clk_enable) begin
          vif.clk <= ~vif.clk; //makes clk toggle
          clk_phase_time = ((0.5 / pd.freq_khz )* 10**6); //delay 
          `uvm_info(get_full_name(), $sformatf("convert2string: %s %d" , pd.convert2string(), clk_phase_time), UVM_LOW) //convert
          #(clk_phase_time); //how to apply calculated delay
        end  
        else begin
          wait(pd.clk_enable); //needed this for times when clk_enable is zero
        end
      end //forever
    endtask: drive_clk

    virtual task get_seq_item();
      
      forever begin
        seq_item_port.get_next_item(pd); //request a new transaction
        pd.print();
        `uvm_info(get_full_name(), $sformatf("made it to get_seq_item"), UVM_LOW)
        seq_item_port.item_done(); //done with transaction
      end 
    endtask: get_seq_item
endclass
