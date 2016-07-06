//--------------------------------------------------
//File:         tb_ciif.sv
//Description:  T2R3 CI Bus Interface
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

interface cibus_if(input bit s_clk,
                   input bit rst_n);

  logic         ci_valid;
  logic         ci_busy;
  logic [127:0] ci_data;
  logic         ci_end;

endinterface
