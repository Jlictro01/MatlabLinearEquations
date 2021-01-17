function varargout = FinalGUI(varargin)
% FINALGUI MATLAB code for FinalGUI.fig
%      FINALGUI, by itself, creates a new FINALGUI or raises the existing
%      singleton*.
%
%      H = FINALGUI returns the handle to a new FINALGUI or the handle to
%      the existing singleton*.
%
%      FINALGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALGUI.M with the given input arguments.
%
%      FINALGUI('Property','Value',...) creates a new FINALGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalGUI

% Last Modified by GUIDE v2.5 11-Dec-2020 21:20:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalGUI_OutputFcn, ...
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


% --- Executes just before FinalGUI is made visible.
function FinalGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalGUI (see VARARGIN)

% Choose default command line output for FinalGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1. THIS IS GAUSSIAN DIRECT
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hide the error message box
set(handles.text8,'Visible','Off');
set(handles.text14,'Visible','Off');
%Setting up variables
augMatrix = str2num(get(handles.edit1, 'String'));
filePath = get(handles.edit6,'String');
%Only read from file if filepath is empty
if isempty(filePath)
else
A = fileread(filePath);
A = str2num(A);
end

%Determining which matrix input to use
if isempty(filePath) & isempty(augMatrix)
    fprintf("Please input a file path or augmented matrix");
elseif isempty(filePath) %Run augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
         set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
    [solutions] =gaussianjordan(augMatrix);
    end
elseif isempty(augMatrix) %Run filepath
    [isDiagonalized,B,broken] = checkError(A);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
  [solutions] =gaussianjordan(A);
    end
else %If both are filled, use augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
     [solutions] =gaussianjordan(augMatrix);
    end
end
%If Diagonalized, warn on the UI itself
if (isDiagonalized == 0)
    set(handles.text8,'Visible','On');
    set(handles.text8,'String',"Matrix is not diagonalized, so you may not get a proper result.");
end

%Display solution on UI
solutions = num2str(solutions);
set(handles.text7,'String', solutions);
set(handles.text9,'String',"");
set(handles.text13,'String',"");



% --- Executes on button press in pushbutton2.THIS IS GAUSS SEIDEL
function pushbutton2_Callback(hObject, eventdata, handles) 
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

format long 
%Hide error message box
set(handles.text8,'Visible','Off');
set(handles.text14,'Visible','Off');
%Set up variables
augMatrix = str2num(get(handles.edit1, 'String'));
stopCrit = get(handles.edit2,'String');
if stopCrit == "MAE"
    stopCrit = 1;
else
    stopCrit = 0;
end
thresholdCrit = str2num(get(handles.edit3, 'String'));
startingApprox = str2num(get(handles.edit4,'String'));
filePath = get(handles.edit6,'String');

%Check if file is empty to know to read
if isempty(filePath)
else
A = fileread(filePath);
A = str2num(A);
end

%Determining which matrix input to use
if isempty(filePath) & isempty(augMatrix)
    fprintf("Please input a file path or augmented matrix");
elseif isempty(filePath) %Run augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
    [solutions, its, error] =HW7GaussSeidel(augMatrix,startingApprox,thresholdCrit,stopCrit);
    end
elseif isempty(augMatrix) %Run filepath
    [isDiagonalized,B, broken] = checkError(A);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
  [solutions, its, error] =HW7GaussSeidel(A,startingApprox,thresholdCrit,stopCrit);
    end
else %If both are filled, use augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
     [solutions, its, error] =HW7GaussSeidel(augMatrix,startingApprox,thresholdCrit,stopCrit);
    end
end

%If Not Diagonalized, warn on the UI itself
if (isDiagonalized == 0)
    set(handles.text8,'Visible','On');
    set(handles.text8,'String',"Matrix is not diagonalized, so you may not get a proper result.");
end

%Display solutions
solutions = num2str(solutions);
error = num2str(error);
its = num2str(its);
set(handles.text7,'String', solutions);
set(handles.text9,'String',error);
set(handles.text13,'String',its);



% --- Executes on button press in pushbutton3. THIS IS JACOBI
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hide error message box
set(handles.text8,'Visible','Off');
set(handles.text14,'Visible','Off');
%Setting up variables
augMatrix = str2num(get(handles.edit1, 'String'));
stopCrit = get(handles.edit2,'String');
if stopCrit == "MAE"
    stopCrit = 1;
else
    stopCrit = 0;
end
thresholdCrit = str2num(get(handles.edit3, 'String'));
startingApprox = str2num(get(handles.edit4,'String'));
filePath = get(handles.edit6,'String');

%Read from file only if filepath has stuff in it
if isempty(filePath)
else
A = fileread(filePath);
A = str2num(A);
end

%Determining which matrix input to use
if isempty(filePath) & isempty(augMatrix)
    fprintf("Please input a file path or augmented matrix");
elseif isempty(filePath) %Run augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
    [solutions, its, error] =HW7Jacobi(augMatrix,startingApprox,thresholdCrit,stopCrit);
    end
elseif isempty(augMatrix) %Run filepath
    [isDiagonalized,B, broken] = checkError(A);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
  [solutions, its, error] =HW7Jacobi(A,startingApprox,thresholdCrit,stopCrit);
    end
else %If both are filled, use augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
     [solutions, its, error] =HW7Jacobi(augMatrix,startingApprox,thresholdCrit,stopCrit);
    end
end

%If Not Diagonalized, warn on the UI itself
if (isDiagonalized == 0)
    set(handles.text8,'Visible','On');
    set(handles.text8,'String',"Matrix is not diagonalized, so you may not get a proper result.");
end


%Display solutions
solutions = num2str(solutions);
error = num2str(error);
its = num2str(its);
set(handles.text7,'String', solutions);
set(handles.text9,'String',error);
set(handles.text13,'String',its);



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


% --- Executes on button press in pushbutton4. THIS IS GRAPHICAL
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Hide the error message box
set(handles.text8,'Visible','Off');
set(handles.text14,'Visible','Off');
%Setting up variables
augMatrix = str2num(get(handles.edit1, 'String'));
filePath = get(handles.edit6,'String');

%Only fileread if filepath filled
if isempty(filePath)
else
A = fileread(filePath);
A = str2num(A);
end

%Determining which matrix input to use
if isempty(filePath) & isempty(augMatrix)
    fprintf("Please input a file path or augmented matrix");
elseif isempty(filePath) %Run augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
    Graphical(augMatrix);
    end
elseif isempty(augMatrix) %Run filepath
    [isDiagonalized,B, broken] = checkError(A);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
  Graphical(A);
    end
else %If both are filled, use augmatrix
    [isDiagonalized,augMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
        Graphical(augMatrix);    
    end
end

%If Not Diagonalized, warn on the UI itself
if (isDiagonalized == 0)
    set(handles.text8,'Visible','On');
     set(handles.text8,'String',"Matrix is not diagonalized, so you may not get a proper result.");
end
set(handles.text7,'String', "See pop out");
set(handles.text9,'String',"");
set(handles.text13,'String',"");




% --- Executes on button press in pushbutton5. THIS IS CRAMERS
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hide the error message box
set(handles.text8,'Visible','Off');
set(handles.text14,'Visible','Off');
%Setting up variables
augMatrix = str2num(get(handles.edit1, 'String'));
filePath = get(handles.edit6,'String');

%Fileread only if filepath filled
if isempty(filePath)
else
A = fileread(filePath);
A = str2num(A);
end

%Determining which matrix input to use
if isempty(filePath) & isempty(augMatrix)
    fprintf("Please input a file path or augmented matrix");
elseif isempty(filePath) %Run augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
    [solutions] =cramers(augMatrix);
    end
elseif isempty(augMatrix) %Run filepath
    [isDiagonalized,B, broken] = checkError(A);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
 [solutions] =cramers(A);
    end
else %If both are filled, use augmatrix
    [isDiagonalized,nonAugMatrix, broken] = checkError(augMatrix);
    if broken == 1
        fprintf("Matrix is singular!");
        set(handles.text14,'Visible','On');
        set(handles.text14,'String',"Matrix is singular!.");
    else
      [solutions] =cramers(augMatrix);
    end
end

%If Not Diagonalized, warn on the UI itself
if (isDiagonalized == 0)
    set(handles.text8,'Visible','On');
     set(handles.text8,'String',"Matrix is not diagonalized, so you may not get a proper result.");
end

solutions = num2str(solutions);
set(handles.text7,'String', solutions);
set(handles.text9,'String',"");
set(handles.text13,'String',"");


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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
