in = mpt.Signal;
in.CoderInfo.StorageClass = 'Custom';
in.CoderInfo.CustomStorageClass = 'StructVolatile';
in.CoderInfo.CustomAttributes. StructName = 'VolaStruc';
 
out = mpt.Signal;
out.CoderInfo.StorageClass = 'Custom';
out.CoderInfo.CustomStorageClass = 'StructVolatile';
out.CoderInfo.CustomAttributes.StructName = 'VolaStruc';
 
k  = mpt.Parameter;
k.CoderInfo.StorageClass = 'Custom';
k.CoderInfo.CustomStorageClass = 'StructVolatile';
k.CoderInfo.CustomAttributes.StructName = 'VolaStruc';
 
line_h = find_system(gcs, 'findall','on', 'type','line');
set(line_h, 'MustResolveToSignalObject', 1);
set_param(gcs, 'InlineParams', 'on');
