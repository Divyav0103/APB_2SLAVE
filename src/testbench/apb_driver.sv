//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_driver.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
//`include "uvm_macros.svh"
//import uvm_pkg::*;
//`include "apb_sequence_item"

class apb_driver extends uvm_driver#(apb_sequence_item);
  
  `uvm_component_utils(apb_driver)
  
  virtual apb_if vif;
  apb_sequence_item item;
  
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_if)::get(this, " ", "vif", vif))
      begin
      `uvm_fatal(get_type_name(), "cant get virtual interface");
      end
   item = apb_sequence_item :: type_id :: create("item", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    
    super.run_phase(phase);
    repeat(1) @(vif.drv_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive();
    @(vif.drv_cb)
    begin
      if(item.transfer == 1) begin
        vif.drv_cb.read_write <= item.read_write;
        vif.drv_cb.apb_write_paddr <= item.apb_write_paddr;
        vif.drv_cb.apb_write_data <= item.apb_write_data;
        vif.drv_cb.apb_read_paddr <= item.apb_read_paddr;
      end
       `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
       // pkt.print();
       `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
  end
  endtask
endclass
