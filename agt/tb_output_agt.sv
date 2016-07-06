//--------------------------------------------------
//File:         tb_output_agt.sv
//Description:  T2R3 Output Agent
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class output_agt extends uvm_agent;

  `uvm_component_utils(output_agt)

  //child components
  output_mon  mon;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = output_mon::type_id::create("mon", this);
    `uvm_info("OUT_AGT","Build Phase Completed!", UVM_LOW)
  endfunction

endclass
