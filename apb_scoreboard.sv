//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_scoreboard.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------


class apb_scoreboard extends uvm_scoreboard;

  `uvm_compoment_utils(apb_scoreboard)
  
  virtual apb_if inf;
  
  uvm_analysis_imp_ip #(apb_sequence_item, apb_scoreboard) aport_ip;
  uvm_analysis_imp_op #(apb_sequence_sequence_item, apb_scoreboard) aport_op;
  
  uvm_tlm_fifo #(apb_sequence_item) exp_op_fifo;
  uvm_tlm_fifo #(apb_sequence_item) act_op_fifo;
  
  extern function void compare(apb_sequence_item exp_tr, apb_sequence_item act_tr);
  extern function void display(apb_sequence_item exp_tr, apb_sequence_item act_tr);
  
  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
    exp_op_fifo = new("exp_op_fifo", this);
    act_op_fifo = new("act_op_fifo", this);
  endfunction
    
    function void write_ip(apb_sequnece_item tr);
      //put tx in expected fifo
    endfunction
    
    function void write_op(apb_sequence_item tr);
      //put tx in actual fifo
    endfunction
    
    //Run phase
    task run_phase(uvm_phase phase);
      //compare logic
    endtask
  
endclass




