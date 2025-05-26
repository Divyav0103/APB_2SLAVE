//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_interface.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

interface apb_if(input bit pclk,input bit presetn);
  
  logic transfer;
  logic [`AW-1:0]apb_write_paddr;
  logic [`DW-1:0]apb_write_data;
  logic [`AW-1:0]apb_read_paddr;
  logic read_write;
  logic [`DW-1:0]apb_read_data_out;
  
  clocking drv_cb@(posedge pclk);
    default input #0 output #0;
    output transfer, apb_write_paddr, apb_write_data, apb_read_paddr, read_write;
    input presetn;
  endclocking
  
  clocking mon_cb@(posedge pclk);
    default input #0 output #0;
    input transfer, apb_write_paddr, apb_write_data, apb_read_paddr, read_write, apb_read_data_out;
  endclocking
    
  modport DRV(clocking drv_cb);
  modport MON(clocking mon_cb);

  property check_transfer;
  @(posedge pclk) disable iff (!presetn)
  transfer |-> (read_write ? !$isunknown(apb_read_paddr) : !$isunknown(apb_write_paddr));
endproperty

assert property(check_transfer)
       $display("TRANSFER CHECK: ASSERTION PASS");
  else $error("TRANSFER CHECK: ASSERTION FAIL");

  property check_valid_write_addr;
  @(posedge pclk) disable iff (!presetn)
  (!read_write && transfer) |-> !$isunknown(apb_write_paddr);
endproperty

assert property(check_valid_write_addr)
       $display("VALID WRITE ADDRESS: ASSERTION PASS");
  else $error("VALID WRITE ADDRESS: ASSERTION FAIL");

  
property check_valid_read_addr;
  @(posedge pclk) 
  (read_write && transfer) |-> !$isunknown(apb_read_paddr);
endproperty

assert property(check_valid_read_addr)
       $display("VALID READ ADDRESS: ASSERTION PASS");
  else $error("VALID READ ADDRESS ASSERTION FAIL");

  property stable_write_addr;
  @(posedge pclk) disable iff (!presetn)
  (!read_write && transfer) |-> $stable(apb_write_paddr);
endproperty

assert property(stable_write_addr)
       $display("STABLE WRITE ADDRESS: ASSERTION PASS");
  else $error("STABLE WRITE ADDRESS: ASSERTION FAIL");

  property stable_read_addr;
  @(posedge pclk) disable iff (!presetn)
  (read_write && transfer) |-> $stable(apb_read_paddr);
endproperty

assert property(stable_read_addr)
       $display("STABLE READ ADDRESS: ASSERTION PASS");
  else $error("STABLE READ ADDRESS: ASSERTION FAIL");

endinterface


