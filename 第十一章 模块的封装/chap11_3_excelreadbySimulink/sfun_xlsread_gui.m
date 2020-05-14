function varargout = sfun_xlsread_gui(varargin)
% SFUN_XLSREAD_GUI MATLAB code for sfun_xlsread_gui.fig
%      SFUN_XLSREAD_GUI, by itself, creates a new SFUN_XLSREAD_GUI or raises the existing
%      singleton*.
%
%      H = SFUN_XLSREAD_GUI returns the handle to a new SFUN_XLSREAD_GUI or the handle to
%      the existing singleton*.
%
%      SFUN_XLSREAD_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SFUN_XLSREAD_GUI.M with the given input arguments.
%
%      SFUN_XLSREAD_GUI('Property','Value',...) creates a new SFUN_XLSREAD_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sfun_xlsread_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sfun_xlsread_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sfun_xlsread_gui

% Last Modified by GUIDE v2.5 26-Jul-2014 19:44:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sfun_xlsread_gui_OpeningFcn, ...
    'gui_OutputFcn',  @sfun_xlsread_gui_OutputFcn, ...
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


% --- Executes just before sfun_xlsread_gui is made visible.
function sfun_xlsread_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sfun_xlsread_gui (see VARARGIN)

% Choose default command line output for sfun_xlsread_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sfun_xlsread_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sfun_xlsread_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Help button is pressed. User can supply help file themselves.');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.xls','*.xlsx'}, 'Select an Excel file');
if isequal(filename,0)
    set_param(gcbh, 'g_file_path', '');
    set(handles.edit1, 'string', '');
    disp('User selected Cancel');
    return;
else
    file_path = fullfile(pathname, filename);
    set_param(gcbh, 'g_file_path', file_path);
    set(handles.edit1, 'string', file_path);
end

[data, str] = xlsread(file_path);
set(handles.uitable1, 'data', data);
axes(handles.axes1);
bar(data, 'g');




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
