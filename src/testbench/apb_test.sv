import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  
  apb_env env;
  apb_sequence seq;
  
  function new(string name = "apb_test", uvm_component parent);
    super.new(name, parent);
  endfunction	
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq = apb_sequence::type_id::create("seq", this);
    seq.start(env.a_agent.seqr);
    
    `uvm_info(get_type_name(), $sformatf("Inside APB_TEST"), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("Done APB_TEST"), UVM_LOW);
    
    phase.drop_objection(this);
  endtask
endclass
