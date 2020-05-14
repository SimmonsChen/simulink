function [x,y]=runge_kutta1(ufunc,y0,h,a,b,Vg)    %参数表顺序依次是微分方程组的函数名称，初始值向量，步长，时间起点，时间终点,发酵罐体积
n=floor((b-a)/h);                                    %求步数
x(1)=a;                                       %时间起点
y(:,1)=y0;                                    %赋初值，可以是向量，但是要注意维数
for ii=1:n
   x(ii+1)=x(ii)+h;
   k1=ufunc(x(ii),y(:,ii),Vg);
   k2=ufunc(x(ii)+h/2,y(:,ii)+h*k1/2,Vg);
   k3=ufunc(x(ii)+h/2,y(:,ii)+h*k2/2,Vg);
   k4=ufunc(x(ii)+h,y(:,ii)+h*k3,Vg);
   y(:,ii+1)=y(:,ii)+h*(k1+2*k2+2*k3+k4)/6;       %按照龙格库塔方法进行数值求解
end 
