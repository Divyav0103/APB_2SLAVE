//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_env.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

class apb_env extends uvm_env;

   `uvm_component_utils(apb_env)

  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  apb_active_agent a_agent;
  apb_passive_agent p_agent;
  apb_scoreboard sb;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a_agent = apb_active_agent::type_id::create("a_agent",this);
    p_agent = apb_passive_agent::type_id::create("p_agent",this);
//    sb = apb_scb::type_id::create("sb",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
//    a_agent.in_mon.in_mon2sb_cov.connect(sb.mon_in2sc_export);
//    p_agent.out_mon.out_mon2sb_cov.connect(sb.mon_out2sc_export);
//    a_agent.in_mon.in_mon2sb_cov.connect(cov.mon_in2cv_export);
//    p_agent.out_mon.out_mon2sb_cov.connect(cov.mon_out2cv_export);
    
  endfunction

endclass
