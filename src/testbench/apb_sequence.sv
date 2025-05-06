//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_sequence.sv
// Developer    : Divya V 
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_sequence extends uvm_sequence#(apb_sequence_item);
  `uvm_object_utils(apb_sequence)

  virtual apb_if vif;
  apb_sequence_item req;
  
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

class apb_write0 extends apb_sequence;
  `uvm_object_utils(apb_write0)
   apb_sequence_item item;

  function new(string name = "apb_write0");
    super.new(name);
  endfunction
  
  virtual task body();
     item = apb_sequence_item::type_id::create("item");
    `uvm_do_with(item, {transfer == 1;read_write == 1'b0;
                       apb_write_paddr[8] == 1'b0;})
  endtask
endclass

class apb_write1 extends uvm_sequence;
  `uvm_object_utils(apb_write1)
  
  apb_sequence_item item;

  function new(string name = "apb_write1");
    super.new(name);
  endfunction
  
  virtual task body();
     item = apb_sequence_item::type_id::create("item");
    `uvm_do_with(item, {transfer == 1;read_write == 1'b0;
                       apb_write_paddr[8] == 1'b1;})
  endtask
endclass

class apb_read0 extends uvm_sequence;
  
`uvm_object_utils(apb_read0)
  apb_sequence_item req;

  function new(string name = "apb_read0");
    super.new(name);
  endfunction
  
  virtual task body();
//  req = apb_sequence_item::type_id::create("req");    
  `uvm_do_with(req, {transfer == 1;read_write == 1'b1;
                       apb_write_paddr[8] == 1'b0;})
  endtask
endclass


class apb_read1 extends uvm_sequence;
  `uvm_object_utils(apb_read1)
  apb_sequence_item req;

  function new(string name = "apb_read1");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req, {transfer == 1; read_write == 1'b1;
                       apb_write_paddr[8] == 1'b1;})
  endtask
endclass

class apb_write_read0 extends uvm_sequence;
  
`uvm_object_utils(apb_write_read0)
  apb_sequence_item read_item,write_item;

  function new(string name = "apb_write_read0");
    super.new(name);
  endfunction
  
  virtual task body();
  read_item = apb_sequence_item::type_id::create("read_item");
  write_item = apb_sequence_item::type_id::create("write_item");
  `uvm_do_with(write_item, {transfer == 1;read_write == 1'b0;
                       apb_write_paddr[8] == 1'b0;})
  `uvm_do_with(read_item, {transfer == 1;read_write == 1'b1;
                       apb_write_paddr[8] == 1'b0;})
 
  endtask
endclass


