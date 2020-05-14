function [sys,x0,str,ts,simStateCompliance] = sfun_mask(t,x,u,flag,g_a, g_b)
switch flag,
case 0,
[sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
case 1,
sys=mdlDerivatives(t,x,u);
case 2,
sys=mdlUpdate(t,x,u);
case 3,
sys=mdlOutputs(t,x,u,g_a, g_b);
case 4,
sys=mdlGetTimeOfNextVarHit(t,x,u);
case 9,
sys=mdlTerminate(t,x,u);
otherwise
DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0,0];
simStateCompliance = 'UnknownSimState';
function sys=mdlDerivatives(t,x,u)
sys = [];
function sys=mdlUpdate(t,x,u)
sys = [];
function sys=mdlOutputs(t,x,u,g_a, g_b)
sys = g_a * u ^ 2 + g_b;
function sys=mdlGetTimeOfNextVarHit(t,x,u)
sampleTime = 1; 
sys = t + sampleTime;
function sys=mdlTerminate(t,x,u)
sys = [];
