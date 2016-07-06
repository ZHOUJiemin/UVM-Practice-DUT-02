//--------------------------------------------------
//File:         tb_reg_sqr.sv
//Description:  T2R3 TB Register Sequencer
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class reg_sqr extends uvm_sequencer #(reg_tx);

  //register with the uvm factory
  `uvm_component_utils(reg_sqr)

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
