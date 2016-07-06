//--------------------------------------------------
//File:         tb_input_seq_rgb.sv
//Description:  T2R3 TB Input Sequence
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160608      Jiemin        Creation
//--------------------------------------------------

class input_seq_rgb extends uvm_sequence #(img_pkt);

  `uvm_object_utils(input_seq_rgb)
  img_pkt tx;

  //constructor
  function new(string name = "input_seq_rgb");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task input_seq_rgb::body();
  tx = new("tx");
  assert(tx.randomize() with {  tx.img_type == COMP3;
                                tx.z_exist == WO_Z;});
  tx.header[0][75:64] = 12'b 0;
  tx.header[0][87:76] = 12'b 0;
  start_item(tx);
  finish_item(tx);
endtask
