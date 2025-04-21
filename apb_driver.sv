class apb_driver extends uvm_driver;
  `uvm_component_utils(apb_driver)
  
  virtual apb_if vif;
  uvm_analysis_port #(apb_sequence_item) item_collect_port;
  
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_if)::get(this, "*", "vif", vif))
      `uvm_fatal(get_type_name(), "cant get virtual interface");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      wait(vif.presetn);
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive();
  
  endtask
endclass
