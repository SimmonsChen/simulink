A = Simulink.Signal;
A.CoderInfo.StorageClass = 'Custom';
A.CoderInfo.CustomStorageClass = 'GetSet';
A.CoderInfo.CustomAttributes.GetFunction = 'DataRead';
A.CoderInfo.CustomAttributes.SetFunction = 'DataWrite';
