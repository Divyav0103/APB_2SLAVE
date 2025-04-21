import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_sequence_item.sv"
class apb_sequencer extends uvm_sequencer;
  `uvm_component_utils(apb_sequencer)
  function new(string name = "",uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
 
