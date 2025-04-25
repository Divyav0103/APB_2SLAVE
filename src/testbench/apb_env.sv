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
  //apb_coverage cov;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a_agent = apb_active_agent::type_id::create("a_agent",this);
    p_agent = apb_passive_agent::type_id::create("p_agent",this);
    sb = apb_scoreboard::type_id::create("sb",this);
    //cov = apb_coverage::type_id::create("cov", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     a_agent.input_mon.mon_in2sb.connect(sb.aport_ip);
     p_agent.output_mon.mon_out2sb.connect(sb.aport_op);
     //a_agent.input_mon.mon_in2sb_cov.connect(cov.cport_ip);
     //p_agent.output_mon.mon_out2sb_cov.connect(cov.cport_op);
    
  endfunction

endclass
