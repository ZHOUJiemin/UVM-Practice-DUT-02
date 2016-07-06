//--------------------------------------------------
//File:         tb_test_ndz_no_resize.sv
//Description:  T2R3 TB Test 1 Comp wit Z
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160610      Jiemin        Creation
//--------------------------------------------------

class test_ndz extends base_test;

  `uvm_component_utils(test_ndz)

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  extern virtual task run_phase(uvm_phase phase);

endclass

task test_ndz::run_phase(uvm_phase phase);
  reg_seq_ndz seq;
  input_seq_ndz seq2;
  phase.phase_done.set_drain_time(this, 10000);
  phase.raise_objection(this);
  seq = reg_seq_ndz::type_id::create("seq");
  seq.start(env.r_agt.sqr);
  `uvm_info("TEST","---------------------------------------------------------------------",UVM_LOW)
  `uvm_info("TEST","                       REGISTER SETTING DONE                         ",UVM_LOW)
  `uvm_info("TEST","---------------------------------------------------------------------",UVM_LOW)
  #100;
  seq2 = input_seq_ndz::type_id::create("seq2");
  seq2.start(env.i_agt.sqr);
  phase.drop_objection(this);
endtask
