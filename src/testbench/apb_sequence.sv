//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequence.sv
// Developer    : Divya V 
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_sequence extends uvm_sequence;
  `uvm_object_utils(apb_sequence)
  
  function new(string name = "apb_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    req = apb_sequence_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask
endclass

class apb_write0 extends uvm_sequence;
  `uvm_object_utils(apb_write0)
 apb_sequence_item req; 
  function new(string name = "apb_write0");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req, {transfer ==1;read_write == 1'b1;
                       apb_write_paddr[7] == 1'b0;})
  endtask
endclass
/*
class apb_write1 extends uvm_sequence;
  `uvm_object_utils(apb_write1)
  
  function new(string name = "apb_write1");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req, {read_write == 1'b1;
                       apb_write_paddr[7] == 1'b1;})
  endtask
endclass

class apb_read0 extends uvm_sequence;
  `uvm_object_utils(apb_read0)
  
  function new(string name = "apb_read0");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req, {read_write == 1'b0;
                       apb_write_paddr[7] == 1'b0;})
  endtask
endclass


class apb_read1 extends uvm_sequence;
  `uvm_object_utils(apb_read1)
  
  function new(string name = "apb_read1");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req, {read_write == 1'b0;
                       apb_write_paddr[7] == 1'b1;})
  endtask
endclass*/
