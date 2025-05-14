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
    seq = apb_sequence::type_id::create("seq", this);
  endfunction
 
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat(10) begin
    seq.start(env.a_agent.seqr);
    end
    phase.drop_objection(this);
  endtask
endclass

class apb_write0_slave0 extends apb_test;

  `uvm_component_utils(apb_write0_slave0)

  apb_write0 write0_slave0;
    
  function new(string name = " apb_write0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write0_slave0 = apb_write0::type_id::create("write0_slave0",this);
  endfunction
endclass


class apb_read0_slave0 extends apb_test;

  `uvm_component_utils(apb_read0_slave0)

  apb_read0 read0_slave0;
    
  function new(string name = " apb_read0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read0_slave0 = apb_read0::type_id::create("read0_slave0",this);
  endfunction
endclass

class apb_write_read0_slave0 extends apb_test;

  `uvm_component_utils(apb_write_read0_slave0)

  apb_write_read0 write_read0_slave0;
    
  function new(string name = " apb_write_read0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_read0_slave0 = apb_write_read0::type_id::create("write_read0_slave0",this);
  endfunction

    function void end_of_elaboration();
    super.end_of_elaboration();
    print(); 
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    write_read0_slave0.start(env.a_agent.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 200);
  endtask
endclass


