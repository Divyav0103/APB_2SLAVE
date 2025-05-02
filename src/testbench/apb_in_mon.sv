//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_in_mon.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_in_mon extends uvm_monitor;
  
  `uvm_component_utils(apb_in_mon)
  
  virtual apb_if vif;
  
  uvm_analysis_port#(apb_sequence_item) mon_in2sb;
  
  apb_sequence_item item;
  
  function new(string name = "apb_in_mon", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_in2sb = new("mon_in2sb",this);
    if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("Input Monitor","cant get virtual interface");
  endfunction
  
  task run_phase(uvm_phase phase);
    repeat(1) @(vif.mon_cb);
     item = apb_sequence_item::type_id::create("item");
    forever begin
      @(vif.mon_cb)
      begin
        item.transfer = vif.mon_cb.transfer;
        item.read_write = vif.mon_cb.read_write;
        item.apb_write_paddr = vif.mon_cb.apb_write_paddr;
        item.apb_write_data = vif.mon_cb.apb_write_data;
        item.apb_read_paddr = vif.mon_cb.apb_read_paddr;
       //end

        mon_in2sb.write(item);
        
        `uvm_info("input mon", $sformatf("--------------Input mon-----------------"), UVM_LOW);
        item.print();
        `uvm_info("input mon", $sformatf("-----------------------------------------------------"), UVM_LOW);	
        
      end
  endtask

endclass
