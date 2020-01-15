function varargout = introduction(varargin)
% INTRODUCTION MATLAB code for introduction.fig
%      INTRODUCTION, by itself, creates a new INTRODUCTION or raises the existing
%      singleton*.
%
%      H = INTRODUCTION returns the handle to a new INTRODUCTION or the handle to
%      the existing singleton*.
%
%      INTRODUCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRODUCTION.M with the given input arguments.
%
%      INTRODUCTION('Property','Value',...) creates a new INTRODUCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before introduction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to introduction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help introduction

% Last Modified by GUIDE v2.5 15-Jan-2017 14:16:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @introduction_OpeningFcn, ...
                   'gui_OutputFcn',  @introduction_OutputFcn, ...
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


% --- Executes just before introduction is made visible.
function introduction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to introduction (see VARARGIN)

% Choose default command line output for introduction
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes introduction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = introduction_OutputFcn(hObject, eventdata, handles) 


function SummaryBuT_Callback(hObject, eventdata, handles)
open('hSummary.pdf');


function CloseBuT_Callback(hObject, eventdata, handles)
close(gcf);

function IOBuT_Callback(hObject, eventdata, handles)
open('hIo.pdf');

function DispBuT_Callback(hObject, eventdata, handles)
open('hDisplay.pdf');

function WaveletBuT_Callback(hObject, eventdata, handles)
open('hWavelets.pdf');


function FDBuT_Callback(hObject, eventdata, handles)
open('hFDs.pdf');


% --- Executes on button press in ListBuT.
function ListBuT_Callback(hObject, eventdata, handles)
open('hFcnsList.pdf');


