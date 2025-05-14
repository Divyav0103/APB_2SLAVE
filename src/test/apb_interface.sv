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
  
  clocking drv_cb@(posedge pclk or negedge presetn);
    default input #0 output #0;
    output transfer, apb_write_paddr, apb_write_data, apb_read_paddr, read_write;
    input presetn;
  endclocking
  
  clocking mon_cb@(posedge pclk or negedge presetn);
    default input #0 output #0;
    input transfer, apb_write_paddr, apb_write_data, apb_read_paddr, read_write, apb_read_data_out;
  endclocking
    
  modport DRV(clocking drv_cb);
  modport MON(clocking mon_cb);
endinterface
