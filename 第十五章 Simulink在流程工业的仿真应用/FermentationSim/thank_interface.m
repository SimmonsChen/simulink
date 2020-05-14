function varargout = thank_interface(varargin)
% THANK_INTERFACE M-file for thank_interface.fig
%      THANK_INTERFACE, by itself, creates a new THANK_INTERFACE or raises the existing
%      singleton*.
%
%      H = THANK_INTERFACE returns the handle to a new THANK_INTERFACE or the handle to
%      the existing singleton*.
%
%      THANK_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THANK_INTERFACE.M with the given input arguments.
%
%      THANK_INTERFACE('Property','Value',...) creates a new THANK_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before thank_interface_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to thank_interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help thank_interface

% Last Modified by GUIDE v2.5 18-May-2009 10:27:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @thank_interface_OpeningFcn, ...
                   'gui_OutputFcn',  @thank_interface_OutputFcn, ...
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


% --- Executes just before thank_interface is made visible.
function thank_interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to thank_interface (see VARARGIN)

% Choose default command line output for thank_interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes thank_interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = thank_interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)  

% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(3.5)
set(handles.text1,'string','毕业设计制作：孙忠潇')
pause(3.7)
set(handles.text1,'string','指导老师：杨小健')
pause(3.7)
set(handles.text1,'string','感谢答辩委员会的各位老师！')
pause(3.7)
close(gcf);

