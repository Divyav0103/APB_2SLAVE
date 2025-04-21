`include "apb_define.svh"
interface apb_if(input bit pclk,input bit presetn);
  logic transfer;
  logic [`AW-1:0]apb_write_paddr;
  logic [`DW-1:0]apb_write_data;
  logic [`AW-1:0]apb_read_paddr;
  logic [`DW-1:0]apb_read_data_out;
  logic READ_WRITE;
  
  clocking drv_cb@(posedge pclk or negedge presetn);
    default input #0 output #0;
    output transfer, READ_WRITE, apb_write_paddr, apb_write_data, apb_read_paddr;
    input presetn;
  endclocking
  
  clocking mon_cb@(posedge pclk) or negedge presetn);
    default input #0 output #0;
    input apb_read_data_out;
  endclocking
    
  
  modport DRV(clocking drv_cb);
  modport MON(clocking apb_mon);
endinterface
