//--------------------------------------------------
//File:         tb_scb.sv
//Description:  T2R3 TB Scoreboard
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------
class tb_scb extends uvm_scoreboard;

  `uvm_component_utils(tb_scb)

  uvm_analysis_imp #(reg_tx, tb_scb) aimp_reg;
  uvm_blocking_get_port #(y_beat) mdl2scbp;
  uvm_blocking_get_port #(y_beat) outagt2scbp;

  //tx queue for register
  reg_tx  wr_q[$];
  reg_tx  rd_q[$];
  reg_tx  wr_tx;
  reg_tx  rd_tx;

  // ci_beat input_q[$];
  // ci_beat output_q[$];
  y_beat img_exp;
  y_beat img_act;

  //event
  event reg_read_done;
  // event img_read_done;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aimp_reg = new("aimp_reg", this);
    mdl2scbp = new("mdl2scbp", this);
    outagt2scbp = new("outagt2scbp", this);
    `uvm_info("SCB", "Build Phase Completed!", UVM_LOW)
  endfunction

  extern virtual function bit [31:0] write_mask (bit [11:2] addr);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task reg_act_vs_exp();
  extern virtual task img_act_vs_exp();

  extern virtual function void write(reg_tx tx);
  // extern virtual function void write_input(ci_beat tx);
  // extern virtual function void write_output(y_beat tx);

endclass

function void tb_scb::write(reg_tx tx);
  if(tx.tx_type == REG_WRITE) begin
    // $display("Write");
    tx.display();
    wr_q.push_back(tx);
  end
  else begin
    // $display("Read");
    tx.display();
    rd_q.push_back(tx);
    -> reg_read_done;
  end
endfunction

function bit [31:0] tb_scb::write_mask(bit [11:2] addr);
  case (addr)
    10'h 0: write_mask = {31'b 0, 1'b 1};                               //enable
    10'h 1: write_mask = {{27{1'b 1}}, 5'b 0};                          //page start addr
    10'h 2: write_mask = {17'b 0, {10{1'b 1}}, 5'b 0};                  //page width
    10'h 3: write_mask = {17'b 0, {10{1'b 1}}, 5'b 0};                  //page height
    10'h 4: write_mask = {28'b 0, {4{1'b 1}}};                          //comp num
    10'h 5: write_mask = {14'b 0, {18{1'b 1}}};                         //line pitch
    10'h 6: write_mask = 32'b 0;                                        //int status
    10'h 7: write_mask = {1'b 1, 28'b 0, {3{1'b 1}}};                   //int enable
    10'h 8: write_mask = {16'b 0, {8{1'b 1}}, 6'b 0, {2{1'b 1}}};       //z proc
    10'h 9: write_mask = {29'b 0, {3{1'b 1}}};                          //resize
    10'h a: write_mask = {24'b 0, {8{1'b 1}}};                          //padding
    10'h b: write_mask = 32'b 0;                                        //pkt ID X
    10'h c: write_mask = 32'b 0;                                        //pkt ID Y
    default: write_mask = 32'b 0;
  endcase
endfunction

task tb_scb::run_phase(uvm_phase phase);
  fork
    reg_act_vs_exp();
    img_act_vs_exp();
  join
endtask

task tb_scb::reg_act_vs_exp();
  forever begin
    @reg_read_done;
    if(rd_q.size()) begin
      wr_tx = wr_q.pop_front();
      rd_tx = rd_q.pop_front();
      // $display("mask is %h", write_mask(wr_tx.addr));
      if(wr_tx.addr == rd_tx.addr & ((write_mask(wr_tx.addr) & wr_tx.data) == rd_tx.data))
        `uvm_info("SCB", $sformatf("COMP OK! Data = 0x%0h, Address = 0x%0h\n", rd_tx.data, rd_tx.addr) ,UVM_LOW)
      else
        `uvm_error("SCB", $sformatf("COMP NG! Exp = 0x%0h, Act = 0x%0h, Address = 0x%0h\n", (write_mask(wr_tx.addr) & wr_tx.data), rd_tx.data, rd_tx.addr))
    end
  end
endtask

task tb_scb::img_act_vs_exp();
  forever begin
    outagt2scbp.get(img_act);
    `uvm_info("SCB", "Actual Data Ricieved!", UVM_MEDIUM)
    mdl2scbp.get(img_exp);
    `uvm_info("SCB", "Expected Data Recieved!", UVM_MEDIUM)
    if(img_exp == img_act) begin
      `uvm_info("SCB", $sformatf("COMP OK! Exp = 0x%32h, Act = 0x%32h", img_exp[255:128], img_act[255:128]),UVM_LOW)
      `uvm_info("SCB", $sformatf("COMP OK! Exp = 0x%32h, Act = 0x%32h", img_exp[127:0], img_act[127:0]),UVM_LOW)
    end
    else begin
      `uvm_error("SCB", $sformatf("COMP NG! Exp = 0x%32h, Act = 0x%32h", img_exp[255:128], img_act[255:128]))
      `uvm_error("SCB", $sformatf("COMP NG! Exp = 0x%32h, Act = 0x%32h", img_exp[127:0], img_act[127:0]))
    end
  end
endtask
