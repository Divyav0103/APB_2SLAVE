//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequencer.sv
// Developer    : Divya V 
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_sequencer extends uvm_sequencer#(apb_sequence_item);
  `uvm_component_utils(apb_sequencer)
  function new(string name = "apb_sequencer",uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
 
