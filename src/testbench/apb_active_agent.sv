//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_active_agent.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_active_agent extends uvm_agent;
  
  `uvm_component_utils(apb_active_agent)
  
  apb_sequencer seqr;
  apb_driver drv;
  apb_in_mon input_mon;
  
  function new(string name = "apb_active_agent" ,uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    `uvm_info("ACTIVE_AGENT","Inside Build_phase apb_active_agent", UVM_HIGH);
    super.build_phase(phase);
    //if(get_is_active() == UVM_ACTIVE) begin
      seqr = apb_sequencer::type_id::create("seqr",this);
      drv = apb_driver::type_id::create("drv",this);
    //end
    input_mon = apb_in_mon::type_id::create("input_mon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
  //  super.connect_phase(phase);
   // if(get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    //end
  endfunction
endclass
