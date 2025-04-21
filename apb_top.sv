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
    .pclk(inf.pclk),
    .presetn(inf.presetn),
    .transfer(inf.trasnfer),
    .READ_WRITE(inf.READ_WRITE),
    .apb_write_paddr(inf.apb_write_paddr),
    .apb_write_data(inf.apb_write_data),
    .apb_read_paddr(inf.apb_read_paddr)
    .apb_read_data_out(inf.apb_read_data_out)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    pclk = 0;
    forever #5 pclk = ~pclk
  end
  
  initial begin
    run_test();
  end
endmodule
