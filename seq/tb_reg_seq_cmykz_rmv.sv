//--------------------------------------------------
//File:         tb_reg_seq_cmykz_rmv.sv
//Description:  T2R3 TB Register Sequence
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160614      Jiemin        Creation
//--------------------------------------------------

class reg_seq_cmykz_rmv extends uvm_sequence #(reg_tx);

  `uvm_object_utils(reg_seq_cmykz_rmv)
  reg_tx  tx;

  //constructor
  function new(string name = "reg_seq_cmykz_rmv");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task reg_seq_cmykz_rmv::body();
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
    tx.data = 32'h 0000000C;
    start_item(tx);
    finish_item(tx);
    //line pitch
    tx.addr = 10'h 5;
    tx.data = 32'd 128;
    start_item(tx);
    finish_item(tx);
    //int enable
    tx.addr = 10'h 7;
    tx.data = 32'h 80000007;
    start_item(tx);
    finish_item(tx);
    //z proc
    tx.addr = 10'h 8;
    tx.data = 32'h 00000002;
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
