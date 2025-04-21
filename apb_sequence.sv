
class apbsequence extends uvm_sequence;
  `uvm_object_utils(APB_2sequence)
  
  function new(string name = "apb_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    req = apbsequence_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask
endclass
