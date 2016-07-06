//--------------------------------------------------
//File:         tb_reg_drv.sv
//Description:  T2R3 TB Register Monitor
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class reg_mon extends uvm_monitor;

  `uvm_component_utils(reg_mon)

  //tranx
  reg_tx  collected_tx;
  reg_tx  cloned_tx;

  //interface
  virtual ubus_if vif;

  //analysis port
  uvm_analysis_port #(reg_tx) ap;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    collected_tx = new("collected_tx");
    ap = new("ap", this);
    if(!uvm_config_db #(virtual ubus_if) :: get(this, "", "ubus", vif))
      `uvm_fatal("REG_MON", "Unable to Acquire Register Interface!")
    `uvm_info("REG_MON", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task collect_data();

endclass

task reg_mon::run_phase(uvm_phase phase);
  fork
    collect_data();
  join
endtask

task reg_mon::collect_data();
  forever begin
    @(posedge vif.u_clk);
    if(vif.cs == 1'b 1 & vif.we == 1'b 1) begin //write tx
      //collect tranx
      collected_tx.tx_type = REG_WRITE;
      collected_tx.addr    = vif.addr;
      collected_tx.data    = vif.wdata;
      //wait for wack
      do begin
        @(posedge vif.u_clk);
      end
      while(!vif.wack);
      //send tx
      $cast(cloned_tx, collected_tx.clone());
      `uvm_info("REG_MON", "Write Tx Collected" ,UVM_LOW)
      // cloned_tx.display;
      ap.write(cloned_tx);
    end
    else if(vif.cs == 1'b 1 & vif.re == 1'b 1) begin//read tx
      //collect tranx part 1
      collected_tx.tx_type = REG_READ;
      collected_tx.addr    = vif.addr;
      //wait for rdv
      do begin
        @(posedge vif.u_clk);
      end
      while(!vif.rdv);
      //collect tranx part 2
      collected_tx.data    = vif.rdata;
      //send tx
      $cast(cloned_tx, collected_tx.clone());
      `uvm_info("REG_MON", "Read Tx Collected" ,UVM_LOW)
      // cloned_tx.display;
      ap.write(cloned_tx);
    end
  end
endtask
