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
    mon_in = new("mon_in",this);
    if(!uvm_config_db#(virtual apb_if)::get(this,"*","vif",vif))
      `uvm_fatal("Input Monitor","cant get virtual interface");
  endfunction
  
  task run_phase(uvm_phase phase);
    repeat(2) @(vif.mon_cb);
    forever begin
      item = apb_sequence_item::type_id::create("item", this);
      @(vif.mon_cb)
      begin
        item.i_ptransfer = vif.mon_cb.i_ptransfer;
        item.i_pwrite = vif.mon_cb.i_pwrite;
	item.i_pwaddr = vif.mon_cb.i_pwaddr;
	item.i_pwdata = vif.mon_cb.i_pwdata;
	item.i_praddr = vif.mon_cb.i_praddr;
        `uvm_info("input mon", $sformatf("---Input mon---"), UVM_LOW);
        item.print();
        `uvm_info("input mon", $sformatf("-------------------"), UVM_LOW);	
        mon_in2sb.write(item);
  endtask
endclass
