fixdt32_8 = Simulink.NumericType;
fixdt32_8.DataTypeMode = 'Fixed-point: binary point scaling';
fixdt32_8.Signedness = 'Unsigned';
fixdt32_8.WordLength = 32;
fixdt32_8.FractionLength = 8;
fixdt32_8.IsAlias = 0;
fixdt32_8.DataScope = 'Exported';
fixdt32_8.HeaderFile = 'custom.h';
fixdt32_8.Description ='This data type is created by Simulink.NumericType.';

 
in = mpt.Signal;
in.DataType = 'fixdt32_8';
 
out = mpt.Signal;
out.DataType = 'fixdt32_8';
 
A = Simulink.Signal;
A.CoderInfo.StorageClass = 'Custom';
A.CoderInfo.CustomStorageClass = 'GetSet';
A.CoderInfo.CustomAttributes.GetFunction = 'DataRead';
A.CoderInfo.CustomAttributes.SetFunction = 'DataWrite';
 
line_h = find_system(gcs, 'findall','on', 'type','line');
set(line_h, 'MustResolveToSignalObject', 1);
set_param(gcs, 'InlineParams', 'on');
