//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_out_mon.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_out_monitor extends uvm_monitor;
  
  `uvm_component_utils(apb_out_monitor)
  
  virtual apb_if vif;
  uvm_analysis_port#(apb_sequence_item) mon_out2sb;
  apb_sequence_item item;
   
   function new(string name = "apb_out_mon", uvm_component parent);
     super.new(name, parent);
     mon_out2sb = new("mon_out", this);
   endfunction: new
   
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     item = apb_sequence_item::type_id::create("item", this);
     if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
       `uvm_fatal("Output_Moniotr","cant get virtual interface")
   endfunction: build_phase
       
   virtual task run_phase(uvm_phase phase);
     @(vif.mon_cb);
       forever begin
         @(vif.mon_cb);
         item.transfer = vif.mon_cb.transfer;
         item.read_write = vif.mon_cb.read_write;
         if(vif.read_write) begin
         item.apb_read_paddr = vif.mon_cb.apb_read_paddr;
         item.apb_read_data_out = vif.mon_cb.apb_read_data_out;
         end else begin
         item.apb_write_paddr = vif.mon_cb.apb_write_paddr;
         item.apb_write_data = vif.mon_cb.apb_write_data;
         end
       
         `uvm_info("output monitor", $sformatf("----------------------------------Output monitor-----------------------------"), UVM_LOW);
         item.print();
         `uvm_info("output monitor", $sformatf("------------------------------------------------------------------------------"), UVM_LOW);
         
         mon_out2sb.write(item);
         repeat(2) @(vif.mon_cb);
       end
   endtask
endclass
