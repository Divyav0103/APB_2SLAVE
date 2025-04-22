//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequence_item.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_sequence_item extends uvm_sequence_item;
  rand bit transfer;
  rand logic [`AW-1:0]apb_write_paddr;
  rand logic [`DW-1:0]apb_write_data;
  rand logic [`AW-1:0]apb_read_paddr;
  rand logic [`DW-1:0]apb_read_data_out;
  rand bit READ_WRITE;
  
  `uvm_object_utils_begin(apb_sequence_item)
  `uvm_field_int(transfer, UVM_ALL_ON)
  `uvm_field_int(apb_write_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_write_data, UVM_ALL_ON)
  `uvm_field_int(apb_read_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_read_data_out, UVM_ALL_ON)
  `uvm_field_int(READ_WRITE, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "apb_sequence_item");
    super.new(name); 
  endfunction: new
  
endclass
   
