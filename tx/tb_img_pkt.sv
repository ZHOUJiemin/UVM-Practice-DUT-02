//--------------------------------------------------
//File:         tb_img_pkt.sv
//Description:  T2R3 Image Packet
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

class img_pkt extends uvm_sequence_item;

  `uvm_object_utils(img_pkt)

  //field
  rand img_type_enum img_type;
  rand z_exist_enum z_exist;
  rand ci_beat header[2];
  rand ci_beat img_body[];
  rand ci_beat z_body[];

  constraint img_body_size_c{(img_type == COMP1) -> (img_body.size() == 64);
                             (img_type == COMP3) -> (img_body.size() == 192);
                             (img_type == COMP4) -> (img_body.size() == 256);}

  constraint z_body_size_c  {(z_exist == WITH_Z) -> (z_body.size() == 64);
                             (z_exist == WO_Z)   -> (z_body.size() == 0);}

  constraint hdr_pkt_type_c {(header[0][126:124] == 3'b 001);}

  constraint hdr_img_type_c {(img_type == COMP1) -> (header[0][119:112] == 8'h 11);
                             (img_type == COMP3) -> (header[0][119:112] == 8'h 20);
                             (img_type == COMP4) -> (header[0][119:112] == 8'h 30);}

  //field automation
  // `uvm_object_utils_begin(img_pkt)
  //   `uvm_field_enum(img_type_enum, img_type, UVM_ALL_ON)
  //   `uvm_field_enum(z_exist_enum, z_exist, UVM_ALL_ON)
  //   `uvm_field_array_int(header, UVM_ALL_ON)
  //   `uvm_field_array_int(img_body, UVM_ALL_ON)
  //   `uvm_field_array_int(z_body, UVM_ALL_ON)
  // `uvm_object_utils_end

  //constructor
  function new(string name = "img_pkt");
    super.new(name);
  endfunction

endclass
