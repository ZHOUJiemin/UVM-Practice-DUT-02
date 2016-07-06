//--------------------------------------------------
//File:         tb_input_agt.sv
//Description:  T2R3 Input Agent
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class input_agt extends uvm_agent;

  `uvm_component_utils(input_agt)

  //child component
  input_sqr sqr;
  input_drv drv;
  input_mon mon;

  //is_active
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(uvm_active_passive_enum)::get(this,"","is_active",is_active);

    if(is_active == UVM_ACTIVE) begin
      sqr = input_sqr::type_id::create("sqr", this);
      drv = input_drv::type_id::create("drv", this);
    end
    mon = input_mon::type_id::create("mon", this);
    `uvm_info("IN_AGT", "Build Phase Completed!", UVM_LOW)
  endfunction

  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
    `uvm_info("IN_AGT", "Build Phase Completed!", UVM_LOW)
  endfunction

endclass
