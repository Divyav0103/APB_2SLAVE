class apb_driver extends uvm_driver;
  `uvm_component_utils(apb_driver)
  
  virtual apb_if vif;
  uvm_analysis_port #(apb_sequence_item) item_collect_port;
  
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req = apb_sequence_item::type_id::create("req", this);
    if(!uvm_config_db #(virtual apb_if)::get(this, "*", "vif", vif))
      `uvm_fatal(get_type_name(), "cant get virtual interface");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive();
    @(vif.drv_cb)
    begin
    vif.drv_cb.transfer <= req.transfer;
    vif.drv_cb.pwrite <= req.pwrite;
    vif.drv_cb.pwaddr <= req.pwaddr;
    vif.drv_cb.i_pwdata <= req.pwdata;
    vif.drv_cb.praddr <= req.praddr;
    `uvm_info("DRIVER OUTPUT","INSIDE DRIVER",UVM_LOW);
    req.print();
    end
  endtask
endclass
