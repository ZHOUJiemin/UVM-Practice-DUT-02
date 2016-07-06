//--------------------------------------------------
//File:         tb_reg_agt.sv
//Description:  T2R3 TB Register Agent
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class reg_agt extends uvm_agent;

  `uvm_component_utils(reg_agt)

  //child components
  reg_sqr  sqr;
  reg_drv  drv;
  reg_mon  mon;

  //is acitve
  protected uvm_active_passive_enum is_active = UVM_ACTIVE;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(uvm_active_passive_enum)::get(this, "", "is_active", is_active);

    if(is_active == UVM_ACTIVE) begin
      sqr = reg_sqr::type_id::create("sqr", this);
      drv = reg_drv::type_id::create("drv", this);
    end
    mon = reg_mon::type_id::create("mon", this);
    `uvm_info("REG_AGT","Build Phase Completed!", UVM_LOW)
  endfunction

  //connect pahse
  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
    `uvm_info("REG_AGT","Connect Phase Completed!", UVM_LOW)
  endfunction

endclass
