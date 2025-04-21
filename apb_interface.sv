`include "apb_define.svh"
interface apb_if(input bit pclk,input bit presetn);
  logic transfer;
  logic [7:0]apb_write_paddr;
  logic [7:0]apb_write_data;
  logic [7:0]apb_read_paddr;
  logic [7:0]apb_read_data_out;
  logic READ_WRITE;
  
  clocking drv_cb@(posedge pclk);
    default input#0 output#0;
    output transfer;
    output presetn;
    output [7:0]apb_write_paddr;
    output [7:0]apb_write_data;
    output [7:0]apb_read_paddr;
    output [7:0]apb_read_data_out;
    output READ_WRITE;
  endclocking
  
  clocking apb_mon@(posedge pclk);
    default input#0 output#0;
    input [7:0] apb_read_data_out;
  endclocking
    
  
  modport DRV(clocking drv_cb);
    modport APB_MON(clocking apb_mon);
endinterface
