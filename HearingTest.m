function varargout = HearingTest(varargin)
% HEARINGTEST MATLAB code for HearingTest.fig
%      HEARINGTEST, by itself, creates a new HEARINGTEST or raises the existing
%      singleton*.
%
%      H = HEARINGTEST returns the handle to a new HEARINGTEST or the handle to
%      the existing singleton*.
%
%      HEARINGTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEARINGTEST.M with the given input arguments.
%
%      HEARINGTEST('Property','Value',...) creates a new HEARINGTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HearingTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HearingTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HearingTest

% Last Modified by GUIDE v2.5 09-Apr-2021 21:32:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HearingTest_OpeningFcn, ...
                   'gui_OutputFcn',  @HearingTest_OutputFcn, ...
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


% --- Executes just before HearingTest is made visible.
function HearingTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HearingTest (see VARARGIN)

% Choose default command line output for HearingTest
handles.output = hObject;
handles.s=0;
handles.t=[];


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HearingTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HearingTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
frequencies=[250 500 1000 2000 4000 8000];
plot(handles.axes1,frequencies,handles.t,'bo-')
xlabel('Frequency')
ylabel('dB')
title('Hearing Threshold')




% --- Executes on button press in Yes.
function Yes_Callback(hObject, eventdata, handles)
% hObject    handle to Yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles = guidata(hObject)
handles.s=1;
guidata(hObject, handles);
uiresume




% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text4,'String','In process');
handles = guidata(hObject);
frequencies=[250 500 1000 2000 4000 8000];
i=1;
tt=0:1/20000:1;
for y=frequencies
    if y==250
        dB=-30;
    elseif y==500
        dB=-50;
    elseif y==1000
        dB=-40;
    elseif y==2000
        dB=-40;
    elseif y==4000
        dB=-40;
    elseif y==8000;
        dB=-30;
    end
    m=1;
    while 1
        xx=(10^(dB/20))*cos(2*pi*y*tt+rand(1)*2*pi);
        sound(xx,20000)
        pause(1)
        uiwait
        handles = guidata(hObject);
        if handles.s==1
            range(i,m)=dB;
            m=m+1;
            break
        end
        %disp(handles.x(1))
        dB=dB+3;
    end
    while 1
        xx=(10^(dB/20))*cos(2*pi*y*tt+rand(1)*2*pi);
        sound(xx,20000)
        pause(1)
        uiwait
        handles = guidata(hObject);
        if handles.s==0
            break
        end
        range(i,m)=dB;
        m=m+1;
        dB=dB-3;
    end
    i=i+1;
end
Threshold=[((max(range(1,:))+min(range(1,:)))/2) ((max(range(2,:))+min(range(2,:)))/2) ((max(range(3,:))+min(range(3,:)))/2) ((max(range(4,:))+min(range(4,:)))/2) ((max(range(5,:))+min(range(5,:)))/2) ((max(range(6,:))+min(range(6,:)))/2)];
handles.t=Threshold;
guidata(hObject, handles);
set(handles.text4,'String','Finished');


    
% --- Executes on button press in No.
function No_Callback(hObject, eventdata, handles)
% hObject    handle to No (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.s=0;
guidata(hObject, handles);
uiresume
