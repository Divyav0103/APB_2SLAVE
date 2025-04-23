//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequence_item.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_sequence_item extends uvm_sequence_item;
  rand bit i_ptransfer;
  rand logic [`AW-1:0]i_prwaddr;
  rand logic [`DW-1:0]i_pwdata;
  rand logic [`AW-1:0]i_praddr;
  rand logic [`DW-1:0]o_prdata;
  rand bit i_pwrite;
  
  `uvm_object_utils_begin(apb_sequence_item)
  `uvm_field_int(i_ptransfer, UVM_ALL_ON)
  `uvm_field_int(i_prwaddr, UVM_ALL_ON)
  `uvm_field_int(i_pwdata, UVM_ALL_ON)
  `uvm_field_int(i_praddr, UVM_ALL_ON)
  `uvm_field_int(i_pwrite, UVM_ALL_ON)
  `uvm_field_int(o_prdata, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "apb_sequence_item");
    super.new(name); 
  endfunction: new
  
endclass
