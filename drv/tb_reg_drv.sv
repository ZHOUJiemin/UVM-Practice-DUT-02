//--------------------------------------------------
//File:         tb_reg_drv.sv
//Description:  T2R3 TB Register Driver
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class reg_drv extends uvm_driver #(reg_tx);

  `uvm_component_utils(reg_drv)

  //interface
  virtual ubus_if vif;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual ubus_if) :: get(this, "", "ubus", vif))
      `uvm_fatal("REG_DRV", "Unable to Acquire Register Interface!")
    `uvm_info("REG_DRV", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task reset();
  extern virtual task get_and_drive();
  extern virtual task write_reg(reg_tx tx);
  extern virtual task read_reg(reg_tx tx);

endclass

task reg_drv::run_phase(uvm_phase phase);
  fork
    reset();
    get_and_drive();
  join
endtask

task reg_drv::reset();
  forever begin
    @(posedge vif.u_clk);
    if(vif.rst_n == 1'b 0) begin
      vif.cs    <= 1'b 0;
      vif.we    <= 1'b 0;
      vif.re    <= 1'b 0;
      vif.wdata <= 32'b 0;
      vif.addr  <= 10'b 0;
    end
  end
endtask

task reg_drv::get_and_drive();
  forever begin
    @(posedge vif.u_clk);
    if(vif.rst_n == 1'b 1) begin
      reg_tx tx;
      seq_item_port.get_next_item(tx);
      //display
      tx.display;
      if(tx.tx_type == REG_WRITE) begin
        `uvm_info("REG_DRV","Writing Register.",UVM_LOW)
        write_reg(tx);
      end
      else begin
        `uvm_info("REG_DRV","Reading Register.",UVM_LOW)
        read_reg(tx);
      end
      seq_item_port.item_done();
    end
  end
endtask

task reg_drv::write_reg(reg_tx tx);
  //drive write data
  // @(posedge vif.u_clk);
  vif.cs    <= 1'b 1;
  vif.we    <= 1'b 1;
  vif.wdata <= tx.data;
  vif.addr  <= tx.addr;
  //wait for wack
  do begin
    @(posedge vif.u_clk);
  end
  while(!vif.wack);
  //deassert we
  vif.we    <= 1'b 0;
endtask

task reg_drv::read_reg(reg_tx tx);
  //drive read data
  // @(posedge vif.u_clk);
  vif.cs    <= 1'b 1;
  vif.re    <= 1'b 1;
  vif.addr  <= tx.addr;
  //wait for rdv
  do begin
    @(posedge vif.u_clk);
  end
  while(!vif.rdv);
  //deassert re
  vif.re    <= 1'b 0;
endtask
