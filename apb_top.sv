module top();
  
  logic presetn;
  logic pclk;
  
  initial begin
    presetn = 0;
    #10 presetn = 1;
  end
  
  //interface instantiation
  apb_if inf(.pclk(pclk),.presetn(presetn));
  
  //DUT instantiation
  apb_slave#(.AW(`AW),.DW(`DW))
  dut(
    .transfer(inf.trasnfer),
    .READ_WRITE(inf.READ_WRITE),
    .apb_write_paddr(inf.apb_write_paddr),
    .apb_write_data(inf.apb_write_data),
    .apb_read_paddr(inf.apb_read_paddr)
    .apb_read_);
  
  initial begin
    uvm_config_db#(virtual apb_if)::set(null,"*","vif", inf);
    
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    run_test();
  end
endmodule
