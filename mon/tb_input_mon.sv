//--------------------------------------------------
//File:         tb_input_mon.sv
//Description:  T2R3 Input Monitor
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class input_mon extends uvm_monitor;

  `uvm_component_utils(input_mon)

  //tranx
  ci_beat collected_tx;
  ci_beat cloned_tx;

  //interface
  virtual cibus_if vif;

  //analysis port
  uvm_analysis_port #(ci_beat) ap;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if(!uvm_config_db#(virtual cibus_if)::get(this, "", "cibus", vif))
      `uvm_fatal("IN_MON", "Unable to Acquire Input Interface")
    `uvm_info("IN_MON", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task collect_data();

endclass

task input_mon::run_phase(uvm_phase phase);
  fork
    collect_data();
  join
endtask

task input_mon::collect_data();
  forever begin
    @(posedge vif.s_clk);
    if(vif.ci_valid == 1'b 1 & vif.ci_busy == 1'b 0) begin
      collected_tx = vif.ci_data;
      cloned_tx = collected_tx;
      `uvm_info("IN_MON", "Input Tx Collected", UVM_HIGH)
      ap.write(cloned_tx);
    end
  end
endtask
