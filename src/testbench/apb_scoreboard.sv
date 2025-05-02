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

  bit [7:0]mem1[0:255];
  bit [7:0]mem2[0:255];
  
  uvm_analysis_imp_in_mon#(apb_seq_item, apb_scb)aport_ip;
  uvm_analysis_imp_out_mon#(apb_seq_item, apb_scb)aport_op;

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
    if(!uvm_config_db #(virtual apb_interface.mp_mon) :: get(this, "", "vif", vif))
      `uvm_fatal("Scoreboard", "Unable to get virtual interface");
  endfunction

  virtual function void write_ip(apb_seq_item in_txn);
    exp_q.push_back(in_txn);
    //`uvm_info("Input Queue", $sformatf("Got expected txn: queue size = %0d  transfer = %0b, apb_write_data = %0b, apb_write_address = %0h, i_pwdata = %0h, i_praddr = %0h, o_prdata = %0h", exp_q.size(), in_txn.i_ptransfer, in_txn.i_pwrite, in_txn.i_pwaddr, in_txn.i_pwdata, in_txn.i_praddr, in_txn.o_prdata), UVM_LOW);
    $display("----------------------------------------------------------------------------------------------------");
  endfunction

  virtual function void write_out_mon(apb_seq_item out_txn);
    act_q.push_back(out_txn);
    //`uvm_info("Output Queue", $sformatf("Got actual_txn: queue size = %0d  i_ptransfer = %0b, i_pwrite = %0b, i_pwaddr = %0h, i_pwdata = %0h, i_praddr = %0h, o_prdata = %0h", act_q.size(), out_txn.i_ptransfer, out_txn.i_pwrite, out_txn.i_pwaddr, out_txn.i_pwdata, out_txn.i_praddr, out_txn.o_prdata), UVM_LOW);
    $display("----------------------------------------------------------------------------------------------------");
  endfunction

  //Compare task
  function void compare(apb_sequence_item exp_pkt, apb_sequence_item act_pkt);
    if( exp_pkt.apb_write_data == act_pkt.apb_write_data && exp_pkt.apb_read_data_out == act_pkt.apb_read_data_out)
        begin
          exp_pkt.print();
          `uvm_info("MATCH","", UVM_LOW)
          act_pkt.print();
        end
      else begin
        exp_pkt.print();
        `uvm_error("MISMATCH","")
        act_pkt.print();
      end
  endfunction
  
  //Run phase
  task run_phase(uvm_phase phase);
    forever begin
      wait(exp_q.size() > 0 && act_q.size() > 0) begin
        exp_pkt = exp_q.pop_front();
        act_pkt = act_q.pop_front();

        if(exp_pkt.transfer) begin
          if(exp_pkt.read_write) begin
            case (exp_pkt.apb_write_addr[7])
              1'b0: mem1[exp_pkt.apb_write_addr] = exp_pkt.apb_write_data;
              1'b1: mem2[exp_pkt.apb_write_addr] = exp_pkt.apb_write_data;
            endcase
            compare(exp_pkt, act_pkt);
          end
          else begin
            case (exp_pkt.i_pwaddr[7])
              1'b0: exp_pkt.apb_read_data_out = mem1[exp_pkt.apb_read_addr];
              1'b1: exp_pkt.apb_read_data_out = mem2[exp_pkt.apb_read_addr;
            endcase
            compare(exp_pkt, act_pkt);
          end
        end
      end
    end
  endtask
endclass
