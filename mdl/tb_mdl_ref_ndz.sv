//--------------------------------------------------
//File:         tb_mdl_ref_ndz.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160623      Jiemin        Creation
//--------------------------------------------------

function void tb_mdl::ref_nd_z(ci_beat data, bit [7:0] zdata);
  static int img_count = 0;
  y_beat tmp;
  if(img_count < 64) begin
    if(z_proc == 2'b 01)
      tmp = {data[127:120], zdata, data[119:112], zdata, data[111:104], zdata, data[103: 96], zdata,
             data[ 95: 88], zdata, data[ 87: 80], zdata, data[ 79: 72], zdata, data[ 71: 64], zdata,
             data[ 63: 56], zdata, data[ 55: 48], zdata, data[ 47: 40], zdata, data[ 39: 32], zdata,
             data[ 31: 24], zdata, data[ 23: 16], zdata, data[ 15:  8], zdata, data[  7:  0], zdata};
    else
      tmp = {data[127:120], 8'b 0, data[119:112], 8'b 0, data[111:104], 8'b 0, data[103: 96], 8'b 0,
             data[ 95: 88], 8'b 0, data[ 87: 80], 8'b 0, data[ 79: 72], 8'b 0, data[ 71: 64], 8'b 0,
             data[ 63: 56], 8'b 0, data[ 55: 48], 8'b 0, data[ 47: 40], 8'b 0, data[ 39: 32], 8'b 0,
             data[ 31: 24], 8'b 0, data[ 23: 16], 8'b 0, data[ 15:  8], 8'b 0, data[  7:  0], 8'b 0};
    exp_q.push_back(tmp);
  end
  else begin
    if(z_proc == 2'b 00) begin
      tmp = exp_q.pop_front();
      tmp = tmp | {8'b 0, data[127:120], 8'b 0, data[119:112], 8'b 0, data[111:104], 8'b 0, data[103: 96],
                   8'b 0, data[ 95: 88], 8'b 0, data[ 87: 80], 8'b 0, data[ 79: 72], 8'b 0, data[ 71: 64],
                   8'b 0, data[ 63: 56], 8'b 0, data[ 55: 48], 8'b 0, data[ 47: 40], 8'b 0, data[ 39: 32],
                   8'b 0, data[ 31: 24], 8'b 0, data[ 23: 16], 8'b 0, data[ 15:  8], 8'b 0, data[  7:  0]};
      exp_q.push_back(tmp);
    end
  end
  img_count ++;
  if(img_count == 128) begin
    img_count = 0;
    ->data_collected;
  end
  
endfunction
