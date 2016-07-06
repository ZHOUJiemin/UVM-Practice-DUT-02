//--------------------------------------------------
//File:         tb_top.sv
//Description:  T2R3 TB Top
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------
`include "./tb/tb_pkg.sv"

`define HALF_CLOCK_CYCLE 5
`define RESET_RELEASE    25

module tb_top ();

  timeunit 1ns;
  timeprecision 100ps;

  import uvm_pkg::*;
  import tb_pkg::*;

  bit s_clk;
  bit rst_n;

  //clock gen
  initial begin
    s_clk = 1'b 0;
    forever
      #`HALF_CLOCK_CYCLE s_clk = ~ s_clk;
  end

  //reset gen
  initial begin
    rst_n = 1'b 0;
    #`RESET_RELEASE rst_n = 1'b 1;
  end

  //dut
  ubus_if          ubus(.u_clk(s_clk),
                        .rst_n(rst_n));

  cibus_if         cibus(.s_clk(s_clk),
                         .rst_n(rst_n));

  ybus_if          ybus(.s_clk(s_clk),
                        .rst_n(rst_n));

  backdoor_if      backdoor(.s_clk(s_clk),
                            .rst_n(rst_n));

  o_ptg_m_t2r3_top dut(//system
                       .s_clk(s_clk),
                       .rst_n(rst_n),
                       //U Bus
                       .uT2r3Cs(ubus.cs),
                       .uT2r3Addr(ubus.addr),
                       .uT2r3We(ubus.we),
                       .uT2r3DataWr(ubus.wdata),
                       .uT2r3Wack(ubus.wack),
                       .uT2r3Re(ubus.re),
                       .uT2r3DataRd(ubus.rdata),
                       .uT2r3Rdv(ubus.rdv),
                       //Ci Bus
                       .cisT2r3Data(cibus.ci_data),
                       .cisT2r3Valid(cibus.ci_valid),
                       .cisT2r3End(cibus.ci_end),
                       .cisT2r3Busy(cibus.ci_busy),
                       //Y Bus
                       .ymT2r3Tsp(ybus.y_tsp),
                       .ymT2r3Addrp(ybus.y_addr),
                       .ymT2r3Midp(),
                       .ymT2r3RdNotWr(),
                       .ymT2r3InstNotData(),
                       .ymT2r3OneNotTwo(),
                       .ymT2r3RdByteenp(),
                       .ymT2r3Lockp(),
                       .ymT2r3WrDatap(ybus.y_data),
                       .ymT2r3WrByteenp(),
                       .ymT2r3SnoopMaskp(),
                       .ymT2r3Srdyp(1'b 1),
                       .ymT2r3Rsp(1'b 0),
                       .ymT2r3Rmidp(4'b 0),
                       .ymT2r3RdDatap(128'b 0),
                       .ymT2r3RdErrorp(1'b 0),
                       //Interrupt
                       .intT2r3());

  //test
  initial begin
      //set interface
      uvm_config_db #(virtual ubus_if) :: set(uvm_root::get(), "*", "ubus", ubus);
      uvm_config_db #(virtual cibus_if):: set(uvm_root::get(), "*", "cibus",cibus);
      uvm_config_db #(virtual ybus_if) :: set(uvm_root::get(), "*", "ybus", ybus);
      uvm_config_db #(virtual backdoor_if) :: set(uvm_root::get(), "*", "backdoor", backdoor);
      //start test
      run_test();
  end

endmodule // tb_top
