function varargout = section_model(varargin)
% SECTION_MODEL MATLAB code for section_model.fig
%      SECTION_MODEL, by itself, creates a new SECTION_MODEL or raises the existing
%      singleton*.
%
%      H = SECTION_MODEL returns the handle to a new SECTION_MODEL or the handle to
%      the existing singleton*.
%
%      SECTION_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION_MODEL.M with the given input arguments.
%
%      SECTION_MODEL('Property','Value',...) creates a new SECTION_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before section_model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to section_model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help section_model

% Last Modified by GUIDE v2.5 02-Jan-2015 09:24:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @section_model_OpeningFcn, ...
                   'gui_OutputFcn',  @section_model_OutputFcn, ...
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


% --- Executes just before section_model is made visible.
function section_model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to section_model (see VARARGIN)

% Choose default command line output for section_model
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes section_model wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = section_model_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bdclose all;
threshold = get(handles.edit1,'string');
up_out = get(handles.edit2, 'string');
down_out = get(handles.edit3, 'string');
rel = get(handles.popupmenu1,'Value');

mdl_name = 'switch_section';
mdl_handle = new_system(mdl_name);
open_system(mdl_handle);
add_block('simulink/Signal Routing/Switch',[mdl_name,'/Switch']);
add_block('simulink/Commonly Used Blocks/In1',[mdl_name,'/In1'],'Position',[35   213    65   227]);
add_block('simulink/Commonly Used Blocks/Out1',[mdl_name, '/Out1'],'Position',[345   213   375   227]);
add_block('simulink/Commonly Used Blocks/Constant',[mdl_name, '/Constant'],'Position',[125   150   155   180]);
add_block('simulink/Commonly Used Blocks/Constant',[mdl_name, '/Constant1'],'Position',[125   265   155   295]);
if rel == 2
    criterial = 'u2 > Threshold';
elseif rel == 1
    criterial = 'u2 >= Threshold';
else
    criterial = 'u2 ~= 0';
end
set_param([mdl_name,'/Switch'], 'Criteria', criterial, 'Threshold', threshold);
set_param([mdl_name, '/Constant'],'Value', up_out);
set_param([mdl_name, '/Constant1'],'Value', down_out);
autorouting = get(handles.checkbox1, 'value');
if isequal(autorouting, 0)
    add_line(mdl_name,'In1/1','Switch/2');
    add_line(mdl_name,'Switch/1','Out1/1');
    add_line(mdl_name,'Constant/1','Switch/1');
    add_line(mdl_name,'Constant1/1','Switch/3');
else
    add_line(mdl_name,'In1/1','Switch/2','autorouting','on');
    add_line(mdl_name,'Switch/1','Out1/1','autorouting','on');
    add_line(mdl_name,'Constant/1','Switch/1','autorouting','on');
    add_line(mdl_name,'Constant1/1','Switch/3','autorouting','on');
end


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.ilovematlab.cn/article-29-1.html');

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bdclose all;
close(gcf);


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://weibo.com/u/2300570331');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
if 3 == get(hObject,'Value')
    set(handles.edit1, 'Enable', 'off', 'string','0');
else
    set(handles.edit1, 'Enable', 'on');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
