class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  
  apb_env env;
  apb_write0 seq;
  
  function new(string name = "apb_test", uvm_component parent);
    super.new(name, parent);
  endfunction	
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction
 
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq = apb_write0::type_id::create("seq");
    repeat(5) begin
    seq.start(env.a_agent.seqr);
    end
    `uvm_info(get_type_name(), $sformatf("Inside apb_wite0"), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("Done apb_write0"), UVM_LOW);
    
    phase.drop_objection(this);
  endtask
endclass
