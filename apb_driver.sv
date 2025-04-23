//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_driver.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_driver extends uvm_driver#(apb_sequence_item);
  
  `uvm_component_utils(apb_driver)
  
  virtual apb_if vif;
  
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_if)::get(this, "*", "vif", vif))
      begin
      `uvm_fatal(get_type_name(), "cant get virtual interface");
      end
  endfunction
  
  task run_phase(uvm_phase phase);
    repeat(1) #(vif.drv_sb);
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
      if(req.i_ptransfer == 1) begin
        vif.drv_cb.i_prwrite <= req.i_prwrite;
        vif.drv_cb.i_pwaddr <= req.i_prwaddr;
        vif.drv_cb.i_pwdata <= req.i_pwdata;
        vif.drv_cb.i_praddr <= req.i_praddr;
      end
       `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
       pkt.print();
       `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
  
  endtask
endclass
