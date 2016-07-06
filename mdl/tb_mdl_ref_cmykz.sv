//--------------------------------------------------
//File:         tb_mdl_ref_cmykz.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160623      Jiemin        Creation
//--------------------------------------------------

function void tb_mdl::ref_cmyk_z(ci_beat data, bit [7:0] zdata);
  static int img_count = 0;
  y_beat tmp;
  if(img_count < 256) begin
    if(z_proc == 2'b 01) begin
      if(img_count%8 == 0) begin
        tmp = {data[127:96], zdata, data[95:64], zdata, data[63:32], zdata, data[31:0], zdata, 96'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 1) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {160'b 0, data[127:96], zdata, data[95:64], zdata, data[63:48]};
        exp_q.push_back(tmp);
        tmp = {data[47:32], zdata, data[31:0], zdata, 192'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 2) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {64'b 0, data[127:96], zdata, data[95:64], zdata, data[63:32], zdata, data[31:0], zdata, 32'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 3) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {224'b 0, data[127:96]};
        exp_q.push_back(tmp);
        tmp = {zdata, data[95:64], zdata, data[63:32], zdata, data[31:0], zdata, 128'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 4) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {128'b 0, data[127:96], zdata, data[95:64], zdata, data[63:32], zdata, data[31:24]};
        exp_q.push_back(tmp);
        tmp = {data[23:0], zdata, 224'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 5) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {32'b 0, data[127:96], zdata, data[95:64], zdata, data[63:32], zdata, data[31:0], zdata, 64'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 6) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {192'b 0, data[127:96], zdata, data[95:72]};
        exp_q.push_back(tmp);
        tmp = {data[71:64], zdata, data[63:32], zdata, data[31:0], zdata, 160'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 7) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {96'b 0, data[127:96], zdata, data[95:64], zdata, data[63:32], zdata, data[31:0], zdata};
        exp_q.push_back(tmp);
      end
    end
    else begin
      if(img_count%8 == 0) begin
        tmp = {data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0, 96'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 1) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {160'b 0, data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:48]};
        exp_q.push_back(tmp);
        tmp = {data[47:32], 8'b 0, data[31:0], 8'b 0, 192'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 2) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {64'b 0, data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0, 32'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 3) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {224'b 0, data[127:96]};
        exp_q.push_back(tmp);
        tmp = {8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0, 128'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 4) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {128'b 0, data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:24]};
        exp_q.push_back(tmp);
        tmp = {data[23:0], 8'b 0, 224'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 5) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {32'b 0, data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0, 64'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 6) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {192'b 0, data[127:96], 8'b 0, data[95:72]};
        exp_q.push_back(tmp);
        tmp = {data[71:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0, 160'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%8 == 7) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {96'b 0, data[127:96], 8'b 0, data[95:64], 8'b 0, data[63:32], 8'b 0, data[31:0], 8'b 0};
        exp_q.push_back(tmp);
      end
    end
  end
  else begin
    if(z_proc == 2'b 00) begin
      if(img_count%2 == 0) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {32'b 0, data[127:120], 32'b 0, data[119:112], 32'b 0, data[111:104], 32'b 0, data[103:96], 32'b 0, data[95:88], 32'b 0, data[87:80], 16'b 0};
        exp_q.push_back(tmp);
        tmp = exp_q.pop_front();
        tmp = tmp | {16'b 0, data[79:72], 32'b 0, data[71:64], 32'b 0, data[63:56], 32'b 0, data[55:48], 32'b 0, data[47:40], 32'b 0, data[39:32], 32'b 0};
        exp_q.push_back(tmp);
        tmp = exp_q.pop_front();
        tmp = tmp | {data[31:24], 32'b 0, data[23:16], 32'b 0, data[15:8], 32'b 0, data[7:0], 128'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%2 == 1) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {128'b 0, 32'b 0, data[127:120], 32'b 0, data[119:112], 32'b 0, data[111:104], 8'b 0};
        exp_q.push_back(tmp);
        tmp = exp_q.pop_front();
        tmp = tmp | {24'b 0, data[103:96], 32'b 0, data[95:88], 32'b 0, data[87:80], 32'b 0, data[79:72], 32'b 0, data[71:64], 32'b 0, data[63:56], 24'b 0};
        exp_q.push_back(tmp);
        tmp = exp_q.pop_front();
        tmp = tmp | {8'b 0, data[55:48], 32'b 0, data[47:40], 32'b 0, data[39:32], 32'b 0, data[31:24], 32'b 0, data[23:16], 32'b 0, data[15:8], 32'b 0, data[7:0]};
        exp_q.push_back(tmp);
      end
    end
  end
  img_count++;
  `uvm_info("MDL",$sformatf("Image_Count = %d", img_count), UVM_HIGH)
  if(img_count == 320) begin
    img_count = 0;
    ->data_collected;
  end
  
endfunction
