clc;
clear all;
close all;
bdclose all;
%%
lct_spec = legacy_code('initialize');
lct_spec.SFunctionName = 'sfun_Em_Math';
lct_spec.HeaderFiles = {'EmMath.h'};
lct_spec.SourceFiles = {'EmMath.c'};
% signed long Q12_Sin(unsigned long Angle)
lct_spec.OutputFcnSpec = 'int32 y1 = Em_Sin(uint32 u1)';
legacy_code('sfcn_cmex_generate', lct_spec);
legacy_code('compile', lct_spec);
legacy_code('slblock_generate', lct_spec, 'lct_model');
%% struct model input
stop_time = get_param(gcs, 'StopTime');
simin.time = [0:str2num(stop_time)]';
simin.signals.values = [0:length(simin.time) - 1]';
simin.signals.demensions = [length(simin.time) 1];