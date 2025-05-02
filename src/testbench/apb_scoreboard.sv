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

  virtual apb_if vif;

  uvm_analysis_imp_ip#(apb_sequence_item, apb_scoreboard) aport_ip;
  uvm_analysis_imp_op#(apb_sequence_item, apb_scoreboard) aport_op;

  apb_sequence_item exp_q[$];
  apb_sequence_item act_q[$];

  int match;
  int mismatch;

  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
    if (!uvm_config_db#(virtual apb_if)::get(this, "*", "vif", vif))
      `uvm_fatal("Scoreboard", "Unable to get the virtual interface");
  endfunction

  virtual function void write_ip(apb_sequence_item in_mon);
    exp_q.push_back(in_mon);
    $display("### WRITE_IP: Packet pushed to expected queue ###");
  endfunction

  virtual function void write_op(apb_sequence_item out_mon);
    act_q.push_back(out_mon);
    $display("### WRITE_OP: Packet pushed to actual queue ###");
  endfunction

  function void value_display(apb_sequence_item exp_pkt, apb_sequence_item act_pkt);
    `uvm_info("Check Start", "--------------------------------------------------", UVM_LOW);

    `uvm_info("Expected Packet", "Expected Packet Values:", UVM_LOW);
    exp_pkt.print();

    `uvm_info("Preset Check", $sformatf("PRST = %0d", vif.presetn), UVM_LOW);

    `uvm_info("Actual Packet", "Actual Packet Values:", UVM_LOW);
    act_pkt.print();

    `uvm_info("Comparison Result", $sformatf("Match = %0d, Mismatch = %0d", match, mismatch), UVM_LOW);

    if (mismatch)
      `uvm_error("MISMATCH", "----------- Sequence Mismatched -----------");
    if (match)
      `uvm_info("MATCH", "----------- Sequence Matched -----------", UVM_LOW);

    `uvm_info("Check End", "--------------------------------------------------", UVM_LOW);

    match = 0;
    mismatch = 0;
  endfunction

  task run_phase(uvm_phase phase);
    apb_sequence_item in_mon;
    apb_sequence_item out_mon;
    bit [7:0] mem[0:255];

    forever begin
      repeat (3) @(posedge vif.mon_cb);

      `uvm_info("SCOREBOARD", $sformatf("Expected Q Size = %0d, Actual Q Size = %0d", exp_q.size(), act_q.size()), UVM_LOW);

      wait (exp_q.size() > 0 && act_q.size() > 0);

      in_mon = exp_q.pop_front();
      out_mon = act_q.pop_front();

      if (!vif.presetn) begin
        // During reset: ignore results, just log
        in_mon.transfer = 0;
        out_mon.read_write = 0;
        value_display(in_mon, out_mon);
      end else begin
        // Perform functional modeling and comparison
        if (in_mon.read_write) begin
          // Write operation
          mem[in_mon.apb_write_paddr] = in_mon.apb_write_data;
        end else begin
          // Read operation
          if (in_mon.apb_read_paddr == in_mon.apb_write_paddr)
            in_mon.apb_read_data_out = mem[in_mon.apb_read_paddr];
        end

        // Compare the expected and actual packets
        if (in_mon.compare(out_mon)) begin
          match++;
        end else begin
          mismatch++;
        end

        value_display(in_mon, out_mon);
      end
    end
  endtask

endclass
