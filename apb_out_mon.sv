//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_out_mon.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_out_monitor extends uvm_monitor;
   `uvm_component_utils(apb_out_monitor)
   
   virtual apb_if.out_mon vif;
   uvm_analysis_port#(apb_sequence_item) item_collected_port2;
   apb_sequence_item item;
   
   function new(string name = "apb_out_mon", uvm_component parent);
     super.new(name, parent);
   endfunction: new
   
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     item_collected_port2 = new("mon_out", this);
     if(!uvm_config_db#(virtual apb_if)::get(this, "*", "vif", vif))
       `uvm_fatal(get_type_name(),"cant get virtual interface")
   endfunction: build_phase
       
   task run_phase(uvm_phase phase);
   endtask
endclass
