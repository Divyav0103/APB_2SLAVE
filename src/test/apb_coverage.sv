//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_active_agent.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

//`uvm_analysis_imp_decl(_ip)
//`uvm_analysis_imp_decl(_op)
 
class apb_coverage extends uvm_subscriber #(apb_sequence_item);
 
`uvm_component_utils(apb_coverage)
 
  uvm_analysis_imp_ip#(apb_sequence_item, apb_coverage)cport_ip;
  uvm_analysis_imp_op#(apb_sequence_item, apb_coverage)cport_op;
   
  apb_sequence_item in_pkt;
  apb_sequence_item out_pkt;
  
  real in_cov;
  real out_cov;

   covergroup input_cg;
      coverpoint in_pkt.transfer{
        bins transfer0 = {1'b0};
        bins transfer1 = {1'b1};
                   }
     coverpoint in_pkt.read_write{
       bins read_write0 = {1'b0};
       bins read_write1 = {1'b1};
                  }
 
     coverpoint in_pkt.apb_write_data{
       bins apb_write_data[] = {[8'h00:8'hFF]};
                  }
     coverpoint in_pkt.apb_read_paddr{
       bins apb_read_data[] = {[8'h00:8'hFF]};
                  }
     endgroup

   covergroup output_cg;
       coverpoint out_pkt.apb_read_data_out{
        bins apb_read_data_out[] = {[8'h00:8'hFF]};
                  } 
    
   endgroup
     
  function new(string name = "apb_coverage", uvm_component parent);
     super.new(name,parent);
     cport_ip = new("cport_op",this);
     cport_op = new("cport_op",this);
     input_cg = new();
     output_cg = new();
  endfunction
 
  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     in_cov = input_cg.get_coverage();
     out_cov = output_cg.get_coverage();
  endfunction

     virtual function void write_ip(apb_sequence_item pkt);
  in_pkt = pkt;
  input_cg.sample();
endfunction
     
    virtual function void write_op(apb_sequence_item pkt);
     out_pkt = pkt;
     output_cg.sample();
     endfunction

   virtual function write(apb_sequence_item t);
   endfunction
     
   function void report_phase(uvm_phase phase);
      super.report_phase(phase);
     `uvm_info("Coverage",$sformatf("Input Coverage is %0f \n Output Coverage is %0f",in_cov,out_cov),UVM_LOW)
     `uvm_info("Coverage",$sformatf("--------------------------"),UVM_LOW);
   endfunction
endclass
