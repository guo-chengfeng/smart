function varargout = smartdoc(varargin)
% SMARTDOC MATLAB code for smartdoc.fig
%      SMARTDOC, by itself, creates a new SMARTDOC or raises the existing
%      singleton*.
%
%      H = SMARTDOC returns the handle to a new SMARTDOC or the handle to
%      the existing singleton*.
%
%      SMARTDOC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SMARTDOC.M with the given input arguments.
%
%      SMARTDOC('Property','Value',...) creates a new SMARTDOC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before smartdoc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to smartdoc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help smartdoc

% Last Modified by GUIDE v2.5 22-Oct-2016 21:28:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @smartdoc_OpeningFcn, ...
                   'gui_OutputFcn',  @smartdoc_OutputFcn, ...
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


% --- Executes just before smartdoc is made visible.
function smartdoc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to smartdoc (see VARARGIN)

% Choose default command line output for smartdoc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes smartdoc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = smartdoc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BasicBuT.
function BasicBuT_Callback(hObject, eventdata, handles)
% hObject    handle to BasicBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
introduction();

% --- Executes on button press in ListBuT.
function ListBuT_Callback(hObject, eventdata, handles)
% hObject    handle to ListBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CloseBuT.
function CloseBuT_Callback(hObject, eventdata, handles)
% hObject    handle to CloseBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);

% --- Executes on button press in AcousticBuT.
function AcousticBuT_Callback(hObject, eventdata, handles)
% hObject    handle to AcousticBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('Modeling_Acoustic.pdf');

% --- Executes on button press in ElasticBuT.
function ElasticBuT_Callback(hObject, eventdata, handles)
% hObject    handle to ElasticBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EleMagBuT.
function EleMagBuT_Callback(hObject, eventdata, handles)
% hObject    handle to EleMagBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AnIsoBuT.
function AnIsoBuT_Callback(hObject, eventdata, handles)
% hObject    handle to AnIsoBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
