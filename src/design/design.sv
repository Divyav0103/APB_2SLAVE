module apb_dut(
    input  logic        read_write,         // 0 = Write, 1 = Read
    input  logic        transfer,           // Transfer signal
    input  logic [7:0]  apb_write_paddr,    // Write address
    input  logic [7:0]  apb_write_data,     // Data to write
    input  logic [7:0]  apb_read_paddr,     // Read address
    output logic [7:0]  apb_read_data_out   // Data output
);
 
  // Internal memory (256 x 8-bit)
  logic [7:0] mem [0:255];
 
  always@(*) begin
    apb_read_data_out = 8'h00; // Default output
    if (transfer) begin
      if (read_write) begin
        // Read operation
        apb_read_data_out = mem[apb_read_paddr];
      end else begin
        // Write operation
        mem[apb_write_paddr] = apb_write_data;
      end
    end
  end
 
endmodule
