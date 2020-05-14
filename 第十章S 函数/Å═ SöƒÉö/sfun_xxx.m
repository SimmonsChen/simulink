function [sys,x0,str,ts,simStateCompliance] = sfun_xxx(t,x,u,flag)
switch flag,
case 0,
[sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;
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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 0;
sizes.NumInputs      = 0;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0,0];
simStateCompliance = 'UnknownSimState';
function sys=mdlDerivatives(t,x,u)
disp('微分方法');
sys = [];
function sys=mdlUpdate(t,x,u)
disp('更新方法');
sys = [];
function sys=mdlOutputs(t,x,u)
disp('输出方法');
sys = [];
function sys=mdlGetTimeOfNextVarHit(t,x,u)
disp('计算下一个采样时刻');
sampleTime = 1; 
sys = t + sampleTime;
function sys=mdlTerminate(t,x,u)
disp('结束状态');
sys = [];
