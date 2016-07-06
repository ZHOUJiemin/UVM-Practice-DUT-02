//--------------------------------------------------
//File:         tb_mdl_ref_rgb.sv
//Description:  T2R3 TB Reference Model
//Author:       ZHOU Jiemin
//Modification History
//Date          Author        Modification
//20160623      Jiemin        Creation
//--------------------------------------------------

function void tb_mdl::ref_rgb(ci_beat data);
  static bit flag = 1'b 0;
  static int img_count = 0;
  y_beat tmp;
  if(flag) begin
    tmp = exp_q.pop_back;
    tmp = tmp | {128'b 0, data};
    exp_q.push_back(tmp);
  end
  else
    exp_q.push_back({data, 128'b 0});
  flag = ~flag;
  img_count++;
  if(img_count == 192) begin
    img_count = 0;
    ->data_collected;
  end
endfunction
