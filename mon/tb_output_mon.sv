//--------------------------------------------------
//File:         tb_output_mon.sv
//Description:  T2R3 Output Monitor
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class output_mon extends uvm_monitor;

  `uvm_component_utils(output_mon)

  //variable
  bit recieve_data;

  //tranx
  y_beat collected_tx;
  y_beat cloned_tx;

  //interface
  virtual ybus_if vif;

  //analysis port
  uvm_analysis_port #(y_beat) ap;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if(!uvm_config_db#(virtual ybus_if)::get(this, "", "ybus", vif))
      `uvm_fatal("OUT_MON", "Unable to Acquire Input Interface")
    `uvm_info("OUT_MON", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task detect_tsp();
  extern virtual task collect_data();

endclass

task output_mon::run_phase(uvm_phase phase);
  fork
    detect_tsp();
    collect_data();
  join
endtask

task output_mon::detect_tsp();
  forever begin
    @(posedge vif.s_clk);
    if(vif.y_tsp == 1'b 1) begin
      recieve_data = 1'b 1;
      @(posedge vif.s_clk);
    end
    else
      recieve_data = 1'b 0;
  end
endtask

task output_mon::collect_data();
  bit upper_not_lower = 1'b 1;
  forever begin
    @(posedge vif.s_clk);
    if(recieve_data) begin
      if(upper_not_lower) begin
        collected_tx[255:128] = vif.y_data;
        upper_not_lower = 1'b 0;
      end
      else begin
        collected_tx[127:0]   = vif.y_data;
        upper_not_lower = 1'b 1;
        cloned_tx = collected_tx;
        `uvm_info("OUT_MON", "Output Tx Collected", UVM_HIGH)
        ap.write(cloned_tx);
      end
    end
  end
endtask
