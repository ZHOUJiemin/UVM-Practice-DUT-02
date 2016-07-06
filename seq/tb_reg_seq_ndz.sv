//--------------------------------------------------
//File:         tb_reg_seq_ndz.sv
//Description:  T2R3 TB Register Sequence
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160609      Jiemin        Creation
//--------------------------------------------------

class reg_seq_ndz extends uvm_sequence #(reg_tx);

  `uvm_object_utils(reg_seq_ndz)
  reg_tx  tx;

  //constructor
  function new(string name = "reg_seq_ndz");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task reg_seq_ndz::body();
    tx = new("tx");
    tx.tx_type = REG_WRITE;
    //page start addr
    tx.addr = 10'h 1;
    tx.data = 0;
    start_item(tx);
    finish_item(tx);
    //page width
    tx.addr = 10'h 2;
    tx.data = 32'd 32;
    start_item(tx);
    finish_item(tx);
    //page height
    tx.addr = 10'h 3;
    tx.data = 32'd 32;
    start_item(tx);
    finish_item(tx);
    //comp num
    tx.addr = 10'h 4;
    tx.data = 32'h 00000009;
    start_item(tx);
    finish_item(tx);
    //line pitch
    tx.addr = 10'h 5;
    tx.data = 32'd 64;
    start_item(tx);
    finish_item(tx);
    //int enable
    tx.addr = 10'h 7;
    tx.data = 32'h 80000007;
    start_item(tx);
    finish_item(tx);
    //z proc
    tx.addr = 10'h 8;
    tx.data = 32'b 0;
    start_item(tx);
    finish_item(tx);
    //resize
    tx.addr = 10'h 9;
    tx.data = 32'b 0;
    start_item(tx);
    finish_item(tx);
    //padding
    tx.addr = 10'h A;
    tx.data = 32'b 0;
    start_item(tx);
    finish_item(tx);
    //enable
    tx.addr = 10'h 0;
    tx.data = 32'h 80000000;
    start_item(tx);
    finish_item(tx);
endtask
