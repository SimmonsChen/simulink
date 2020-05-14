replaced_type = {'FLOAT64','FLOAT32','INT32','INT16','INT8','UINT32','UINT16','UINT8','BOOL','INT32','UINT32','CHAR'};
base_type = {'double','single','int32','int16','int8','uint32','uint16','uint8','boolean','int32','uint32','uint8'};
type_num = length(replaced_type);
for ii = 1: type_num
    eval([replaced_type{ii},' = Simulink.AliasType; ']);
    eval([replaced_type{ii},'.BaseType = base_type{ii};']);
    assignin('base', replaced_type{ii}, eval(replaced_type{ii}));
end
