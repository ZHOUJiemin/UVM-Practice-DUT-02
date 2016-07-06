//--------------------------------------------------
//File:         tb_pkg.sv
//Description:  T2R3 TB Package
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

`ifndef _TB_PKG_
`define _TB_PKG_

`include "uvm_macros.svh"

    package tb_pkg;
      //import uvm package
      import uvm_pkg::*;

      //user defined type
      typedef enum {REG_WRITE, REG_READ}  is_write_not_read_enum;
      typedef enum {COMP1, COMP3, COMP4} img_type_enum;
      typedef enum {WITH_Z, WO_Z} z_exist_enum;
      typedef bit [127:0] ci_beat;
      typedef bit [255:0] y_beat;

      `include "./tb/tx/tb_reg_tx.sv"
      `include "./tb/tx/tb_img_pkt.sv"

      `include "./tb/seq/tb_reg_seq_nd.sv"
      `include "./tb/seq/tb_reg_seq_nd_1_2_rsz_pad.sv"
      `include "./tb/seq/tb_reg_seq_ndz.sv"
      `include "./tb/seq/tb_reg_seq_ndz_1_2_rsz.sv"
      `include "./tb/seq/tb_reg_seq_rgb.sv"
      `include "./tb/seq/tb_reg_seq_rgbz.sv"
      `include "./tb/seq/tb_reg_seq_cmyk.sv"
      `include "./tb/seq/tb_reg_seq_cmykz.sv"
      `include "./tb/seq/tb_reg_seq_cmykz_apd.sv"
      `include "./tb/seq/tb_reg_seq_cmykz_rmv.sv"
      `include "./tb/seq/tb_reg_seq_cmykz_2_pkt.sv"

      `include "./tb/seq/tb_input_seq_nd.sv"
      `include "./tb/seq/tb_input_seq_ndz.sv"
      `include "./tb/seq/tb_input_seq_rgb.sv"
      `include "./tb/seq/tb_input_seq_rgbz.sv"
      `include "./tb/seq/tb_input_seq_cmyk.sv"
      `include "./tb/seq/tb_input_seq_cmykz.sv"

      `include "./tb/drv/tb_reg_drv.sv"
      `include "./tb/mon/tb_reg_mon.sv"
      `include "./tb/sqr/tb_reg_sqr.sv"

      `include "./tb/drv/tb_input_drv.sv"
      `include "./tb/mon/tb_input_mon.sv"
      `include "./tb/sqr/tb_input_sqr.sv"

      `include "./tb/mon/tb_output_mon.sv"

      `include "./tb/agt/tb_reg_agt.sv"
      `include "./tb/agt/tb_input_agt.sv"
      `include "./tb/agt/tb_output_agt.sv"

      `include "./tb/scb/tb_scb.sv"

      `include "./tb/mdl/tb_mdl.sv"
      `include "./tb/mdl/tb_mdl_ref_nd.sv"
      `include "./tb/mdl/tb_mdl_ref_ndz.sv"
      `include "./tb/mdl/tb_mdl_ref_rgb.sv"
      `include "./tb/mdl/tb_mdl_ref_rgbz.sv"
      `include "./tb/mdl/tb_mdl_ref_cmyk.sv"
      `include "./tb/mdl/tb_mdl_ref_cmykz.sv"
      `include "./tb/mdl/tb_mdl_ref_ndz_1_2.sv"
      `include "./tb/mdl/tb_mdl_ref_nd_pad.sv"

      `include "./tb/env/tb_env.sv"

      `include "./tb/test/tb_base_test.sv"
      `include "./tb/test/tb_test_rgb_no_resize.sv"
      `include "./tb/test/tb_test_cmyk_no_resize.sv"
      `include "./tb/test/tb_test_ndz_no_resize.sv"
      `include "./tb/test/tb_test_rgbz_no_resize.sv"
      `include "./tb/test/tb_test_cmykz_no_resize.sv"
      `include "./tb/test/tb_test_cmykz_apd_no_resize.sv"
      `include "./tb/test/tb_test_cmykz_rmv_no_resize.sv"
      `include "./tb/test/tb_test_cmykz_no_resize_2_pkt.sv"
      `include "./tb/test/tb_test_nd_1_2_resize_1_pkt.sv"
      `include "./tb/test/tb_test_ndz_1_2_resize_2_pkt.sv"

    endpackage

`endif
