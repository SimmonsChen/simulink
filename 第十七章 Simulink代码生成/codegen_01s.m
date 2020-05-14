in1 = Simulink.Signal;
in1.InitialValue = '0';
in1.StorageClass = 'Custom';
in1.CoderInfo.CustomStorageClass = 'Struct';
in1.CoderInfo.CustomAttributes.StructName = 'input';

in2 = Simulink.Signal;
in2.InitialValue = '0';
in2.StorageClass = 'Custom';
in2.CoderInfo.CustomStorageClass = 'Struct';
in2.CoderInfo.CustomAttributes.StructName = 'input';

out = Simulink.Signal;
out.InitialValue = '0';
out.StorageClass = 'Custom';
out.CoderInfo.CustomStorageClass = 'Struct';
out.CoderInfo.CustomAttributes.StructName = 'output';


line_h = find_system(gcs, 'findall' , 'on', 'Type', 'line');
set(line_h, 'MustResolveToSignalObject', 1);

