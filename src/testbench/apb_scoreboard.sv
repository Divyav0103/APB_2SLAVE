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

  bit [7:0] mem1[0:255];
  bit [7:0] mem2[0:255];

  // Changed class name to match the declared class
  uvm_analysis_imp_ip#(apb_seq_item, apb_scoreboard) aport_ip;
  uvm_analysis_imp_op#(apb_seq_item, apb_scoreboard) aport_op;

  virtual apb_if vif;

  apb_seq_item exp_pkt;
  apb_seq_item act_pkt;

  apb_seq_item exp_q[$];
  apb_seq_item act_q[$];

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
  endfunction

  virtual function void write_op(apb_seq_item out_txn);
    act_q.push_back(out_txn);
    $display("### Actual transaction pushed to queue ###");
  endfunction

  function void compare(apb_seq_item exp_pkt, apb_seq_item act_pkt);
    if (exp_pkt.apb_write_data == act_pkt.apb_write_data &&
        exp_pkt.apb_read_data_out == act_pkt.apb_read_data_out) begin
      exp_pkt.print();
      `uvm_info("MATCH", "Expected and actual packets matched", UVM_LOW)
      act_pkt.print();
    end else begin
      exp_pkt.print();
      act_pkt.print();
      `uvm_error("MISMATCH", "Expected and actual packets do not match");
    end
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      wait (exp_q.size() > 0 && act_q.size() > 0);
      
      exp_pkt = exp_q.pop_front();
      act_pkt = act_q.pop_front();

      if (exp_pkt.transfer) begin
        if (exp_pkt.read_write) begin
          // Write operation
          case (exp_pkt.apb_write_addr[7])
            1'b0: mem1[exp_pkt.apb_write_addr] = exp_pkt.apb_write_data;
            1'b1: mem2[exp_pkt.apb_write_addr] = exp_pkt.apb_write_data;
          endcase
          compare(exp_pkt, act_pkt);
        end else begin
          // Read operation
          case (exp_pkt.apb_read_addr[7])
            1'b0: exp_pkt.apb_read_data_out = mem1[exp_pkt.apb_read_addr];
            1'b1: exp_pkt.apb_read_data_out = mem2[exp_pkt.apb_read_addr];
          endcase
          compare(exp_pkt, act_pkt);
        end
      end
    end
  endtask

endclass
