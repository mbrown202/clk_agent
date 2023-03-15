class data_packet extends uvm_sequence_item; //sequence item
    rand int freq_khz;
    rand bit clk_enable;
  
    `uvm_object_utils_begin(data_packet) //factory
       `uvm_field_int(freq_khz, UVM_DEFAULT) //macro
       `uvm_field_int(clk_enable, UVM_DEFAULT)
    `uvm_object_utils_end
    
   function new(string name = "data_packet");
      super.new();
   endfunction: new
  
   virtual function string convert2string();
     string contents ="";
     $sformat(contents, "%s freq_khz=%d", contents, freq_khz);
     $sformat(contents, "%s clk_enable=%d", contents, clk_enable);
     return (contents);
   endfunction: convert2string
endclass: data_packet

//class clk_sequence extends uvm_sequence#(data_packet); //seq handle
//  `uvm_object_utils(clk_sequence) //factory
//  function new(string name = "clk_sequence"); //constructor
//    super.new(name);
//  endfunction: new
  
//  virtual task body(); 
//    for(int i = 0; i < 10; i++) begin
//      req = data_packet::type_id::create("req"); 
//      req.freq_khz = 10;
//      `uvm_do_with(req, {req.freq_khz == 10;});
//    end 
//  endtask: body
//endclass: clk_sequence

class clk_freq_change extends uvm_sequence#(data_packet);
  `uvm_object_utils(clk_freq_change) //factory
  function new(string name = "clk_freq_change"); //constructor
    super.new(name);
  endfunction: new
  
  virtual task body();
    req = data_packet::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.freq_khz == 10; req.clk_enable == 1;});
    finish_item(req); 
    
    #200000ns;

    req = data_packet::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.freq_khz == 1000; req.clk_enable == 1;});
    finish_item(req); 
    
    #200000ns;
  endtask: body
endclass: clk_freq_change
