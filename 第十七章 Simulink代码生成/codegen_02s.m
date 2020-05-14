in = mpt.Signal;
in.InitialValue = '0';
in.StorageClass = 'Custom';
in.CoderInfo.CustomStorageClass = 'Global';
in.CoderInfo.CustomAttributes.MemorySection = 'MemVolatile';

out = mpt.Signal;
out.InitialValue = '0';
out.StorageClass = 'Custom';
out.CoderInfo.CustomStorageClass = 'Global';
out.CoderInfo.CustomAttributes.MemorySection = 'Default';

k = mpt.Parameter;
k.Value = 6;
k.StorageClass = 'Custom';
k.CoderInfo.CustomStorageClass = 'Global';
k.CoderInfo.CustomAttributes.MemorySection = 'MemConstVolatile';

line_h = find_system(gcs, 'findall' , 'on', 'Type', 'line');
set(line_h, 'MustResolveToSignalObject', 1);
set_param(gcs, 'InlineParams', 'on');

