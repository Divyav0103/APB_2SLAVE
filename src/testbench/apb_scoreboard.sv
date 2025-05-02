//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_scoreboard.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_ip)
`uvm_analysis_imp_decl(_op)

class apb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(apb_scoreboard)

  logic [`DW-1:0] mem[511:0];
  //bit [7:0] mem2[0:255];

  // Changed class name to match the declared class
  uvm_analysis_imp_ip #(apb_seq_item, apb_scoreboard) aport_ip;
  uvm_analysis_imp_op #(apb_seq_item, apb_scoreboard) aport_op;

  virtual apb_if vif;

  apb_seq_item exp_pkt;
  apb_seq_item act_pkt;

  apb_seq_item exp_q[$];
  apb_seq_item act_q[$];

  int mat = 0;
  int mis = 0;

  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("Scoreboard", "Unable to get virtual interface");
  endfunction

  virtual function void write_ip(apb_seq_item in_txn);
    exp_q.push_back(in_txn);
    $display("### Expected transaction pushed to queue ###");
    $display("---------------------------------------------------------------------------------------");
  endfunction

  virtual function void write_op(apb_seq_item out_txn);
    act_q.push_back(out_txn);
    $display("### Actual transaction pushed to queue ###");
    $display("---------------------------------------------------------------------------------------");
  endfunction

  virtual function void compare(apb_seq_item exp_pkt, apb_seq_item act_pkt);
    if(exp_pkt.read_write) begin
      if (exp_pkt.apb_write_data == act_pkt.apb_write_data) && (exp_pkt.apb_write_paddr == act_pkt.apb_rwrite_paddr)) begin
      //exp_pkt.print();
        `uvm_info("MATCH",$sformatf( "----------------------MATCH------------------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h |  Actual apb_write_apddr = %0h ", exp_pkt.apb_write_data, act_pkt.apb_write_data, exp_pkt.apb_write_paddr, act_pkt.apb_write_paddr), UVM_LOW);
      //act_pkt.print();
        mat++;
    end else begin
      `uvm_info("MISMATCH",$sformatf( "----------------------MISMATCH------------------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h |  Actual apb_write_apddr = %0h ", exp_pkt.apb_write_data, act_pkt.apb_write_data, exp_pkt.apb_write_paddr, act_pkt.apb_write_paddr), UVM_LOW);
       mis++;
    end
    end

    else begin
      if ((exp_pkt.apb_read_data_Out == act_pkt.apb_read_data_Out) && (exp_pkt.apb_read_paddr == act_pkt.apb_read_paddr)) begin 
        `uvm_info("MATCH",$sformatf( "----------------------MATCH------------------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h |  Actual apb_write_apddr = %0h ", exp_pkt.apb_write_data, act_pkt.apb_write_data, exp_pkt.apb_write_paddr, act_pkt.apb_write_paddr), UVM_LOW);
      //act_pkt.print();
        mat++;
    end else begin
      `uvm_info("MISMATCH",$sformatf( "----------------------MISMATCH------------------------\n Expected apb_write_data = %0h |  Actual apb_write_data = %0h |  Expected apb_write_paddr =%0h |  Actual apb_write_apddr = %0h ", exp_pkt.apb_write_data, act_pkt.apb_write_data, exp_pkt.apb_write_paddr, act_pkt.apb_write_paddr), UVM_LOW);
       mis++;
    end
    end
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      exp_pkt = apb_sequence_item::type_id::create("exp_pkt",this);
      act_pkt = apb_sequence_item::type_id::create("act_pkt",this);
     
      wait (exp_q.size() > 0 && act_q.size() > 0);
      
      exp_pkt = exp_q.pop_front();
      act_pkt = act_q.pop_front();

      if (exp_pkt.transfer == 1) begin
        if (exp_pkt.read_write == 0) begin
          mem[exp_pkt.apb_write_paddr] = exp_pkt.apb_write_data;
          end else begin
            exp_pkt.apb_read_out = mem[exp_pkt.apb_read_paddr];
          end
      end
          compare(exp_pkt, act_pkt);
        //end
      //end
    end
  endtask

endclass
