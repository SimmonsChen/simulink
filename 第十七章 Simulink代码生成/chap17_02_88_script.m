custom_float = Simulink.AliasType;
custom_float.HeaderFile = 'custom';
custom_float.DataScope = 'Exported';
 
in = mpt.Signal;
in.CoderInfo.StorageClass = 'Custom';
in.CoderInfo.CustomStorageClass = 'StructVolatile';
in.CoderInfo.CustomAttributes. StructName = 'VolaStruc';
in.DataType = 'custom_float';
 
out = mpt.Signal;
out.CoderInfo.StorageClass = 'Custom';
out.CoderInfo.CustomStorageClass = 'StructVolatile';
out.CoderInfo.CustomAttributes.StructName = 'VolaStruc';
out.DataType = 'custom_float';
 
A = Simulink.Signal;
A.CoderInfo.StorageClass = 'Custom';
A.CoderInfo.CustomStorageClass = 'GetSet';
A.CoderInfo.CustomAttributes.GetFunction = 'DataRead';
A.CoderInfo.CustomAttributes.SetFunction = 'DataWrite';
 
line_h = find_system(gcs, 'findall','on', 'type','line');
set(line_h, 'MustResolveToSignalObject', 1);
set_param(gcs, 'InlineParams', 'on');
