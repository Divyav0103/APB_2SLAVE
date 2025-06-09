//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_scoreboard.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_out)

class apb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(apb_scoreboard)

  logic [`DW-1:0] mem[0:511];

  int match = 0;
  int mismatch = 0;

  uvm_analysis_imp_in #(apb_sequence_item, apb_scoreboard) aport_ip;
  uvm_analysis_imp_out #(apb_sequence_item, apb_scoreboard) aport_op;

  virtual apb_if vif;

  apb_sequence_item exp_pkt;
  apb_sequence_item act_pkt;

  apb_sequence_item exp_q[$];
  apb_sequence_item act_q[$];

  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("Scoreboard", "Unable to get virtual interface");
    end
  endfunction

  virtual function void write_in(apb_sequence_item in_txn);
    exp_q.push_back(in_txn);
    $display("Expected Scoreboared Results:");
    in_txn.print();
    $display("--------------------------------------------------------------------------------------------------------------------------------------------------");
  endfunction

  virtual function void write_out(apb_sequence_item out_txn);
    act_q.push_back(out_txn);
    out_txn.print();
    $display("Actual Scoreboard Results:");
    $display("-------------------------------------------------------------------------------------------------------------------------------------------------");
  endfunction

  function void compare(apb_sequence_item exp_pkt, apb_sequence_item act_pkt);
    if(exp_pkt.read_write == 0) begin
      if (exp_pkt.apb_write_data == act_pkt.apb_write_data && exp_pkt.apb_write_paddr == act_pkt.apb_write_paddr) begin
        match++;
        $display("_____________________________________WRITE_PASS__________________________________________________________");
        display_match(exp_pkt, act_pkt);
      end else begin
        mismatch++;
        $display("_____________________________________WRITE_FAIL________________________________________________________________");
        display_mismatch(exp_pkt, act_pkt);
      end
    end else begin
      if (exp_pkt.apb_read_data_out == act_pkt.apb_read_data_out && exp_pkt.apb_read_paddr == act_pkt.apb_read_paddr) begin
        match++;
        $display("_____________________________________READ_PASS________________________________________________________________");
        display_match(exp_pkt, act_pkt);
      end else begin
        mismatch++;
        $display("_____________________________________READ_FAIL________________________________________________________________");
        display_mismatch(exp_pkt, act_pkt);
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
            exp_pkt.apb_read_data_out = mem[exp_pkt.apb_read_paddr];
          end
          compare(exp_pkt, act_pkt);
    end
    end
  endtask
 
 function void display_match(apb_sequence_item in_pkt, apb_sequence_item out_pkt);
    `uvm_info("Check_start", "---Start Check---", UVM_LOW);
    `uvm_info("expected", "---Expected---", UVM_LOW); in_pkt.print();
    `uvm_info("actual", "---Actual---", UVM_LOW); out_pkt.print();
    `uvm_info("MATCH", $sformatf("Match count = %0d", match), UVM_LOW);
    `uvm_info("Check_stop", "---Stop Check---", UVM_LOW);
  endfunction

  function void display_mismatch(apb_sequence_item in_pkt, apb_sequence_item out_pkt);
   // WRITE transaction
    if (in_pkt.read_write == 0) begin 
      if (in_pkt.apb_write_paddr != out_pkt.apb_write_paddr)
        `uvm_info("ADDR_MISMATCH", $sformatf("Expected Addr: %0h, Got: %0h", in_pkt.apb_write_paddr, out_pkt.apb_write_paddr), UVM_LOW);
      if (in_pkt.apb_write_data != out_pkt.apb_write_data)
        `uvm_info("DATA_MISMATCH", $sformatf("Expected Data: %0h, Got: %0h", in_pkt.apb_write_data, out_pkt.apb_write_data), UVM_LOW);
    end else begin 

      // READ transaction
      if (in_pkt.apb_read_paddr != out_pkt.apb_read_paddr)
        `uvm_info("ADDR_MISMATCH", $sformatf("Expected Addr: %0h, Got: %0h", in_pkt.apb_read_paddr, out_pkt.apb_read_paddr), UVM_LOW);
      if (in_pkt.apb_read_data_out != out_pkt.apb_read_data_out)
        `uvm_info("DATA_MISMATCH", $sformatf("Expected Data: %0h, Got: %0h", in_pkt.apb_read_data_out, out_pkt.apb_read_data_out), UVM_LOW);
    end
    `uvm_error("MISMATCH", $sformatf("Mismatch count = %0d", mismatch));
    `uvm_info("Check_stop", "---Stop Check---", UVM_LOW);
  endfunction
endclass


