function [sys,x0,str,ts,simStateCompliance] = sfun_xlsread(t,x,u,flag,g_file_path)
switch flag,
case 0,
[sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(g_file_path);
case 1,
sys=mdlDerivatives(t,x,u);
case 2,
sys=mdlUpdate(t,x,u);
case 3,
sys=mdlOutputs(t,x,u);
case 4,
sys=mdlGetTimeOfNextVarHit(t,x,u);
case 9,
sys=mdlTerminate(t,x,u);
otherwise
DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(g_file_path)
global data len cnt
[data, str] = xlsread(g_file_path);
len = length(data);
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0,0];
cnt = 0;
simStateCompliance = 'UnknownSimState';


function sys=mdlDerivatives(t,x,u)
sys = [];
function sys=mdlUpdate(t,x,u)
sys = [];
function sys=mdlOutputs(t,x,u)
global data len cnt
cnt = cnt + 1;
if cnt <= len
    sys = data(cnt);
else
    sys = data(end);
end
function sys=mdlGetTimeOfNextVarHit(t,x,u)
sampleTime = 1; 
sys = t + sampleTime;
function sys=mdlTerminate(t,x,u)
sys = [];
