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
  
  uvm_analysis_imp_ip#(apb_sequence_item, apb_scoreboard)aport_ip;
  uvm_analysis_imp_op#(apb_sequence_item, apb_scoreboard)aport_op;
  
  apb_sequence_item exp_pkt;
  apb_sequence_item act_pkt;
  
  apb_sequence_item exp_q[$];
  apb_sequence_item act_q[$];

  int pass = 0;
  int fail = 0;
  
  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_ip = new("aport_ip", this);
    aport_op = new("aport_op", this);
    if(!uvm_config_db#(virtual apb_if)::get(this, "*", "vif",vif))
       `uvm_fatal("Scoreboard", "Unable to get the virtual interface")
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
         `uvm_info("Check start","----------------------------------------------------Start----------------------------------------------",UVM_LOW);

         `uvm_info("expected","Expected Packet Values:", UVM_LOW);
         exp_pkt.print();
         
         `uvm_info("Preset check", $sformatf("-----------PRST = %d---------------",vif.presetn), UVM_LOW);
         
         `uvm_info("actual", "Actual Packet Values:", UVM_LOW);
         act_pkt.print();
         `uvm_info("VALUE_MATCH", $sformatf("-----------match = %0d, mismatch = %0d-----------",match, mismatch), UVM_LOW);
         
         if (mismatch) begin

	  `uvm_error("MISMATCH", $sformatf("-----------Sequence Mismatched-----------"));

	   mismatch = 0;

  end

  if (match) begin

	  `uvm_info("MATCH", $sformatf("-----------Sequence matched-----------"), UVM_LOW);

            match = 0;

  end
 `uvm_info("Check_stop", "-----------------------------Stop Check-----------------------", UVM_LOW);

     endfunction
       
       task run_phase(uvm_phase phase);
         apb_sequence_item in;
         apb_sequence_item out;
         
        bit [7:0] mem[0:255];
      
        super.run_phase(phase);
        forever begin
          
            `uvm_info("scb", $sformatf("###################### inside scb ##########################"), UVM_LOW)

    `uvm_info("scb", $sformatf("##############EXPECTED_OP_SIZE=%0d#####ACTUAL_OP_SIZE=%0D####################",exp_q.size, act_q.size), UVM_LOW)

        exp_pkt = apb_sequence_item::type_id::create("exp_pkt", this);
        act_pkt = apb_sequence_item::type_id::create("act_pkt", this);
        
           wait(exp_q.size() > 0 && act_q.size() > 0) begin
             
             in = exp_q.pop_front();
             out = act_q.pop_front();
           end
          if(!vif.presetn)) begin
            in.transfer = 0;
            out.read_write = 0;
            value_display(in, out);
          end
          
          else begin
            if(in.read_write) begin
              mem[in.apb_write_paddr] = in.apb_write_data;
            end
            else begin
              in.apb_read_paddr = in.apb_write_paddr;
              in.apb_read_data_out = mem[in.apb_read_paddr];
            end
          end
        end
       endtask
endclass
