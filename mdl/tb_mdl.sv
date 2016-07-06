//--------------------------------------------------
//File:         tb_mdl.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160530      Jiemin        Creation
//--------------------------------------------------

class tb_mdl extends uvm_component;

  `uvm_component_utils(tb_mdl)

  uvm_blocking_get_port #(ci_beat) inagt2mdlp;
  uvm_blocking_put_port #(y_beat)  mdl2scbp;

  ci_beat input_img;
  y_beat  exp;
  y_beat  exp_q[$];

  //virtual interface
  virtual backdoor_if vif;

  //event
  event data_collected;

  //register
  bit         origin_with_z;
  bit [2:0]   img_comp_num;
  bit [1:0]   z_proc;
  bit [7:0]   z_data;
  bit         z_exist;
  bit [9:0]   tile_num;
  bit [2:0]   resize_ratio;
  bit [7:0]   pad_data;

  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    inagt2mdlp = new("inagt2mdlp", this);
    mdl2scbp   = new("mdl2scbp", this);
    uvm_config_db#(virtual backdoor_if) :: get(this, "", "backdoor", vif);
    `uvm_info("MDL", "Build Phase Completed!", UVM_LOW)
  endfunction

  //run_phase
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task read_reg();
  extern virtual task create_exp();
  extern virtual task send_exp();

  extern virtual function void ref_nd(ci_beat data);
  extern virtual function void ref_rgb(ci_beat data);
  extern virtual function void ref_cmyk(ci_beat data);

  extern virtual function void ref_nd_z(ci_beat data, bit [7:0] zdata);
  extern virtual function void ref_rgb_z(ci_beat data, bit [7:0] zdata);
  extern virtual function void ref_cmyk_z(ci_beat data, bit [7:0] zdata);

  extern virtual function void ref_nd_z_1_2(ci_beat data, bit [7:0] zdata, bit [2:0] resize_ratio);
  extern virtual function void ref_nd_pad(ci_beat data, bit [7:0] pad_data, bit [2:0] resize_ratio);

  extern virtual function ci_beat img_ave_cal(ci_beat data1, ci_beat data2);
  extern virtual function ci_beat z_ave_cal(ci_beat data1, ci_beat data2);

endclass

task tb_mdl::run_phase(uvm_phase phase);
  fork
    read_reg();
    create_exp();
    send_exp();
  join
endtask

task tb_mdl::read_reg();
  bit load_done = 0;
  while(!load_done) begin
    @(posedge vif.s_clk);
    if(vif.peek_enable()) begin
      origin_with_z = vif.peek_z_comp();
      img_comp_num = vif.peek_img_comp();
      z_proc = vif.peek_z_proc();
      z_data = vif.peek_z_data();
      tile_num = vif.peek_pagewidth();
      resize_ratio = vif.peek_resize_ratio();
      pad_data = vif.peek_pad_data();

      case (z_proc)
        2'b 00: z_exist = origin_with_z;
        2'b 01: z_exist = 1;
        2'b 10: z_exist = 0;
        default: z_exist = origin_with_z;
      endcase
      `uvm_info("MDL", "-----------------Register Setting Loaded-----------------", UVM_LOW)
      `uvm_info("MDL", $sformatf("------Z Data Comp             %d ------", origin_with_z), UVM_LOW)
      `uvm_info("MDL", $sformatf("------Image Data Comp         %d ------", img_comp_num), UVM_LOW)
      `uvm_info("MDL", $sformatf("------Z Proc                  %d ------", z_proc), UVM_LOW)
      `uvm_info("MDL", $sformatf("------Z Data                  %d ------", z_data), UVM_LOW)
      `uvm_info("MDL", $sformatf("------Packet Number           %d ------", tile_num), UVM_LOW)
      `uvm_info("MDL", $sformatf("------Resize Ratio            %d ------", resize_ratio), UVM_LOW)
      `uvm_info("MDL", "-----------------Register Setting Loaded-----------------", UVM_LOW)
      load_done = 1;
    end
  end
endtask

task tb_mdl::create_exp();
  int count = 0;
  forever begin
    inagt2mdlp.get(input_img);
    count ++;
    if(count > 2) begin
      if(z_exist) begin
        case (img_comp_num)
          3'b 001: begin
                    case (resize_ratio)
                      3'b 000: ref_nd_z(input_img, z_data);
                      3'b 001: ref_nd_z_1_2(input_img, z_data, resize_ratio);
                      default;
                    endcase
                   end
          3'b 011: ref_rgb_z(input_img, z_data);
          3'b 100: ref_cmyk_z(input_img, z_data);
          default;
        endcase
      end
      else begin
        case (img_comp_num)
          3'b 001: begin
                    case (resize_ratio)
                      3'b 000: ref_nd(input_img);
                      3'b 001: ref_nd_pad(input_img, pad_data, resize_ratio);
                      default;
                    endcase
                   end
          3'b 011: ref_rgb(input_img);
          3'b 100: ref_cmyk(input_img);
          default;
        endcase
      end
    end
    if(count == 64*(img_comp_num + z_exist) + 2)
      count = 0;
  end
endtask

task tb_mdl::send_exp();
  forever begin
    @data_collected;
    `uvm_info("MDL","---------------------------------------------------------------------",UVM_LOW)
    `uvm_info("MDL","                        Sending Expected Data                        ",UVM_LOW)
    `uvm_info("MDL","---------------------------------------------------------------------",UVM_LOW)
    while(exp_q.size()) begin
      exp = exp_q.pop_front();
      mdl2scbp.put(exp);
    end
    `uvm_info("MDL","---------------------------------------------------------------------",UVM_LOW)
    `uvm_info("MDL", "                      All Expected Data Sent!                       ",UVM_LOW)
    `uvm_info("MDL","---------------------------------------------------------------------",UVM_LOW)
    exp_q = {}; //clear queue
  end
endtask

//1/2 resize only
function ci_beat tb_mdl::img_ave_cal(ci_beat data1, ci_beat data2);
  bit [8:0] sum [16];
  for (int i = 0; i < 16; i++) begin
    sum[i] = data1[(127-8*i) -:8] + data2[(127-8*i) -:8];
  end
  img_ave_cal = {sum[0][8:1], sum[1][8:1], sum[2][8:1], sum[3][8:1], sum[4][8:1], sum[5][8:1], sum[6][8:1], sum[7][8:1],
                 sum[8][8:1], sum[9][8:1], sum[10][8:1], sum[11][8:1], sum[12][8:1], sum[13][8:1], sum[14][8:1], sum[15][8:1]};
endfunction

//1/2 resize only
function ci_beat tb_mdl::z_ave_cal(ci_beat data1, ci_beat data2);
  bit [7:0] sum [16];
  for (int i = 0; i < 16; i++) begin
    sum[i] = data1[(127-8*i) -:8] | data2[(127-8*i) -:8];
  end
  z_ave_cal = {sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7],
               sum[8], sum[9], sum[10], sum[11], sum[12], sum[13], sum[14], sum[15]};
endfunction
