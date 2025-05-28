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

//////////////////////////////////////////////////////////////////////WRITE TO SLAVE 1////////////////////////////////////////////////////////////////////////
class apb_write0 extends apb_sequence;
  `uvm_object_utils(apb_write0)
   apb_sequence_item item;

  function new(string name = "apb_write0");
    super.new(name);
  endfunction
  
  virtual task body();
    item = apb_sequence_item::type_id::create("item");
    repeat(10) begin
      $display("write to slave1");
    `uvm_do_with(item, {transfer == 1;read_write == 1'b0;
                       apb_write_paddr[8] == 1'b0;})
   // `uvm_send(item);
      $display("write to slave1 done");
     end
  endtask
endclass

//////////////////////////////////////////////////////////////////////WRITE TO SLAVE 2////////////////////////////////////////////////////////////////////////
class apb_write1 extends uvm_sequence;
  `uvm_object_utils(apb_write1)
  
  apb_sequence_item item;

  function new(string name = "apb_write1");
    super.new(name);
  endfunction
  
  virtual task body();
    item = apb_sequence_item::type_id::create("item");
    repeat(10) begin
    `uvm_do_with(item, {transfer == 1;read_write == 1'b0;
                       apb_write_paddr[8] == 1'b1;})
    // `uvm_send(item);
      $display("slave 2");
  end 
 endtask
endclass

//////////////////////////////////////////////////////////////////////READ TO SLAVE 1////////////////////////////////////////////////////////////////////////
class apb_read0 extends uvm_sequence;
  
`uvm_object_utils(apb_read0)
  apb_sequence_item req;

  function new(string name = "apb_read0");
    super.new(name);
  endfunction
  
  virtual task body();
  repeat(10) begin
   req = apb_sequence_item::type_id::create("req");    
  `uvm_do_with(req, {transfer == 1;read_write == 1'b1;
                       apb_write_paddr[8] == 1'b0;})
   `uvm_send(req);
   end
  endtask
endclass

//////////////////////////////////////////////////////////////////////READ TO SLAVE 2////////////////////////////////////////////////////////////////////////
class apb_read1 extends uvm_sequence;
  `uvm_object_utils(apb_read1)
  apb_sequence_item req;

  function new(string name = "apb_read1");
    super.new(name);
  endfunction
  
  virtual task body();
   repeat(10) begin
    `uvm_do_with(req, {transfer == 1; read_write == 1'b1;
                       apb_write_paddr[8] == 1'b1;})
    `uvm_send(req); 
   end
  endtask
endclass

//////////////////////////////////////////////////////////////WRITE AND THEN READ TO SLAVE 1///////////////////////////////////////////////////////////////
class apb_write_read0 extends uvm_sequence;
  
`uvm_object_utils(apb_write_read0)
  apb_sequence_item wr_item;

 bit[8:0] addr;

  function new(string name = "apb_write_read0");
    super.new(name);
  endfunction
  
  task body();
    repeat(4) begin
  wr_item = apb_sequence_item::type_id::create("wr_item");
  `uvm_do_with(wr_item, {wr_item.transfer == 1;wr_item.read_write == 1'b0;
                       wr_item.apb_write_paddr[8] == 1'b0;})
  `uvm_send(wr_item);
   addr = wr_item.apb_write_paddr;

  `uvm_do_with(wr_item, {wr_item.transfer == 1;wr_item.read_write == 1'b1;
                       wr_item.apb_read_paddr == addr;})
  `uvm_send(wr_item);
 end
  endtask
endclass

//////////////////////////////////////////////////////////////WRITE AND THEN READ TO SLAVE 2///////////////////////////////////////////////////////////////
class apb_write_read1 extends uvm_sequence;
  
  `uvm_object_utils(apb_write_read1)
  apb_sequence_item wr_item;

 bit[8:0] addr;

  function new(string name = "apb_write_read1");
    super.new(name);
  endfunction
  
  task body();
    repeat(4) begin
  wr_item = apb_sequence_item::type_id::create("wr_item");
  `uvm_do_with(wr_item, {wr_item.transfer == 1;wr_item.read_write == 1'b0;
                         wr_item.apb_write_paddr[8] == 1'b1;})
  `uvm_send(wr_item);
   addr = wr_item.apb_write_paddr;

      `uvm_do_with(wr_item, {wr_item.transfer == 1;wr_item.read_write == 1'b0;
                       wr_item.apb_read_paddr == addr;})
  `uvm_send(wr_item);
   end
  endtask
endclass

//////////////////////////////////////////////////////////////WHEN TRANSFER IS LOW////////////////////////////////////////////////////////////////////////
class apb_transfer_disable_sequence extends apb_sequence;
  `uvm_object_utils(apb_transfer_disable_sequence)

  function new(string name = "apb_transfer_disable_sequence");
   super.new(name);
  endfunction

  virtual task body();
    req = apb_sequence_item::type_id::create("req");
    `uvm_do_with(req,{req.transfer == 0;})
    `uvm_send(req);
  endtask
endclass
