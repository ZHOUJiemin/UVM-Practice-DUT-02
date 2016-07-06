//--------------------------------------------------
//File:         tb_reg_tx.sv
//Description:  T2R3 TB Register Transaction
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class reg_tx extends uvm_sequence_item;

    //field
    rand bit [11:2]           addr;
    rand bit [31:0]           data;
    is_write_not_read_enum    tx_type;

    //constraints
    constraint addr_c{ addr >= 1;
                       addr <= 12;}

   //field automation
   `uvm_object_utils_begin(reg_tx)
     `uvm_field_int(addr, UVM_ALL_ON)
     `uvm_field_int(data, UVM_ALL_ON)
     `uvm_field_enum(is_write_not_read_enum, tx_type, UVM_ALL_ON)
   `uvm_object_utils_end

    //constructor
    function new(string name = "reg_tx");
      super.new(name);
    endfunction

    //functions and tasks
    virtual function void display();
      if(tx_type == REG_WRITE)
        `uvm_info("REG_TX", $sformatf("[WrReg] Data = 0x%0h @ Addr = 0x%0h", data, ({addr,2'b 0} + 32'h d218_4000)) ,UVM_LOW)
      else if(tx_type == REG_READ)
        `uvm_info("REG_TX", $sformatf("[RdReg] Addr = 0x%0h", ({addr,2'b 0} + 32'h d218_4000)), UVM_LOW)
      else
        `uvm_error("REG_TX", "Illegal Register Transaction!")
    endfunction

endclass
