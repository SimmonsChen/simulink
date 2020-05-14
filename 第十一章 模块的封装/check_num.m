function check_num(param)
% This function check if the value of param is a number data type.
val = get_param(gcbh, param);
if isletter(val)
    errordlg(['Input value of ', param(end) ,' must be a number data-type!']);
    return;
end