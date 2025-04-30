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
  
  bit [7:0] mem[0:255];
  
//  virtual apb_if vif;
  
  uvm_analysis_imp_ip#(apb_sequence_item, apb_scoreboard)aport_ip;
  uvm_analysis_imp_op#(apb_sequence_item, apb_scoreboard)aport_op;
  
  apb_sequence_item exp_pkt;
  apb_sequence_item act_pkt;
  
  apb_sequence_item exp_q[$];
  apb_sequence_item act_q[$];
  
  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
  /*  if(!uvm_config_db#(virtual apb_if)::get(this, "*", "vif",vif))
       `uvm_fatal("Scoreboard", "Unable to get the virtual interface")*/
  endfunction

    
     virtual function void write_ip(apb_sequence_item i_tr);
      exp_q.push_back(i_tr);
       $display("------------------------------------------------------------------------------------");
     endfunction

       virtual function void write_op(apb_sequence_item o_tr);
        act_q.push_back(o_tr);
         $display("------------------------------------------------------------------------------------");
      endfunction
    
         
       function void value_display(apb_sequence_item exp_pkt, apb_sequence_item act_pkt);
         if(exp_pkt.apb_write_data == act_pkt.apb_write_data && exp_pkt.apb_read_data_out == act_pkt.apb_read_data_out)
           begin
             `uvm_info("MATCH","",UVM_LOW)
             `uvm_info("Input Queue",$sformatf("Expected tx: queue size = %d, transfer = %b, apb_write_paddr = %0h, apb_write_data = %b, apb_read_paddr = %0h, read_write = %b, apb_read_data_out = %0h", exp_q.size(), i_tr.transfer, i_tr.apb_write_paddr, i_tr.apb_write_data, i_tr.apb_read_paddr, i_tr.read_write, i_tr.apb_read_data_out), UVM_LOW);
             `uvm_info("Output Queue",$sformatf("Actual tx: queue size = %d, transfer = %b, apb_write_paddr = %0h, apb_write_data = %b, apb_read_paddr = %0h, read_write = %b, apb_read_data_out = %0h", act_q.size(), o_tr.transfer, o_tr.apb_write_paddr, o_tr.apb_write_data, o_tr.apb_read_paddr, o_tr.read_write, o_tr.apb_read_data_out), UVM_LOW);
           end
         else begin
            `uvm_info("MISMATCH","",UVM_LOW)
            `uvm_info("Input Queue",$sformatf("Expected tx: queue size = %d, transfer = %b, apb_write_paddr = %0h, apb_write_data = %b, apb_read_paddr = %0h, read_write = %b, apb_read_data_out = %0h", exp_q.size(), i_tr.transfer, i_tr.apb_write_paddr, i_tr.apb_write_data, i_tr.apb_read_paddr, i_tr.read_write, i_tr.apb_read_data_out), UVM_LOW);
            `uvm_info("Output Queue",$sformatf("Actual tx: queue size = %d, transfer = %b, apb_write_paddr = %0h, apb_write_data = %b, apb_read_paddr = %0h, read_write = %b, apb_read_data_out = %0h", act_q.size(), o_tr.transfer, o_tr.apb_write_paddr, o_tr.apb_write_data, o_tr.apb_read_paddr, o_tr.read_write, o_tr.apb_read_data_out), UVM_LOW);
         end
       endfunction
       
       task run_phase(uvm_phase phase);
       `uvm_info("sb","Entering uvm_scoreboard",UVM_LOW);
         forever begin
           wait(exp_q.size() > 0 && act_q.size() > 0) begin
             exp_pkt = exp_q.pop_front();
             act_pkt = act_q.pop_front();
             
             if(exp_pkt.transfer) begin
               if(exp_pkt.read_write) begin
                 mem[exp_pkt.apb_write_paddr] = exp_pkt.apb_write_data;
                 value_display(exp_pkt, act_pkt);
               end
               else begin
                 exp_pkt.apb_read_data_out = mem[exp_pkt.apb_read_paddr];
                 value_display(exp_pkt, act_pkt);
               end
             end
           end
         end
       endtask
  endclass
         
         
         
