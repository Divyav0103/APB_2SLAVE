//------------------------------------------------------------------------------
// Project      : APB
// File Name    : apb_top.sv
// Developer    : Divya V
//------------------------------------------------------------------------------
// Copyright    : 2024(c) Manipal Center of Excellence. All rights reserved.
//------------------------------------------------------------------------------
module top();
  
  //Clock and reset signals
  logic presetn;
  logic pclk;
  
  initial begin
    presetn = 0;
    #10 presetn = 1;
  end
  
  //Instantiate virtual interface
  apb_if inf(.pclk(pclk),.presetn(presetn));
  
  //DUT instantiation
  apb_slave#(.AW(`AW),.DW(`DW))
  dut(
    .pclk(inf.pclk),
    .presetn(inf.presetn),
    .transfer(inf.trasnfer),
    .READ_WRITE(inf.READ_WRITE),
    .apb_write_paddr(inf.apb_write_paddr),
    .apb_write_data(inf.apb_write_data),
    .apb_read_paddr(inf.apb_read_paddr)
    .apb_read_data_out(inf.apb_read_data_out)
  );
  
  //Clock generation
  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk
  end

  initial begin
   `uvm_config_db#(virtual apb_if)::set(null, "*", "vif",inf);
  end
  
  //Start the UVM test
  initial begin
    run_test();
  end
endmodule



