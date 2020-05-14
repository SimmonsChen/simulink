function f=Tfunc(t,n,V)          %发酵罐的动力学函数,输入参数为时间,输入矩阵,体积,发酵温度
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi T F Vy Temp A E R Ts
f=zeros(3,1);                             %按照三行扩展列来保存每一步的三种物料的浓度
umax=A*exp(-E/(R*(273+Temp)));             %温度因素
u=umax*n(3)/(Ks+n(3)+n(3)^2/Ksi)*Kp/(Kp+n(2)+n(2)^2/Kpi);
v=vmax*n(3)/(Kps+n(3)+n(3)^2/Kpsi)*Kpp/(Kpp+n(2)+n(2)^2/Kppi);
D=Vy/V;
f(1)=u*n(1)+D*(x0-n(1));                %Dx         n(1)-x,n(2)-p,n(3)-s
f(2)=v*n(1)+D*(p0-n(2));                %Dp
f(3)=-(u/Yxs+v/Yps)*n(1)+D*(s0-n(3));        %Ds

