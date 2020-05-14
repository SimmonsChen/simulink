function varargout = original(varargin)
% ORIGINAL M-file for original.fig
%      ORIGINAL, by itself, creates a new ORIGINAL or raises the existing
%      singleton*.
%
%      H = ORIGINAL returns the handle to a new ORIGINAL or the handle to
%      the existing singleton*.
%
%      ORIGINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORIGINAL.M with the given input arguments.
%
%      ORIGINAL('Property','Value',...) creates a new ORIGINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before original_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to original_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help original

% Last Modified by GUIDE v2.5 27-Apr-2009 11:06:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @original_OpeningFcn, ...
                   'gui_OutputFcn',  @original_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before original is made visible.
function original_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to original (see VARARGIN)

% Choose default command line output for original
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes original wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = original_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi T F Vy
Yxs=0.1604;                          %菌体相对于基质的得率
Yps=0.4986;                          %产物乙醇相对于基质的得率
umax=0.1132;                         %菌体最大比生长率
vmax=0.9982;                         %乙醇最大比生长率
Ks=101.276;                          %饱和常数
Kps=9.916;                           %
Kp=28.779;
Kpp=660.54;
Ksi=106500;
Kpsi=296540;
Kpi=5968;
Kppi=16.658;
sr=0.9886;          %无水乙醇和水混合后为10%左右的溶液体积缩减比
flowy=str2num(get(handles.edit1,'string'));        %预发酵罐的流速
flow0=str2num(get(handles.edit2,'string'));          %SPL0的流速
flow1=str2num(get(handles.edit3,'string'));             %SPL1的流速
flow2=str2num(get(handles.edit4,'string'));          %SPL2的流速
flow3=str2num(get(handles.edit5,'string'));       %SPL3的流速  
flowr=str2num(get(handles.edit6,'string'));           %RCY的流速
if flow3<6|flow3>15
    errordlg('请输入符合实际的SPL3流量','Error');
end
if flow2<10|flow2>30
    errordlg('请输入符合实际的SPL2流量','Error');
end
if flow1<50|flow1>90
    errordlg('请输入符合实际的SPL1流量','Error');
end
if flow0<5|flow0>9
    errordlg('请输入符合实际的SPL0流量','Error');
end
if flowy<0.5|flow>1.1
    errordlg('请输入符合实际的1号口流量','Error');
end
if flowr<0|flowr>8
    errordlg('请输入符合实际的RCY流量','Error');
end
sr=0.9886;          %无水乙醇和水混合后为10%左右的溶液体积缩减比
time0=165/(flowy+flow0);                                %停留时间等于发酵罐体积除以流量
time1=600/(flowy+flow0+flow1+flowr);
time2=600/(flowy+flow0+flow1+flow2+flowr);
time3=600/(flowy+flow0+flow1+flowr+flow2+flow3);
time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);        %料液平均停留时间发酵罐体积除以流量
timesum=time1+time2+time3+time4+time5+time6;            %计算总发酵时间
results=[];   %显示六个发酵罐的最后浓度用的矩阵
dresults=[];   %显示六个发酵罐的所有时刻浓度用的矩阵
x0=37.47;     %1号口进料的菌体浓度
p0=45.12;     %1号口进料乙醇的浓度
s0=1.07;      %1号口进料葡萄糖的浓度
              %求出三种量，每种物质的单位时间进量等于流量*浓度
Vy=(flowy+flow0)/sr;      %求单位时间SPL0和1的混合液进料后的体积(不考虑互溶）
                             
xs=flowy*x0;        %单位时间进料的质量（菌体、乙醇、葡萄糖）
ps=flowy*p0;
ss=flowy*s0;     
ss=ss+flow0*217;      %从SPL0补充进来的葡萄糖,217是补充进来糖类的浓度
x0=xs/Vy;         %进料管中混合体中各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %调用ode45来求解 
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,1,150);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                        %发酵罐中停留时间的最后时刻浓度值流入混合器的初始值
p0=F(end,2);
s0=F(end,3);
% disp('预发酵罐出来的浓度')
% results=[results;x0,p0/790,x0];                       %将该罐的结果保存为一列
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)                                   %显示该罐发酵结果
axes(handles.axes1);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('预发酵罐')
%legend('菌体','乙醇','糖类',-1)
xs=(flowy+flow0)*x0;       
ps=(flowy+flow0)*p0;
ss=(flowy+flow0)*s0;     %单位时间从预发酵罐出来的葡萄糖的质量,流量是1与SPL0的和
ss=ss+flow1*217;      %单位时间从SPL1补充进来的葡萄糖
xs=xs+flowr*147;     %反馈回来的质量
ps=ps+flowr*100;
ss=ss+0.5*flowr;
Vy=(flow1+flowr+Vy)/sr;          %增加了SPL1和RCY的流量
x0=xs/Vy;       %混合后各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time1,600);    %调用自编函数求解，调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';                                                    %为了保持与ode风格相似转置成列向量
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入混合器的初始值
p0=F(end,2);
s0=F(end,3);
% disp('发酵罐1出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一列
dresults=[dresults;F];     
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes2);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %每一列是一种成分的浓度序列
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐1')
% legend('菌体','乙醇','葡萄糖')
xs=(flowy+flow1+flow0+flowr)*x0;
ps=(flowy+flow1+flow0+flowr)*p0;
ss=(flowy+flow1+flow0+flowr)*s0;     %单位时间从发酵罐1出来的葡萄糖的质量
ss=ss+flow2*217;      %单位时间从SPL2补充进来的葡萄糖
Vy=flow2+Vy;  %SPL2单位时间混合后的体积
x0=xs/Vy;       %单位时间混合体中各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time2],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time2,600);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入混合器的初始值
p0=F(end,2);
s0=F(end,3);
% disp('发酵罐2出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];    
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes3);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐2')
xs=x0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的菌体的质量
ps=p0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的乙醇的质量
ss=s0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的葡萄糖的质量
ss=ss+flow3*217;                                %从SPL3补充进来的葡萄糖
Vy=flow3+Vy;                                    %每个发酵罐入口的流量等于它之前的所有发酵罐流量和再加上进料口的流量
x0=xs/Vy;                                       %混合后各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time3],[x0 p0 s0]);       
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time3,600);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值,从3号罐子之后不再有混合器
p0=F(end,2);      
s0=F(end,3);
% disp('发酵罐3出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一列
dresults=[dresults;F];    
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes4);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐3')

%[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time4,600);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);
s0=F(end,3);
% disp('发酵罐4出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];    
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes5);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐4')
%[T,F]=ode45('func2',[0 time5],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time5,500);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);                                                 
s0=F(end,3);
% disp('发酵罐5出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行列
dresults=[dresults;F];    
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes6);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %用不同颜色标记不同组分的曲线
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐5')
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time6,500);    %调用自编函数求解
F=F';
%[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);
s0=F(end,3);
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];    
axes(handles.axes7);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('发酵罐6')
axes(handles.axes8);
imshow('legend.jpg');
set(handles.edit9,'string',num2str(timesum)); %显示发酵时间
flag=get(handles.checkbox1,'value');
dresults(:,2)=dresults(:,2)/790;
if flag==0
    set(handles.listbox1,'string',num2str(results)); %将各个罐子的最终浓度数值显示到表单框
else
    set(handles.listbox1,'string',num2str(dresults)); %将各个罐子的所有时刻对应的浓度数值显示到表单框
end
set(handles.edit10,'string',num2str(x0));
set(handles.edit11,'string',num2str(p0/7.9));
set(handles.edit12,'string',num2str(s0));
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
close(gcf);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
data=get(handles.listbox1,'string');
xlswrite('data.xls',str2num(data));
msgbox('已经保存为data.xls文件');
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
delete('data.xls');
msgbox('已经清除data.xls文件');
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


