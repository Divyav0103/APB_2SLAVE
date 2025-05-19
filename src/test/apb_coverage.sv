//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_active_agent.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

//`uvm_analysis_imp_decl(_in_mon)
//`uvm_analysis_imp_decl(_out_mon)

class apb_cov extends uvm_subscriber#(apb_sequence_item);

 `uvm_component_utils(apb_coverage)


  apb_sequence_item in_pkt;
  apb_sequence_item out_pkt;

 uvm_analysis_imp_ip#(apb_sequence_item, apb_coverage) cov2in_mon;
 uvm_analysis_imp_op#(apb_sequence_item, apb_coverage) cov2out_mon;

  real in_cov;
  real out_cov;

  //defining covergroup for input signals
  covergroup input_cg;
    coverpoint in_pkt.transfer{
      bins transfer_0 = {1'b0};
      bins transfer_1 = {1'b1};
    }
    coverpoint in_pkt.READ_WRITE{
      bins READ_WRITE_0 = {1'b0};
      bins READ_WRITE_1 = {1'b1};
    }
    coverpoint in_pkt.apb_write_data{
      bins pwdata[] = {[8'h00:8'hFF]};
    }
  endgroup

  covergroup output_cg;
    coverpoint out_pkt.apb_read_data_out{
      bins prdata[] = {[8'h00:8'hFF]};
    }
  endgroup

  function new(string name = "apb_cov", uvm_component parent);
    super.new(name, parent);
    cov2in_mon = new("cov2in_mon", this);
    cov2out_mon = new("cov2out_mon", this);
    input_cg = new();
    output_cg = new();
  endfunction


  //defining extract phase
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);	
    in_cov = input_cg.get_coverage();
    out_cov = output_cg.get_coverage();
  endfunction

  //defining write method for input monitor port
  virtual function void write_in_mon(apb_seq_item pkt);
    in_pkt = pkt;
    input_cg.sample();
  endfunction

  //defining write method for output monitor port
  virtual function void write_out_mon(apb_seq_item pkt);
    out_pkt = pkt;
    output_cg.sample();
  endfunction

  //defining default write method
  virtual function void write(apb_seq_item t);
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info("coverage", $sformatf("---Coverage Report---"), UVM_LOW);	
    `uvm_info("coverage", $sformatf("Input Coverage = %0f", in_cov), UVM_LOW);
    `uvm_info("coverage", $sformatf("Output Coverage = %0f", out_cov), UVM_LOW);
    `uvm_info("coverage", $sformatf("---------------------"), UVM_LOW);	
  endfunction

endclass
