//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_top.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
//import uvm_pkg::*;
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "apb_package.sv"

module top();
  
  bit presetn;
  bit pclk;
  
  initial begin
    presetn = 0;
    #10 
    presetn = 1;
  end
  
  apb_if inf(.pclk(pclk),.presetn(presetn));
  APB_Protocol dut(.PCLK(inf.pclk),
               .PRESETn(inf.presetn),
               .transfer(inf.transfer),
               .apb_write_data(inf.apb_write_data),
               .apb_write_paddr(inf.apb_write_paddr),
               .apb_read_paddr(inf.apb_read_paddr),
               .READ_WRITE(inf.read_write),
               .apb_read_data_out(inf.apb_read_data_out));
               

  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  initial begin
   uvm_config_db#(virtual apb_if)::set(null, "*", "vif",inf);
   //uvm_config_db#(virtual apb_if.MON)::set(null, "*", "vif", inf);

    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
  initial begin
    run_test ("reg_test"); 
  end
endmodule



