//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_scoreboard.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_in_mon)
`uvm_analysis_imp_decl(_out_mon)

class apb_scb extends uvm_scoreboard;
  //Factory registration
  `uvm_component_utils(apb_scb)

  bit [7:0]mem1[0:255];
  bit [7:0]mem2[0:255];

  //Declare analysis ports
  uvm_analysis_imp_in_mon#(apb_seq_item, apb_scb)sb2in_mon;
  uvm_analysis_imp_out_mon#(apb_seq_item, apb_scb)sb2out_mon;

  // Declare virtual interface
  virtual apb_interface.mp_mon vif;

  //Declaring handles for the transaction
  apb_seq_item exp_pkt;
  apb_seq_item act_pkt;

  //Declaring two queues to store the actual and the expected values
  apb_seq_item exp_q[$];
  apb_seq_item act_q[$];

  //Constructor
  function new(string name = "apb_scb", uvm_component parent);
    super.new(name, parent);
  endfunction

  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb2in_mon = new("sb2in_mon", this);
    sb2out_mon = new("sb2out_mon", this);
    if(!uvm_config_db #(virtual apb_interface.mp_mon) :: get(this, "", "vif", vif))
      `uvm_fatal("Scoreboard", "Unable to get virtual interface");
  endfunction


  // Function to write input data to the input queue
  virtual function void write_in_mon(apb_seq_item in_txn);
    exp_q.push_back(in_txn);
    `uvm_info("Input Queue", $sformatf("Got expected txn: queue size = %0d  i_ptransfer = %0b, i_pwrite = %0b, i_pwaddr = %0h, i_pwdata = %0h, i_praddr = %0h, o_prdata = %0h", exp_q.size(), in_txn.i_ptransfer, in_txn.i_pwrite, in_txn.i_pwaddr, in_txn.i_pwdata, in_txn.i_praddr, in_txn.o_prdata), UVM_LOW);
    $display("----------------------------------------------------------------------------------------------------");
  endfunction


  // Function to write output data to the output queue
  virtual function void write_out_mon(apb_seq_item out_txn);
    act_q.push_back(out_txn);
    `uvm_info("Output Queue", $sformatf("Got actual_txn: queue size = %0d  i_ptransfer = %0b, i_pwrite = %0b, i_pwaddr = %0h, i_pwdata = %0h, i_praddr = %0h, o_prdata = %0h", act_q.size(), out_txn.i_ptransfer, out_txn.i_pwrite, out_txn.i_pwaddr, out_txn.i_pwdata, out_txn.i_praddr, out_txn.o_prdata), UVM_LOW);
    $display("----------------------------------------------------------------------------------------------------");
  endfunction

  //Compare task
  function void compare(apb_seq_item exp_pkt, apb_seq_item act_pkt);
      if( exp_pkt.i_pwdata == act_pkt.i_pwdata && exp_pkt.o_prdata == act_pkt.o_prdata)
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

        if(exp_pkt.i_ptransfer) begin
          if(exp_pkt.i_pwrite) begin
            case (exp_pkt.i_pwaddr[7])
              1'b0: mem1[exp_pkt.i_pwaddr] = exp_pkt.i_pwdata;
              1'b1: mem2[exp_pkt.i_pwaddr] = exp_pkt.i_pwdata;
            endcase
            compare(exp_pkt, act_pkt);
          end
          else begin
            case (exp_pkt.i_pwaddr[7])
              1'b0: exp_pkt.o_prdata = mem1[exp_pkt.i_praddr];
              1'b1: exp_pkt.o_prdata = mem2[exp_pkt.i_praddr];
            endcase
            compare(exp_pkt, act_pkt);
          end
        end
      end
    end
  endtask
endclass
