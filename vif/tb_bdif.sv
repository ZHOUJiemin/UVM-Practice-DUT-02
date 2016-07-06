//--------------------------------------------------
//File:         tb_bdif.sv
//Description:  T2R3 TB Backdoor Interface
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160610      Jiemin        Creation
//--------------------------------------------------

interface backdoor_if(input s_clk,
                      input rst_n);

  function bit peek_z_comp( );
    peek_z_comp = tb_top.dut.reg_z_exist;
  endfunction

  function bit[2:0] peek_img_comp( );
    peek_img_comp = tb_top.dut.reg_img_comp_num;
  endfunction

  function bit[1:0] peek_z_proc( );
    peek_z_proc = tb_top.dut.reg_z_proc;
  endfunction

  function bit[7:0] peek_z_data( );
    peek_z_data = tb_top.dut.reg_z_data;
  endfunction

  function bit peek_enable( );
    peek_enable = tb_top.dut.reg_enable;
  endfunction

  function bit[9:0] peek_pagewidth();
    peek_pagewidth = tb_top.dut.reg_page_width;
  endfunction

  function bit[2:0] peek_resize_ratio();
    peek_resize_ratio = tb_top.dut.reg_resize_ratio;
  endfunction

  function bit[7:0] peek_pad_data();
    peek_pad_data = tb_top.dut.reg_pad_data;
  endfunction

endinterface
