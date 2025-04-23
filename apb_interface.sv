//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_interface.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------

interface apb_if(input bit pclk,input bit presetn);
  logic i_ptransfer;
  logic [`AW-1:0]i_pwaddr;
  logic [`DW-1:0]i_pwdata;
  logic [`AW-1:0]i_praddr;
  logic [`DW-1:0]o_prdata;
  logic i_pwrite;
  
  clocking drv_cb@(posedge pclk or negedge presetn);
    default input #0 output #0;
    output i_ptransfer, i_pwrite, i_pwaddr, i_wdata, i_praddr;
    input presetn;
  endclocking
  
  clocking mon_cb@(posedge pclk) or negedge presetn);
    default input #0 output #0;
    input o_prdata;
  endclocking
    
  
  modport DRV(clocking drv_cb);
  modport MON(clocking apb_mon);
endinterface
