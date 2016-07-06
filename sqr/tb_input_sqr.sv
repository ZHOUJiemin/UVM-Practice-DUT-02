//--------------------------------------------------
//File:         tb_input_sqr.sv
//Description:  T2R3 Input Sequencer
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class input_sqr extends uvm_sequencer #(img_pkt);

  //register with the uvm factory
  `uvm_component_utils(input_sqr)

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
