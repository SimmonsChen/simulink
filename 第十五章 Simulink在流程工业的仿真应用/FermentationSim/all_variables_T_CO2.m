%%%%%%%%%%乙醇发酵模型的参数取值%%%%%%%%%%%%%%%%%%%%
clc
clear
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi Temp F E A R flow0 flow1 flow2 flow3 flow4 flow5 flow6 flows1 flows2 flows0
Temp=30;
E=9.23*1e4;                             %活化能
R=8.314;                             %气体常数
A=8.46*1e14;                        %生长常数
Yxs=0.1604;
Yps=0.4986;
umax=0.1132;
vmax=0.9982;
Ks=101.276;
Kps=9.196;
Kp=28.779;
Kpp=660.54;
Ksi=106500;
Kpsi=296540;
Kpi=5968;
Kppi=16.658;
V0=165;
V1=600;
V5=500;
flow0=0.886+7.02;
flow1=73+7.62+flow0;
flow2=22.28+flow1;
flow3=11.14+flow2;
flow4=flow3;
flow5=flow4;
flow6=flow5;
flows0=852.21+850.02;
flows1=852.21+850.02+850.02+752.92;
flows2=flows1+850.02;
st=[10.12 1.65 218.72];
