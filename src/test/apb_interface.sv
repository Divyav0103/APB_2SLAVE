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
  @(posedge pclk) 
  transfer |-> (read_write ? !$isunknown(apb_read_paddr) : !$isunknown(apb_write_paddr));
endproperty

    //TRANSFER CHECK//
assert property(check_transfer)
       $display("TRANSFER CHECK: ASSERTION PASS");
  else $error("TRANSFER CHECK: ASSERTION FAIL");

   //VALID WRITE ADDRESS//
  
  property check_valid_write_addr;
  @(posedge pclk) 
  (!read_write && transfer) |-> !$isunknown(apb_write_paddr);
endproperty

assert property(check_valid_write_addr)
       $display("VALID WRITE ADDRESS: ASSERTION PASS");
  else $error("VALID WRITE ADDRESS: ASSERTION FAIL");

 //VALID READ ADDRESS//
  
property check_valid_read_addr;
  @(posedge pclk) 
  (read_write && transfer) |-> !$isunknown(apb_read_paddr);
endproperty

assert property(check_valid_read_addr)
       $display("VALID READ ADDRESS: ASSERTION PASS");
  else $error("VALID READ ADDRESS ASSERTION FAIL");

  //VALID WRITE DATA//
  
property check_valid_write_data;
  @(posedge pclk) 
  (!read_write && transfer) |-> !$isunknown(apb_write_data);
endproperty

assert property(check_valid_write_data)
       $display("VALID WRITE DATA: ASSERTION PASS");
  else $error("VALID WRITE DATA: ASSERTION FAIL");

//VAILD READ DATA//
  
property check_valid_read_data;
  @(posedge pclk) 
  (read_write && transfer) |=> ##2 !$isunknown(apb_read_data_out);
endproperty

assert property(check_valid_read_data)
       $display("VALID READ DATA: ASSERTION PASS");
  else $error("VALID READ DATA: ASSERTION FAIL",$time);


//RESET CHECK//
  property check_resetn;
  @(posedge pclk)
    (!presetn) |=> (transfer == 0 && read_write == 0 && apb_write_paddr == 9'b0 && apb_read_paddr == 9'b0);
endproperty

assert property(check_resetn)
       $display("RESET CHECK: ASSERTION PASS");
  else $error("RESET CHECK: ASSERTION FAIL", $time);


endinterface


