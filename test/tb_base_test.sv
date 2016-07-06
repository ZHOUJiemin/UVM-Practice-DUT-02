//--------------------------------------------------
//File:         tb_base_test.sv
//Description:  T2R3 TB Base Test
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  //child component
  tb_env env;

  //printer
  uvm_table_printer printer;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = tb_env::type_id::create("env", this);
    printer = new();
    printer.knobs.depth = -1;
  endfunction

  extern virtual task run_phase(uvm_phase phase);

endclass

task base_test::run_phase(uvm_phase phase);
  reg_seq_nd seq;
  input_seq_nd seq2;
  phase.phase_done.set_drain_time(this, 10000);
  phase.raise_objection(this);
  seq = reg_seq_nd::type_id::create("seq");
  seq.start(env.r_agt.sqr);
  `uvm_info("TEST","---------------------------------------------------------------------",UVM_LOW)
  `uvm_info("TEST","                       REGISTER SETTING DONE                         ",UVM_LOW)
  `uvm_info("TEST","---------------------------------------------------------------------",UVM_LOW)
  #100;
  seq2 = input_seq_nd::type_id::create("seq2");
  seq2.start(env.i_agt.sqr);
  phase.drop_objection(this);
endtask
