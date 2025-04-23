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
  uvm_analysis_port#(apb_sequence_item) mon_out2sb;
  apb_sequence_item item;
   
   function new(string name = "apb_out_mon", uvm_component parent);
     super.new(name, parent);
   endfunction: new
   
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     mon_out2sb = new("mon_out", this);
     if(!uvm_config_db#(virtual apb_if.MON)::get(this, "*", "vif", vif))
       `uvm_fatal("Output_Moniotr","cant get virtual interface")
   endfunction: build_phase
       
   task run_phase(uvm_phase phase);
     repeat(4) @(vif.mon_cb)
       forever begin
         item = apb_sequence_item::type_id::create("item", this);
         @(vif.mon_cb)
         begin
           item.apb_read_data_out = vif.mon_cb.apb_read_data_out;
           
           `uvm_info("output monitor", $sformatf("---Output monitor---"), UVM_LOW);	
           item.print();
           `uvm_info("output monitor", $sformatf("--------------------"), UVM_LOW);
           
           mon_out2sb.write(item);
         end
       end
   endtask
endclass
