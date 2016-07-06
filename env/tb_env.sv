//--------------------------------------------------
//File:         tb_env.sv
//Description:  T2R3 TB Environment
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class tb_env extends uvm_env;

  //register with uvm factory
  `uvm_component_utils(tb_env)

  //child components
  reg_agt     r_agt;    //agent for register setting
  input_agt   i_agt;    //agent for input image
  output_agt  o_agt;    //agent for output image
  tb_scb      scb;      //scoreboard
  tb_mdl      mdl;      //referenc model

  //fifo
  uvm_tlm_analysis_fifo #(ci_beat) inagt_mdl_fifo;
  uvm_tlm_analysis_fifo #(y_beat)  mdl_scb_fifo;
  uvm_tlm_analysis_fifo #(y_beat)  outagt_scb_fifo;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    inagt_mdl_fifo = new("inagt_mdl_fifo", this);
    mdl_scb_fifo = new("mdl_scb_fifo", this);
    outagt_scb_fifo = new("outagt_scb_fifo", this);
    uvm_config_db #(int) :: set(this, "r_agt", "is_active", UVM_ACTIVE);
    uvm_config_db #(int) :: set(this, "i_agt", "is_active", UVM_ACTIVE);
    r_agt = reg_agt::type_id::create("r_agt", this);
    i_agt = input_agt::type_id::create("i_agt", this);
    o_agt = output_agt::type_id::create("o_agt", this);
    scb   = tb_scb ::type_id::create("scb", this);
    mdl   = tb_mdl ::type_id::create("mdl", this);
    `uvm_info("ENV", "Build Phase Completed!", UVM_LOW)
  endfunction

  //connect phase
  virtual function void  connect_phase(uvm_phase phase);
    r_agt.mon.ap.connect(scb.aimp_reg);

    i_agt.mon.ap.connect(inagt_mdl_fifo.analysis_export);
    mdl.inagt2mdlp.connect(inagt_mdl_fifo.blocking_get_export);

    mdl.mdl2scbp.connect(mdl_scb_fifo.blocking_put_export);
    scb.mdl2scbp.connect(mdl_scb_fifo.blocking_get_export);

    o_agt.mon.ap.connect(outagt_scb_fifo.analysis_export);
    scb.outagt2scbp.connect(outagt_scb_fifo.blocking_get_export);

    `uvm_info("ENV", "Connect Phase Completed!", UVM_LOW)
    $display("----------------------------------------------------------------------------------");
  endfunction

endclass
