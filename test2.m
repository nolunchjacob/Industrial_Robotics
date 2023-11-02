function varargout = test2(varargin)
% TEST2 MATLAB code for test2.fig
%      TEST2, by itself, creates a new TEST2 or raises the existing
%      singleton*.
%
%      H = TEST2 returns the handle to a new TEST2 or the handle to
%      the existing singleton*.
%
%      TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST2.M with the given input arguments.
%
%      TEST2('Property','Value',...) creates a new TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test2

% Last Modified by GUIDE v2.5 30-Oct-2023 19:11:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test2_OpeningFcn, ...
                   'gui_OutputFcn',  @test2_OutputFcn, ...
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


% --- Executes just before test2 is made visible.
function test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test2 (see VARARGIN)

% Choose default command line output for test2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = test2_OutputFcn(hObject, eventdata, handles) 
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

axes(handles.axes1);
link(1) = Link('d',0.103+0.0362,    'a',0,      'alpha',-pi/2,  'offset',0, 'qlim',[deg2rad(-135),deg2rad(135)]);
link(2) = Link('d',0,        'a',0.135,  'alpha',0,      'offset',-pi/2, 'qlim',[deg2rad(5),deg2rad(80)]);
link(3) = Link('d',0,        'a',0.147,  'alpha',0,      'offset',0, 'qlim',[deg2rad(-5),deg2rad(85)]);
link(4) = Link('d',0,        'a',0.06,      'alpha',pi/2,  'offset',-pi/2, 'qlim',[deg2rad(-180),deg2rad(180)]);
link(5) = Link('d',-0.05,      'a',0,      'alpha',0,      'offset',pi, 'qlim',[deg2rad(-85),deg2rad(85)]);


model = SerialLink(link, 'name', 'DobotMagician');

for linkIndex = 0:model.n
 [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['DobotMagicianLink',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
 model.faces{linkIndex+1} = faceData;
 model.points{linkIndex+1} = vertexData;
end
% Display robot
workspace = [-1 1 -1 1 0 1];
scale = 2;
model.plot3d(zeros(1,model.n),'noarrow','workspace',workspace);
if isempty(findobj(get(gca,'Children'),'Type','Light'))
 camlight
end
model.delay = 0;
% Try to correctly colour the arm (if colours are in ply file data)
for linkIndex = 0:model.n
 handles = findobj('Tag', model.name);
 h = get(handles,'UserData');
 try
 h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
 , plyData{linkIndex+1}.vertex.green ...
, plyData{linkIndex+1}.vertex.blue]/255;
 h.link(linkIndex+1).Children.FaceColor = 'interp';
 catch ME_1
 disp(ME_1);
 continue;
 end
end
data = guidata(hObject);
data.model = model;
guidata(hObject,data);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

q = handles.model.getpos;
tr = handles.model.fkine(q).T;

tr(1:3, 4) = tr(1:3, 4) + [0.01; 0; 0];
newQ = handles.model.ikcon(tr, q);
handles.model.animate(newQ);


% --- Executes on slider movement.
function q1_val_Callback(hObject, eventdata, handles)
% hObject    handle to q1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q1_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(1) = deg2rad(get(handles.q1_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q1_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function q2_val_Callback(hObject, eventdata, handles)
% hObject    handle to q2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q2_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(2) = deg2rad(get(handles.q2_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q2_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q3_val_Callback(hObject, eventdata, handles)
% hObject    handle to q3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q3_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(3) = deg2rad(get(handles.q3_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q3_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q3_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q4_val_Callback(hObject, eventdata, handles)
% hObject    handle to q4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q4_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(4) = deg2rad(get(handles.q4_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q4_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q4_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q5_val_Callback(hObject, eventdata, handles)
% hObject    handle to q5_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q5_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(5) = deg2rad(get(handles.q5_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q5_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q5_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q5_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function q6_val_Callback(hObject, eventdata, handles)
% hObject    handle to q6_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

q = handles.model.getpos();
val = get(handles.q6_val,'value');
% Modify the q value of Joint 1 (for example, add 0.01 radians)
q(6) = deg2rad(get(handles.q6_val,'value'));

% Update the robot's position
tr = handles.model.fkine(q).T;

% Use the inverse kinematics to get a valid joint configuration
newQ = handles.model.ikcon(tr, q);

set(handles.q6_text,'string',val)
% Animate the robot with the updated joint configuration
handles.model.animate(newQ);

% --- Executes during object creation, after setting all properties.
function q6_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q6_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pos_x_Callback(hObject, eventdata, handles)
% hObject    handle to pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_x as text
%        str2double(get(hObject,'String')) returns contents of pos_x as a double


% --- Executes during object creation, after setting all properties.
function pos_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_z_Callback(hObject, eventdata, handles)
% hObject    handle to pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_z as text
%        str2double(get(hObject,'String')) returns contents of pos_z as a double


% --- Executes during object creation, after setting all properties.
function pos_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_y_Callback(hObject, eventdata, handles)
% hObject    handle to pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_y as text
%        str2double(get(hObject,'String')) returns contents of pos_y as a double


% --- Executes during object creation, after setting all properties.
function pos_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calc.
function calc_Callback(hObject, eventdata, handles)
% hObject    handle to calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PX = str2double(get(handles.pos_x, 'String'));
PY = str2double(get(handles.pos_y, 'String'));
PZ = str2double(get(handles.pos_z, 'String'));

T = [1 0 0 PX;
     0 1 0 PY;
     0 0 1 PZ;
     0 0 0 1];
J = handles.model.ikine(T, [0 0 0], [1 1 1 0 0 0]);
%handles.model.ikcon(tr, q);
handles.model.animate(J);


% --- Executes during object creation, after setting all properties.
function calc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to q2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
