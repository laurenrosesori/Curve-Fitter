function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 04-Apr-2018 20:30:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
handles.timesEdited = 0;
handles.timesLoaded = 0;
handles.haveSelectedLog = 0;

% Update handles structure
guidata(hObject, handles);
    %look at data by writing "guidata(GUI)" in command window

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes during object creation, after setting all properties.


    % --- Executes on button press in loadDataFile.
    function loadDataFile_Callback(hObject, eventdata, handles)
        if strcmp( get(handles.edit2,'String'), 'Enter username' )
            msgbox('Enter a username first.');
        else
            if handles.timesLoaded > 0 %already loaded data in the current application runtime
                msgbox('You already loaded a data txt file. Restart to start over.');
            else
                selected_txt_file = uigetfile('*.txt','Select the .txt code file');
                data = dlmread(selected_txt_file);
                firstColumn = (data(:,[1]))';
                secondColumn = (data(:,[2]))';

                % At THIS point, "handles" is just a copy of guidata for the GUI
                handles.firstColumn = firstColumn;
                    guidata(hObject, handles); %handles put back as new guidata for GUI
                handles.secondColumn = secondColumn;
                    guidata(hObject, handles);
                    
                handles.timesLoaded = 1;
                    guidata(hObject, handles);
                set(handles.loadDataFile, 'BackgroundColor', [.94 .94 .94]);
                set(handles.setLogFile, 'BackgroundColor', 'yellow');
            end
        end
        
        
    % --- Executes on button press in clearData.
    function clearData_Callback(hObject, eventdata, handles)
       % **** TO DOOO****
        
    % --- Executes on button press in setLogFile.
    function setLogFile_Callback(hObject, eventdata, handles)
        if handles.timesLoaded == 0
            msgbox('Please load a data txt file before selecting a log location.');
        else
            selected_log_file = uigetfile('*.txt', 'Select a file to store the log');
            
            % --- write to log
            fileID = fopen(selected_log_file, 'a');
                fprintf(fileID, 'Username: %s\r\nDate: %s\r\n\r\n', handles.username, date);
                fclose(fileID);
            
            handles.haveSelectedLog = 1;
                guidata(hObject, handles);
            set(handles.setLogFile, 'BackgroundColor', [.94 .94 .94]);
        end

    % --- Executes on selection change in fitStyleMenu.
    function fitStyleMenu_Callback(hObject, eventdata, handles)
    % hObject    handle to fitStyleMenu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns fitStyleMenu contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from fitStyleMenu

    
    % --- Plot the txt file loaded
    function plotDataFile_Callback(hObject, eventdata, handles)
        if handles.timesLoaded == 0 %haven't loaded a data txt file yet
            msgbox('Please load a data txt file before attempting to plot.');
            set(handles.plotDataFile, 'Value', get(handles.plotDataFile, 'Min')); %toggle button remains off
                guidata(hObject, handles);
        else
            if handles.haveSelectedLog == 0 
               msgbox('Select a log file location first before attempting to plot.');
               set(handles.plotDataFile, 'Value', get(handles.plotDataFile, 'Min')); %toggle button remains off
                    guidata(hObject, handles);
            else
                buttonState = get(handles.plotDataFile, 'Value'); %toggle state
                plot(handles.axes1, handles.firstColumn, handles.secondColumn);
                     set(get(handles.axes1,'children'),'visible','off') %hide the current axes contents

                if buttonState == get(handles.plotDataFile, 'Max') %pressed
                    set(get(handles.axes1,'children'),'visible','on') 
                elseif buttonState == get(handles.plotDataFile, 'Min') %not pressed
                    set(get(handles.axes1,'children'),'visible','off') %hide the current axes contents
                end
            end
        end
  

    % --- Executes during object creation, after setting all properties.
    function fitStyleMenu_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to fitStyleMenu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


    % --- Executes on button press in plotAndRecord.
    function plotAndRecord_Callback(hObject, eventdata, handles)
        if handles.timesLoaded == 0
           msgbox('Please load a data txt file before attempting to plot.'); 
        else
            if handles.haveSelectedLog == 0
                 msgbox('Select a log file location first before attempting to plot.');
            else
                
            end
        end


function edit2_Callback(hObject, eventdata, handles)
    if handles.timesEdited > 0 %makes sure the user doesnt change the username mid application
        msgbox('You already entered a username before. Restart the application to begin logging data collection under a different name.')
    else
        username = get(handles.edit2, 'String');
        handles.username = username;
            guidata(hObject, handles); %update handles structure
        handles.timesEdited = handles.timesEdited+1;
            guidata(hObject, handles);
        set(handles.edit2, 'ForegroundColor', 'black');
        set(handles.edit2, 'BackgroundColor', 'white');
        set(handles.loadDataFile, 'BackgroundColor', 'yellow');
    
    end
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
