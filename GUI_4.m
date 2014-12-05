function varargout = GUI_4(varargin)
% GUI_4 MATLAB code for GUI_4.fig
%      GUI_4, by itself, creates a new GUI_4 or raises the existing
%      singleton*.
%
%      H = GUI_4 returns the handle to a new GUI_4 or the handle to
%      the existing singleton*.
%
%      GUI_4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_4.M with the given input arguments.
%
%      GUI_4('Property','Value',...) creates a new GUI_4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_4

% Last Modified by GUIDE v2.5 18-Nov-2014 13:04:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_4_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_4_OutputFcn, ...
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


% --- Executes just before GUI_4 is made visible.
function GUI_4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_4 (see VARARGIN)

% Choose default command line output for GUI_4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% global tg
% tg = xpc;
% filename = 'dc_motor_encoder_hardware_simulated';
% if strcmp(tg.application,filename)
%         tg.load(filename);
% else rtwbuild(filename);
% end
% 
% tg.start;
% pause(1);
% tg.setparam('DOWN', 0);
% pause(2);
% tg.setparam('UP', 1);
% pause(2);
% tg.setparam('EMAG', 0);
% pause(1);
% tg.setparam('INOUT', 1);
% pause(1);

% camera
dataMatrix(1,1) = cellstr('-');
dataMatrix(2,1) = cellstr('-');
dataMatrix(3,1) = cellstr('-');
dataMatrix(4,1) = cellstr('-');
dataMatrix(5,1) = cellstr('-');
dataMatrix(6,1) = cellstr('-');
dataMatrix(7,1) = cellstr('-');
dataMatrix(8,1) = cellstr('-');
dataMatrix(9,1) = cellstr('-');
dataMatrix(10,1) = cellstr('-');

dataMatrix(1,2) = cellstr('  15');
dataMatrix(2,2) = cellstr('  45');
dataMatrix(3,2) = cellstr('  90');
dataMatrix(4,2) = cellstr(' 135');
dataMatrix(5,2) = cellstr(' 165');
dataMatrix(6,2) = cellstr('-155');
dataMatrix(7,2) = cellstr('-120');
dataMatrix(8,2) = cellstr(' -90');
dataMatrix(9,2) = cellstr(' -60');
dataMatrix(10,2) = cellstr(' -25');

set(handles.InitialBoard, 'Data', dataMatrix);
set(handles.DecodeBoard, 'Data', dataMatrix);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Read.
function Read_Callback(hObject, eventdata, handles)
% hObject    handle to Read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global game
game = Scan();

dataMatrix = get(handles.InitialBoard, 'Data');
table_color = cell(10,1);

for n = 1:10
    j = game.Colors(n);
    switch (j)
        case 1
            table_color(n) = cellstr('Red');
        case 2
            table_color(n) = cellstr('Green');
        case 3
            table_color(n) = cellstr('Yellow');
        case 4
            table_color(n) = cellstr('Blue');
        otherwise
            table_color(n) = cellstr('-');
    end
    dataMatrix(n,1) = table_color(n);
end
set(handles.InitialBoard, 'Data', dataMatrix);

% --- Executes on button press in QR.
function QR_Callback(hObject, eventdata, handles)
% hObject    handle to QR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global game
global instructions
store = game;
goal = verify(game); %Decode QR code
game = store;
storeb = goal;
instructions = solve(goal, game);
game = store; % I HAVE NO IDEA WHY THIS DISAPPEARS!
dataMatrix = get(handles.DecodeBoard, 'Data');
table_color = cell(10,1);

for n = 1:10
    j = goal.Colors(2*n-1);
    switch (j)
        case 'R'
            table_color(n) = cellstr('Red');
        case 'G'
            table_color(n) = cellstr('Green');
        case 'Y'
            table_color(n) = cellstr('Yellow');
        case 'B'
            table_color(n) = cellstr('Blue');
        otherwise
            table_color(n) = cellstr('-');
    end
    dataMatrix(n,1) = table_color(n);
end


set(handles.DecodeBoard, 'Data', dataMatrix);


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global instructions;
loc = 1; % loc = 1 -> outer ring, loc = 0 -> inner ring
tg.setparam('INOUT', loc);
pause(1);
[row col] = size(instructions);

% Comments indicate the flow, but you'll need to get the tg.setparams set
% right
offset = 90; % modify if necessary to get under crane properly
for i = 0:row
    angle_d = instructions(row,1); %washer to pick up
   
    % Switch between inner or outer ring if necessary
    if (angle_d == 15 || angle_d == 90 || angle_d == 165 || angle_d == -60 || angle_d == -120) && loc == 1
        %currently at outer ring and needs to pick up from inner ring
        %move to inner ring
        loc = 0;
        tg.setparam('INOUT', loc);
        pause(1);
    end
    if (angle_d == 45 || angle_d == 135 || angle_d == -25 || angle_d == -90 || angle_d == -155) && loc == 0
        %currently at inner ring and need to pick up from outer ring
        %move to outer ring
        loc = 1;
        tg.setparam('INOUT', loc);
        pause(1);
    end
    
    % Move to well (this is implemented below)
    tg.setparam('Desired position in degrees/Value',angle_d-offset); 
 
    pause(1); %<- should be able to remove this if we do it right
    % Move actuator down
    tg.setparam('UP', 0);
    pause(2);
    tg.setparam('DOWN', 1);
    pause(2);
    % turn magnet on
    tg.setparam('EMAG', 1);
    pause(3);
    % Move actuator up
    tg.setparam('DOWN', 0);
    pause(2);
    tg.setparam('UP', 1);
    pause(2);
    
    angle_d = instructions(row,2);
    % Switch between inner or outer ring if necessary
    if (angle_d == 45 || angle_d == 135 || angle_d == -25 || angle_d == -90 || angle_d == -155) && loc == 0
        %currently at inner ring and need to drop in outer ring
        %move to outer ring
        loc = 1;
        tg.setparam('INOUT', loc);
        pause(1);
    end
    if (angle_d == 15 || angle_d == 90 || angle_d == 165 || angle_d == -60 || angle_d == -120) && loc == 1
        %currently at outer ring and needs to drop in inner ring
        %move to inner ring
        loc = 0;
        tg.setparam('INOUT', loc);
        pause(1);
    end
    % Move actuator to proper ring if necessary
    % Move to well (already implimented)
    tg.setparam('Desired position in degrees/Value',angle_d-offset); %location to drop
    pause(3); % <- shouldn't need (might need some delay, but idk)
    % move actuator down (might be able to skip this step depending on things....)
    tg.setparam('UP', 0);
    pause(2);
    tg.setparam('DOWN', 1);
    pause(2);
    % turn magnet off
    tg.setparam('EMAG',0);
    pause(3);
    
    %lift arm
    tg.setparam('DOWN', 0);
    pause(2);
    tg.setparam('UP', 1);
    pause(2);

end
digits(4);
time = toc;
%print time here

set(handles.SolveTime, 'String', time);

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dataMatrix(1,1) = cellstr('-');
dataMatrix(2,1) = cellstr('-');
dataMatrix(3,1) = cellstr('-');
dataMatrix(4,1) = cellstr('-');
dataMatrix(5,1) = cellstr('-');
dataMatrix(6,1) = cellstr('-');
dataMatrix(7,1) = cellstr('-');
dataMatrix(8,1) = cellstr('-');
dataMatrix(9,1) = cellstr('-');
dataMatrix(10,1) = cellstr('-');

dataMatrix(1,2) = cellstr('  15');
dataMatrix(2,2) = cellstr('  45');
dataMatrix(3,2) = cellstr('  90');
dataMatrix(4,2) = cellstr(' 135');
dataMatrix(5,2) = cellstr(' 165');
dataMatrix(6,2) = cellstr('-155');
dataMatrix(7,2) = cellstr('-120');
dataMatrix(8,2) = cellstr(' -90');
dataMatrix(9,2) = cellstr(' -60');
dataMatrix(10,2) = cellstr(' -25');

time = '0.0';

set(handles.InitialBoard, 'Data', dataMatrix);
set(handles.DecodeBoard, 'Data', dataMatrix);
set(handles.SolveTime, 'String', time);
