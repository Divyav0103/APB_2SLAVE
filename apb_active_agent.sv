class apb_active_agent extends uvm_agent;
  `uvm_component_utils(apb_active_agent)
  apb_sequencer seqr;
  apb_driver drv;
  apb_in_mon input_mon;
  
  function new(string name ,uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    `uvm_info("ACTIVE_AGENT","Inside Build_phase apb_active_agent", UVM_HIGH);
    super.build_phase(phase);
    seqr = apb_sequencer::type_id::create("seqr",this);
    drv = apb_driver::type_id::create("drv",this);
    input_mon = apb_in_mon::type_id::create("input_mon",this);
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
endclass
