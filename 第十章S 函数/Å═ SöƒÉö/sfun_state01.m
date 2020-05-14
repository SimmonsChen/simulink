function [sys,x0,str,ts,simStateCompliance] = sfun_state01(t,x,u,flag,A,B,C)
switch flag,
case 0,
[sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
case 1,
sys=mdlDerivatives(t,x,u);
case 2,
sys=mdlUpdate(t,x,u,A,B);
case 3,
sys=mdlOutputs(t,x,u,C);
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
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0 0]';
str = [];
ts  = [0,0];
simStateCompliance = 'UnknownSimState';
function sys=mdlDerivatives(t,x,u)

sys = [];
function sys=mdlUpdate(t,x,u,A,B)
% update state variable
sys = A * x + B * u;

function sys=mdlOutputs(t,x,u,C)
% update output 
sys = C * x;

function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1; 
sys = t + sampleTime;
function sys=mdlTerminate(t,x,u)

sys = [];
