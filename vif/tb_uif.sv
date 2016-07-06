//--------------------------------------------------
//File:         tb_uif.sv
//Description:  T2R3 U Bus Interface
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

interface ubus_if(input bit u_clk,
                  input bit rst_n);

    logic [11:2] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;
    logic        we;
    logic        wack;
    logic        re;
    logic        rdv;
    logic        cs;

endinterface
