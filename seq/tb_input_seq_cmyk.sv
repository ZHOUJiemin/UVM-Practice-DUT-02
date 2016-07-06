//--------------------------------------------------
//File:         tb_input_seq_cmyk.sv
//Description:  T2R3 TB Input Sequence
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160610      Jiemin        Creation
//--------------------------------------------------

class input_seq_cmyk extends uvm_sequence #(img_pkt);

  `uvm_object_utils(input_seq_cmyk)
  img_pkt tx;
  int     pkt_num = 1;

  //constructor
  function new(string name = "input_seq");
    super.new(name);
  endfunction

  extern virtual task body();

endclass

task input_seq_cmyk::body();
  tx = new("tx");
  for(int i = 0; i < pkt_num; i ++) begin
    assert(tx.randomize() with {  tx.img_type == COMP4;
                                  tx.z_exist == WO_Z;});
    tx.header[0][75:64] = 12'b 0;
    tx.header[0][87:76] = 12'b 0;
    start_item(tx);
    finish_item(tx);
  end
endtask
