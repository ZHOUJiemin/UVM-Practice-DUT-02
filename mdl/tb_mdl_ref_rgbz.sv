//--------------------------------------------------
//File:         tb_mdl_ref_rgbz.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160623      Jiemin        Creation
//--------------------------------------------------

function void tb_mdl::ref_rgb_z(ci_beat data, bit [7:0] zdata);
  static int img_count = 0;
  y_beat tmp;
  if(img_count < 192) begin
    if(z_proc == 2'b 01)
      if(img_count%3 == 0) begin
        tmp = {data[127:104], zdata, data[103:80], zdata, data[79:56], zdata, data[55:32], zdata, data[31:8], zdata, data[7:0], 88'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%3 == 1) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {168'b 0, data[127:112], zdata, data[111:88], zdata, data[87:64], zdata};
        exp_q.push_back(tmp);
        tmp = {data[63:40], zdata, data[39:16], zdata, data[15:0], 176'b 0};
        exp_q.push_front(tmp);
      end
      else begin
        tmp = exp_q.pop_front();
        tmp = tmp | {80'b 0, data[127:120], zdata, data[119:96], zdata, data[95:72], zdata, data[71:48], zdata, data[47:24],zdata, data[23:0], zdata};
        exp_q.push_back(tmp);
      end
    else
      if(img_count%3 == 0) begin
        tmp = {data[127:104], 8'b 0, data[103:80], 8'b 0, data[79:56], 8'b 0, data[55:32], 8'b 0, data[31:8], 8'b 0, data[7:0], 88'b 0};
        exp_q.push_front(tmp);
      end
      else if(img_count%3 == 1) begin
        tmp = exp_q.pop_front();
        tmp = tmp | {168'b 0, data[127:112], 8'b 0, data[111:88], 8'b 0, data[87:64], 8'b 0};
        exp_q.push_back(tmp);
        tmp = {data[63:40], 8'b 0, data[39:16], 8'b 0, data[15:0], 176'b 0};
        exp_q.push_front(tmp);
      end
      else begin
        tmp = exp_q.pop_front();
        tmp = tmp | {80'b 0, data[127:120], 8'b 0, data[119:96], 8'b 0, data[95:72], 8'b 0, data[71:48], 8'b 0, data[47:24],8'b 0, data[23:0], 8'b 0};
        exp_q.push_back(tmp);
      end
  end
  else begin
    if(z_proc == 2'b 00) begin
      tmp = exp_q.pop_front();
      tmp = tmp | {24'b 0, data[127:120], 24'b 0, data[119:112], 24'b 0, data[111:104], 24'b 0, data[103:96], 24'b 0, data[95:88], 24'b 0, data[87:80], 24'b 0, data[79:72], 24'b 0, data[71:64]};
      exp_q.push_back(tmp);
      tmp = exp_q.pop_front();
      tmp = tmp | {24'b 0, data[63:56], 24'b 0, data[55:48], 24'b 0, data[47:40], 24'b 0, data[39:32], 24'b 0, data[31:24], 24'b 0, data[23:16], 24'b 0, data[15:8], 24'b 0, data[7:0]};
      exp_q.push_back(tmp);
    end
  end
  img_count++;
  if(img_count == 256) begin
    img_count = 0;
    ->data_collected;
  end
  
endfunction
