class apb_passive_agent extends uvm_agent;
  `uvm_component_utils(apb_passive_agent)
  apb_out_monitor output_mon;
  
  function new(string name = "apb_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    output_mon = apb_out_monitor::type_id::create("output_mon", this);
  endfunction: build_phase
endclass: apb_passive_agent
