function varargout = ModelingExample(varargin)
% MODELINGEXAMPLE MATLAB code for ModelingExample.fig
%      MODELINGEXAMPLE, by itself, creates a new MODELINGEXAMPLE or raises the existing
%      singleton*.
%
%      H = MODELINGEXAMPLE returns the handle to a new MODELINGEXAMPLE or the handle to
%      the existing singleton*.
%
%      MODELINGEXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODELINGEXAMPLE.M with the given input arguments.
%
%      MODELINGEXAMPLE('Property','Value',...) creates a new MODELINGEXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ModelingExample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ModelingExample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ModelingExample

% Last Modified by GUIDE v2.5 27-May-2017 08:28:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ModelingExample_OpeningFcn, ...
    'gui_OutputFcn',  @ModelingExample_OutputFcn, ...
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


% --- Executes just before ModelingExample is made visible.
function ModelingExample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ModelingExample (see VARARGIN)

% Choose default command line output for ModelingExample
handles.output = hObject;
handles.dt=0.001;
handles.dx=10;
handles.dz=10;
handles.nx=300;
handles.nz=300;








% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ModelingExample wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ModelingExample_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function mModels_Callback(hObject, eventdata, handles)
% hObject    handle to mModels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mVpFile_Callback(hObject, eventdata, handles)
% hObject    handle to mVpFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mVsFile_Callback(hObject, eventdata, handles)
% hObject    handle to mVsFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mRhoFile_Callback(hObject, eventdata, handles)
% hObject    handle to mRhoFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mEpsilonFile_Callback(hObject, eventdata, handles)
% hObject    handle to mEpsilonFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mDeltaFile_Callback(hObject, eventdata, handles)
% hObject    handle to mDeltaFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mSetting_Callback(hObject, eventdata, handles)
% hObject    handle to mSetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sModelingType_Callback(hObject, eventdata, handles)
% hObject    handle to sModelingType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sGrids_Callback(hObject, eventdata, handles)
% hObject    handle to sGrids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sSource_Callback(hObject, eventdata, handles)
% hObject    handle to sSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function FDType_Callback(hObject, eventdata, handles)
% hObject    handle to FDType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sFDOrder_Callback(hObject, eventdata, handles)
% hObject    handle to sFDOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sPosition_Callback(hObject, eventdata, handles)
% hObject    handle to sPosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function swavelet_Callback(hObject, eventdata, handles)
% hObject    handle to swavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function snz_Callback(hObject, eventdata, handles)
% hObject    handle to snz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function snx_Callback(hObject, eventdata, handles)
% hObject    handle to snx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sDz_Callback(hObject, eventdata, handles)
% hObject    handle to sDz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sdx_Callback(hObject, eventdata, handles)
% hObject    handle to sdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sAcoustic_Callback(hObject, eventdata, handles)
% hObject    handle to sAcoustic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mElastic_Callback(hObject, eventdata, handles)
% hObject    handle to mElastic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Acoustic1order_Callback(hObject, eventdata, handles)
% hObject    handle to Acoustic1order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Acoustic2order_Callback(hObject, eventdata, handles)
% hObject    handle to Acoustic2order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Posx_Callback(hObject, eventdata, handles)
% hObject    handle to Posx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Posz_Callback(hObject, eventdata, handles)
% hObject    handle to Posz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CenterGrid_Callback(hObject, eventdata, handles)
% hObject    handle to CenterGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function StaggeredGrid_Callback(hObject, eventdata, handles)
% hObject    handle to StaggeredGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
