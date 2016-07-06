//--------------------------------------------------
//File:         tb_yif.sv
//Description:  T2R3 Y Bus Interface
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160607      Jiemin        Creation
//--------------------------------------------------

interface ybus_if(input bit s_clk,
                  input bit rst_n);

    logic         y_tsp;
    logic [31:4]  y_addr;
    logic [127:0] y_data;

endinterface    
