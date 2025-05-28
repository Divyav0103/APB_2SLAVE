class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)

  apb_env env;
  apb_sequence seq;
  
  function new(string name = "apb_test", uvm_component parent);
    super.new(name, parent);
  endfunction	
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
    seq = apb_sequence::type_id::create("seq", this);
  endfunction
 
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(env.a_agent.seqr);
    phase.drop_objection(this);
  endtask
endclass

class apb_write0_slave0 extends apb_test;

  `uvm_component_utils(apb_write0_slave0)

  apb_write0 write0_slave0;
    
  function new(string name = " apb_write0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write0_slave0 = apb_write0::type_id::create("write0_slave0",this);
  endfunction

  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   write0_slave0.start(env.a_agent.seqr);
   phase.drop_objection(this);
   phase.phase_done.set_drain_time(this, 30);
 endtask
endclass

class apb_write1_slave1 extends apb_test;

  `uvm_component_utils(apb_write1_slave1)

  apb_write1 write1_slave1;
    
  function new(string name = " apb_write1_slave1", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write1_slave1 = apb_write1::type_id::create("write1_slave1",this);
  endfunction

  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   write1_slave1.start(env.a_agent.seqr);
   phase.drop_objection(this);
   phase.phase_done.set_drain_time(this, 30);
 endtask
endclass


class apb_read0_slave0 extends apb_test;

  `uvm_component_utils(apb_read0_slave0)

  apb_read0 read0_slave0;
    
  function new(string name = " apb_read0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read0_slave0 = apb_read0::type_id::create("read0_slave0",this);
  endfunction

  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   read0_slave0.start(env.a_agent.seqr);
   phase.drop_objection(this);
   phase.phase_done.set_drain_time(this, 30);
 endtask
endclass

class apb_read1_slave1 extends apb_test;

  `uvm_component_utils(apb_read1_slave1)

  apb_read1 read1_slave1;
    
  function new(string name = " apb_read1_slave1", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read1_slave1 = apb_read1::type_id::create("read1_slave1",this);
  endfunction

  task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   read1_slave1.start(env.a_agent.seqr);
   phase.drop_objection(this);
   phase.phase_done.set_drain_time(this, 30);
 endtask
endclass

class apb_write_read0_slave0 extends apb_test;

  `uvm_component_utils(apb_write_read0_slave0)

  apb_write_read0 write_read0_slave0;
    
  function new(string name = " apb_write_read0_slave0", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_read0_slave0 = apb_write_read0::type_id::create("write_read0_slave0",this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    write_read0_slave0.start(env.a_agent.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
  endtask
endclass

class apb_write_read1_slave1 extends apb_test;

  `uvm_component_utils(apb_write_read1_slave1)

  apb_write_read1 write_read1_slave1;
    
  function new(string name = " apb_write_read1_slave1", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_read1_slave1 = apb_write_read1::type_id::create("write_read1_slave1",this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    write_read1_slave1.start(env.a_agent.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
  endtask
endclass

class apb_transfer_disable_test extends apb_test;
  `uvm_component_utils(apb_transfer_disable_test)

  apb_transfer_disable transfer_disable;

  function new(string name = "apn_transfer_disable_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     transfer_disable = apb_transfer_disable::type_id::create(" transfer_disable");
    `uvm_info("apb_transfer_disable","Inside build phase",UVM_HIGH);
  endfunction :build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat(5) begin
      transfer_disable_seq.start(env.a_agent.seqr);
    end
     #100;
    phase.drop_objection(this);
  endtask
endclass

class reg_test extends apb_test;
  `uvm_component_utils(reg_test)
  
   apb_write0 pkt1;
   apb_write1 pkt2;
   apb_read0  pkt3;
   apb_read1  pkt4;
   apb_write_read0 pkt5;
   apb_write_read1 pkt6;
   apb_transfer_disable pkt7;

  function new(string name = "reg_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    pkt1 = apb_write0::type_id::create("pkt1", this);
    pkt2 = apb_write1::type_id::create("pkt2", this);
    pkt3 = apb_read0::type_id::create("pkt3",this);
    pkt4 = apb_read1::type_id::create("pkt4", this);
    pkt5 = apb_write_read0::type_id::create("pkt5", this);
    pkt6 = apb_write_read1::type_id::create("pkt6", this);
    pkt7 = apb_transfer_disable::type_id::create("pkt7", this);
  endfunction

  virtual function void end_of_elaboration();
     uvm_top.print_topology();
  endfunction


  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    repeat(5)begin
    phase.raise_objection (this);
    pkt1.start(env.a_agent.seqr); 
    phase.drop_objection (this);
        end
    phase.phase_done.set_drain_time(this,100);

  repeat(5)begin
   phase.raise_objection (this);
   pkt2.start(env.a_agent.seqr); 
   phase.drop_objection (this);
      end
   phase.phase_done.set_drain_time(this,100);
    
 repeat(5)begin
  phase.raise_objection (this);
   pkt3.start(env.a_agent.seqr); 
   phase.drop_objection (this);
     end
   phase.phase_done.set_drain_time(this,100);
    

repeat(5)begin
    phase.raise_objection (this);
    pkt4.start(env.a_agent.seqr); 
   phase.drop_objection (this);
    end
   phase.phase_done.set_drain_time(this,100);
    

 repeat(5)begin
    phase.raise_objection (this);
    pkt5.start(env.a_agent.seqr); 
   phase.drop_objection (this);
     end
   phase.phase_done.set_drain_time(this,100);

    
 repeat(5)begin
    phase.raise_objection (this);
    pkt6.start(env.a_agent.seqr); 
   phase.drop_objection (this);
    end
   phase.phase_done.set_drain_time(this,100);
  endtask

   repeat(5)begin
    phase.raise_objection (this);
    pkt7.start(env.a_agent.seqr); 
   phase.drop_objection (this);
    end
   phase.phase_done.set_drain_time(this,100);
  endtask


endclass
