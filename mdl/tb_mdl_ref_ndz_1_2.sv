//--------------------------------------------------
//File:         tb_mdl_ref_ndz_1_2.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160623      Jiemin        Creation
//20160623      Jiemin        Added data padding
//--------------------------------------------------

function void tb_mdl::ref_nd_z_1_2(ci_beat data, bit [7:0] zdata, bit [2:0] resize_ratio);
  static int img_count = 0;
  y_beat tmp1;
  y_beat tmp2;
  y_beat tmp3;

  if(img_count < 64) begin
    if(z_proc == 2'b 01) begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = img_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = img_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = {tmp1[127:120], zdata, tmp1[119:112], zdata, tmp1[111:104], zdata, tmp1[103:96], zdata, tmp1[95:88], zdata, tmp1[87:80], zdata, tmp1[79:72], zdata, tmp1[71:64], zdata, 128'b 0};
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = img_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = img_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, tmp2[127:120], zdata, tmp2[119:112], zdata, tmp2[111:104], zdata, tmp2[103:96], zdata, tmp2[95:88], zdata, tmp2[87:80], zdata, tmp2[79:72], zdata, tmp2[71:64], zdata};
        tmp1 = tmp1 | tmp2;
        exp_q.push_back(tmp1);
      end
    end
    else begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = img_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = img_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = {tmp1[127:120], 8'b 0, tmp1[119:112], 8'b 0, tmp1[111:104], 8'b 0, tmp1[103:96], 8'b 0, tmp1[95:88], 8'b 0, tmp1[87:80], 8'b 0, tmp1[79:72], 8'b 0, tmp1[71:64], 8'b 0, 128'b 0};
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = img_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = img_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, tmp2[127:120], 8'b 0, tmp2[119:112], 8'b 0, tmp2[111:104], 8'b 0, tmp2[103:96], 8'b 0, tmp2[95:88], 8'b 0, tmp2[87:80], 8'b 0, tmp2[79:72], 8'b 0, tmp2[71:64], 8'b 0};
        tmp1 = tmp1 | tmp2;
        exp_q.push_back(tmp1);
      end
    end
  end
  else if(img_count >= 64 & img_count < 128) begin
    if(z_proc == 2'b 00) begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = z_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = z_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = { 8'b 0, tmp1[127:120], 8'b 0, tmp1[119:112], 8'b 0, tmp1[111:104], 8'b 0, tmp1[103:96], 8'b 0, tmp1[95:88], 8'b 0, tmp1[87:80], 8'b 0, tmp1[79:72], 8'b 0, tmp1[71:64], 128'b 0};
        tmp3 = exp_q.pop_front();
        tmp1 = tmp1 | tmp3;
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = z_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = z_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, 8'b 0, tmp2[127:120], 8'b 0, tmp2[119:112], 8'b 0, tmp2[111:104], 8'b 0, tmp2[103:96], 8'b 0, tmp2[95:88], 8'b 0, tmp2[87:80], 8'b 0, tmp2[79:72], 8'b 0, tmp2[71:64]};
        tmp1 = tmp1 | tmp2;
        exp_q.push_back(tmp1);
      end
    end
  end
  else if(img_count >= 128 & img_count < 192) begin
    if(z_proc == 2'b 01) begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = img_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = img_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = {tmp1[127:120], zdata, tmp1[119:112], zdata, tmp1[111:104], zdata, tmp1[103:96], zdata, tmp1[95:88], zdata, tmp1[87:80], zdata, tmp1[79:72], zdata, tmp1[71:64], zdata, 128'b 0};
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = img_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = img_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, tmp2[127:120], zdata, tmp2[119:112], zdata, tmp2[111:104], zdata, tmp2[103:96], zdata, tmp2[95:88], zdata, tmp2[87:80], zdata, tmp2[79:72], zdata, tmp2[71:64], zdata};
        tmp1 = tmp1 | tmp2;
        tmp2 = exp_q.pop_front();
        exp_q.push_back(tmp2);
        exp_q.push_back(tmp1);
      end
    end
    else begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = img_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = img_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = {tmp1[127:120], 8'b 0, tmp1[119:112], 8'b 0, tmp1[111:104], 8'b 0, tmp1[103:96], 8'b 0, tmp1[95:88], 8'b 0, tmp1[87:80], 8'b 0, tmp1[79:72], 8'b 0, tmp1[71:64], 8'b 0, 128'b 0};
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = img_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = img_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, tmp2[127:120], 8'b 0, tmp2[119:112], 8'b 0, tmp2[111:104], 8'b 0, tmp2[103:96], 8'b 0, tmp2[95:88], 8'b 0, tmp2[87:80], 8'b 0, tmp2[79:72], 8'b 0, tmp2[71:64], 8'b 0};
        tmp1 = tmp1 | tmp2;
        tmp2 = exp_q.pop_front();
        exp_q.push_back(tmp2);
        exp_q.push_back(tmp1);
      end
    end
  end
  else begin
    if(z_proc == 2'b 00) begin
      if(img_count%4 == 0) begin
        tmp1 = {data, 128'b 0};
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 1) begin
        tmp1 = exp_q.pop_front();
        tmp2 = {data, 128'b 0};
        exp_q.push_front(tmp2);
        exp_q.push_front(tmp1);
      end
      else if(img_count%4 == 2) begin
        tmp1 = exp_q.pop_front();
        tmp2 = exp_q.pop_front();
        tmp1[127:0] = z_ave_cal(tmp1[255:128], data);
        tmp1[127:0] = z_ave_cal({tmp1[127:120], tmp1[111:104], tmp1[95:88], tmp1[79:72], tmp1[63:56], tmp1[47:40], tmp1[31:24], tmp1[15:8], 64'b 0}, {tmp1[119:112], tmp1[103:96], tmp1[87:80], tmp1[71:64], tmp1[55:48], tmp1[39:32], tmp1[23:16], tmp1[7:0], 64'b 0});
        tmp1 = { 8'b 0, tmp1[127:120], 8'b 0, tmp1[119:112], 8'b 0, tmp1[111:104], 8'b 0, tmp1[103:96], 8'b 0, tmp1[95:88], 8'b 0, tmp1[87:80], 8'b 0, tmp1[79:72], 8'b 0, tmp1[71:64], 128'b 0};
        tmp3 = exp_q.pop_front();
        exp_q.push_back(tmp3);
        tmp3 = exp_q.pop_front();
        tmp1 = tmp1 | tmp3;
        exp_q.push_front(tmp1);
        exp_q.push_front(tmp2);
      end
      else begin
        tmp2 = exp_q.pop_front();
        tmp1 = exp_q.pop_front();
        tmp2[127:0] = z_ave_cal(tmp2[255:128], data);
        tmp2[127:0] = z_ave_cal({tmp2[127:120], tmp2[111:104], tmp2[95:88], tmp2[79:72], tmp2[63:56], tmp2[47:40], tmp2[31:24], tmp2[15:8], 64'b 0}, {tmp2[119:112], tmp2[103:96], tmp2[87:80], tmp2[71:64], tmp2[55:48], tmp2[39:32], tmp2[23:16], tmp2[7:0], 64'b 0});
        tmp2 = {128'b 0, 8'b 0, tmp2[127:120], 8'b 0, tmp2[119:112], 8'b 0, tmp2[111:104], 8'b 0, tmp2[103:96], 8'b 0, tmp2[95:88], 8'b 0, tmp2[87:80], 8'b 0, tmp2[79:72], 8'b 0, tmp2[71:64]};
        tmp1 = tmp1 | tmp2;
        exp_q.push_back(tmp1);
      end
    end
  end
  img_count ++;
  if(img_count == 256)
    -> data_collected;
endfunction
