//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_top.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "apb_define.sv"
`include "apb_package.sv"

module top();
  
 // logic presetn;
  logic pclk;
  
  initial begin
    presetn = 0;
    #10 presetn = 1;
  end
  
  apb_if inf(.pclk(pclk),.presetn(presetn));
  
 /* apb_slave#(.AW(`AW),.DW(`DW))
  dut(
    .pclk(inf.pclk),
    .presetn(inf.presetn),
    .i_transfer(inf.i_ptrasnfer),
    .i_prwrite(inf.i_prwrite),
    .i_pwaddr(inf.i_pwaddr),
    .i_pwdata(inf.i_pwdata),
    .i_praddr(inf.i_praddr),
    .o_prdata(inf.o_prdata)
  );
*/

  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  initial begin
   uvm_config_db#(virtual apb_if)::set(null, "*", "vif",inf);
  end
  
//  initial begin
  //  run_test();
 // end
endmodule



