//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequence_item.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
//`include "uvm_macros.svh"
//import uvm_pkg::*;
class apb_sequence_item extends uvm_sequence_item;
  rand bit transfer;
  rand bit read_write;
  rand logic [`AW-1:0]apb_write_paddr;
  rand logic [`DW-1:0]apb_write_data;
  rand logic [`AW-1:0]apb_read_paddr;
  logic [`DW-1:0]apb_read_data_out;
  
  `uvm_object_utils_begin(apb_sequence_item)
  `uvm_field_int(transfer, UVM_ALL_ON)
  `uvm_field_int(read_write, UVM_ALL_ON)
  `uvm_field_int(apb_write_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_write_data, UVM_ALL_ON)
  `uvm_field_int(apb_read_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_read_data_out, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "apb_sequence_item");
    super.new(name); 
  endfunction: new

//  constraint c0{apb_write_paddr[8] dist {0:=1, 1:=1};}
 
  constraint c1{if(transfer == 1 && read_write == 0)
    {
    apb_write_paddr inside {[0:8]};
//    apb_write_data inside{[0:255]};
    }}

  constraint c2{if(transfer == 1 && read_write == 1)
                  {
                   apb_read_paddr inside {[0:8]};
    }}

endclass
