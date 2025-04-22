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
  uvm_analysis_port#(apb_sequence_item) mon_in;
  apb_sequence_item item;
  
  function new(string name = "apb_in_mon", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_in = new("mon_in",this);
    item_collect_port = new("item_collect_port", this);
    if(!uvm_config_db#(virtual apb_if)::get(this,"*","vif",vif))
      `uvm_fatal(get_type_name(),"cant get virtual interface");
  endfunction
  
  task run_phase(uvm_phase phase);
  endtask
endclass
