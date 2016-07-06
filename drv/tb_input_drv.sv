//--------------------------------------------------
//File:         tb_input_drv.sv
//Description:  T2R3 Input Driver
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class input_drv extends uvm_driver #(img_pkt);

  `uvm_component_utils(input_drv)

  //interface
  virtual cibus_if vif;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual cibus_if)::get(this, "", "cibus", vif))
      `uvm_fatal("IN_DRV", "Unable to Acquire Input Interface!")
    `uvm_info("IN_DRV", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task reset();
  extern virtual task get_and_drive();
  extern virtual task send_pkt(img_pkt pkt);

endclass

task input_drv::run_phase(uvm_phase phase);
  fork
    reset();
    get_and_drive();
  join
endtask

task input_drv::reset();
  forever begin
    @(posedge vif.s_clk);
    if(vif.rst_n == 1'b 0) begin
      vif.ci_valid <= 1'b 0;
      vif.ci_data  <= 128'b 0;
      vif.ci_end   <= 1'b 0;
    end
  end
endtask

task input_drv::get_and_drive();
  forever begin
    @(posedge vif.s_clk);
    if(vif.rst_n == 1'b 1) begin
      img_pkt pkt;
      seq_item_port.get_next_item(pkt);
      send_pkt(pkt);
      seq_item_port.item_done();
    end
  end
endtask

task input_drv::send_pkt(img_pkt pkt);
  //send pkt
  for(int i = 0; i < 2 + pkt.img_body.size() + pkt.z_body.size(); i++) begin
    vif.ci_valid <= 1'b 1;
    if(i < 2)
      vif.ci_data <= pkt.header[i];
    else if (i >= 2 && i < 2 + pkt.img_body.size())
      vif.ci_data <= pkt.img_body[i-2];
    else
      vif.ci_data <= pkt.z_body[i-2-pkt.img_body.size()];
    do begin
      @(posedge vif.s_clk);
    end
    while(vif.ci_busy == 1'b 1);
  end
  //send end
  vif.ci_valid <= 1'b 0;
  vif.ci_end   <= 1'b 1;
  do begin
    @(posedge vif.s_clk);
  end
  while(vif.ci_busy == 1'b 1);
  vif.ci_end   <= 1'b 0;
endtask
