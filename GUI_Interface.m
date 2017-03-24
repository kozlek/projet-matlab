function varargout = GUI_Interface(varargin)
% GUI_INTERFACE MATLAB code for GUI_Interface.fig
%      GUI_INTERFACE, by itself, creates a new GUI_INTERFACE or raises the existing
%      singleton*.
%
%      H = GUI_INTERFACE returns the handle to a new GUI_INTERFACE or the handle to
%      the existing singleton*.
%
%      GUI_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INTERFACE.M with the given input arguments.
%
%      GUI_INTERFACE('Property','Value',...) creates a new GUI_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Interface

% Last Modified by GUIDE v2.5 03-Apr-2016 17:54:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Interface_OutputFcn, ...
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

%INITIALISER LENSEMBLE DES RESSOURCES GRAPGHIQUE + SLIDERS ET AFFICHAGE
% --- Executes just before GUI_Interface is made visible.
function GUI_Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Interface (see VARARGIN)

% Choose default command line output for GUI_Interface
handles.output = hObject;
handles.player=0;

%%%Code repris d'un tuto sur internet ! 
% create an axes that spans the whole gui
gui = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
image = imread('img/theme.png'); 
imagesc(image);
% prevent plotting over the background and turn the axis off
set(gui,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(gui, 'bottom');
%%%

%On initialise le slider attenuation en changeant les bornes par default 0
%et 1!
set(handles.slider_attenuation, 'min', 1);
set(handles.slider_attenuation, 'max', 50);
set(handles.slider_attenuation, 'Value', 1);

%Slider amplification
set(handles.slider_amplification, 'min', 1);
set(handles.slider_amplification, 'max', 10);
set(handles.slider_amplification, 'Value', 1);

%Slider Tremolo
set(handles.slider_tremolo, 'min', 0.1);
set(handles.slider_tremolo, 'max', 3);
set(handles.slider_tremolo, 'Value', 0.1);
set(handles.slider_tremolo2, 'min', 1);
set(handles.slider_tremolo2, 'max', 50);
set(handles.slider_tremolo2, 'Value', 1);

%Slider Echo
set(handles.slider_echo, 'min', 5000);
set(handles.slider_echo, 'max', 50000);
set(handles.slider_echo, 'Value', 5000);

%Slider Distortion
set(handles.slider_distortion, 'min', 0);
set(handles.slider_distortion, 'max', 10);
set(handles.slider_distortion, 'Value', 0);
set(handles.slider_distortion2, 'min', 1);
set(handles.slider_distortion2, 'max', 10);
set(handles.slider_distortion2, 'Value', 1);

%Slider Flanger
set(handles.slider_flanger, 'min', 0.001);
set(handles.slider_flanger, 'max', 0.01);
set(handles.slider_flanger, 'Value', 0.001);
set(handles.slider_flanger2, 'min', 1);
set(handles.slider_flanger2, 'max', 10);
set(handles.slider_flanger2, 'Value', 1);

%Slider Filter Low Mid High
set(handles.slider_filter1, 'min', 0);
set(handles.slider_filter1, 'max', 2);
set(handles.slider_filter1, 'Value', 1);
set(handles.slider_filter2, 'min', 0);
set(handles.slider_filter2, 'max', 2);
set(handles.slider_filter2, 'Value', 1);
set(handles.slider_filter3, 'min', 0);
set(handles.slider_filter3, 'max', 2);
set(handles.slider_filter3, 'Value', 1);

%Slider Wobble
set(handles.slider_wobble, 'min', 1);
set(handles.slider_wobble, 'max', 10);
set(handles.slider_wobble, 'Value', 1);
set(handles.slider_wobble2, 'min', 0.3);
set(handles.slider_wobble2, 'max', 0.7);
set(handles.slider_wobble2, 'Value', 0.3);

%Acceleration / Deceleration
set(handles.slider_deceleration, 'Value', 1);
set(handles.slider_acceleration, 'Value', 1);

%Display Temporal by default
set(handles.frequencial_display,'Value',0);
set(handles.temporal_display,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%POUR IMPORTER UNE MUSIQUE
% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

file_name = uigetfile; %Pour s�lectionner des fichiers depuis l'ordinateur
set(handles.path,'String',file_name);
[y,Fs]=audioread(file_name); %[y,Fs] = audioread(filename) reads data from the file named filename, and returns sampled data, y, and a sample rate for that data, Fs
handles.y1=y; %On passe les donn�es de la musique � la sub-class handle de la fct! (sample data) Data non modifi� !
handles.y2=y; %idem ici C'est le data que l'on va modifier pour les effets et ensuite l'afficher
handles.Fs=Fs;%ici on recopie le sample rate
handles.Fs2=Fs;
guidata(hObject,handles); %On recopie ces objets contenant les donn�es dans le dossier du GUI! (en commun)
    
%POUR LANCER UNE MUSIQUE
% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
message_wait=waitbar(0.5, 'wait for loading ... '); %On affiche une barre pour faire "attendre" le chargement du son
pause(1); %On fait une pause d'une seconde!
waitbar(1,message_wait, 'wait for loading ... ');
close(message_wait); %On ferme le message wait ! 

y=handles.y1; %On r�cup�re le fichier Wav import data et il peut avoir un effet dessus !
Fs=handles.Fs; %Idem pour le rate du fichier wav
handles.player=audioplayer(y,Fs); %On stocke en m�moire dans le sub class handle l'audio_player
play(handles.player); %Fonction permettant de jouer une musique
guidata(hObject,handles); %On renvoit les nouvelles donn�es � l'ensemble du GUI! Pour pouvoir les utiliser ailleurs!

%On plot la musique sur notre axe du haut !
axes(handles.original_wave_axes)
plot(y);
xlabel('Time');
ylabel('Amplitude');
set(handles.frequencial_display,'Value',0);
set(handles.temporal_display,'Value',1);
%h = bode(y,Fs);
%axes(handles.bode_axes)
%plot(h);
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);

%POUR JOUER LA MUSIQUE AVEC LEFFET ou LES EFFETS
% --- Executes on button press in play_effect.
function play_effect_Callback(hObject, eventdata, handles)
% hObject    handle to play_effect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Rejouer la musique avec l'effet !
handles.player=audioplayer(handles.y2,handles.Fs2); %On stocke en m�moire dans le sub class handle l'audio_player
play(handles.player);%On joue la musique modifi� par les effets.
set(handles.frequencial_display,'Value',0); %on met par defaut � 0 l'affichage en fr�quence.
set(handles.temporal_display,'Value',1); %On affiche l'affichage temporelle.
guidata(hObject,handles);

%Affichage de la nouvelle wave form !!
axes(handles.modified_wave_axes)
plot(handles.y2);
xlabel('Time');
ylabel('Amplitude');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);


guidata(hObject,handles);

%POUR METTRE EN STOP LA MUSIQUE
% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(handles.player);

%POUR RESUME LA MUSIQUE
% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resume(handles.player);

%LE RESET DU PROGRAMME
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%on supprime les graphes et on arrete la musique
stop(handles.player);
cla(handles.original_wave_axes,'reset');
cla(handles.modified_wave_axes,'reset');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);
cla(handles.bode_axes,'reset');
set(handles.bode_axes,'XColor',[1 1 1]);
set(handles.bode_axes,'YColor',[1 1 1]);

%On R�initialise toutes les donn�es son � 0.
handles.y2 = handles.y1;
guidata(hObject,handles);

handles.path.String ='Path'; %On supprime le String
            
%Affichage des filtres reset en OFF:
set(handles.text_echo,'String','OFF');
set(handles.text_echo,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_tremolo,'String','OFF');
set(handles.text_tremolo,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_amplification,'String','OFF');
set(handles.text_amplification,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_attenuation,'String','OFF');
set(handles.text_attenuation,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_wobble,'String','OFF');
set(handles.text_wobble,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_flanger,'String','OFF');
set(handles.text_flanger,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_distortion,'String','OFF');
set(handles.text_distortion,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_filter1,'String','OFF');
set(handles.text_filter1,'backgroundcolor',[0.5 0.5 .5]);

%Reset les sliders � leurs positions intial
set(handles.slider_amplification, 'Value', 1);
set(handles.slider_attenuation, 'Value', 1);
set(handles.slider_tremolo, 'Value', 0.1);
set(handles.slider_tremolo2, 'Value', 1);
set(handles.slider_echo, 'Value', 5000);
set(handles.slider_distortion, 'Value', 0);
set(handles.slider_distortion2, 'Value', 1);
set(handles.slider_flanger, 'Value', 0.001);
set(handles.slider_flanger2, 'Value', 1);
set(handles.slider_filter1, 'Value', 1);
set(handles.slider_filter2, 'Value', 1);
set(handles.slider_filter3, 'Value', 1);
set(handles.slider_wobble, 'Value', 1);
set(handles.slider_wobble2, 'Value', 0.3);
set(handles.slider_acceleration, 'Value', 1);
set(handles.slider_deceleration, 'Value', 1);

%On reset l'affichage des sliders
set(handles.text_value_amplification,'String','1');
set(handles.text_value_attenuation,'String','1');
set(handles.text_value_tremolo,'String','0.1');
set(handles.text_value_tremolo2,'String','1');
set(handles.text_value_echo,'String','5000');
set(handles.text_value_distortion,'String','0');
set(handles.text_value_distortion2,'String','1');
set(handles.text_value_flanger,'String','0.001');
set(handles.text_value_flanger2,'String','1');
set(handles.text_low,'String','1');
set(handles.text_mid,'String','1');
set(handles.text_high,'String','1');
set(handles.text_value_wobble,'String','1');
set(handles.text_value_wobble2,'String','0.2');
set(handles.text_acceleration,'String','Acceleration :');
set(handles.text_deceleration,'String','Deceleration :');


msgbox('The sound is Reset. Please select and play another sound.','Reset Message');


%FERMER LAPPLICATION
% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C=warndlg('Thank you, see you soon! <3','Closing the App'); %Pop-Up pour fermer l'appli !
uiwait(C); %on attends pour fermer que l'utilisateur termine l'action.
close all;

%SELECTION DANS LE MINI MENU
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
choice=get(hObject,'Value');

%Choix pour l'utilisateur! il peut choisir plusieurs musiques. Les musiques
%une fois initialiser sont stock� en m�moire pour pouvoir les modifier.
switch choice 
    case 2
        [y,Fs]=audioread('samples/guitar.wav');
        handles.y1=y;
        handles.y2=y;
        handles.Fs=Fs;
        handles.Fs2=Fs;
        guidata(hObject,handles); 
        
    case 3
        [y,Fs]=audioread('samples/instruments.wav');
        handles.y1=y;
        handles.y2=y;
        handles.Fs=Fs;
        handles.Fs2=Fs;
        guidata(hObject,handles); 
        
    case 4
        [y,Fs]=audioread('samples/piano.wav');
        handles.y1=y;
        handles.y2=y;
        handles.Fs=Fs;
        handles.Fs2=Fs;
        guidata(hObject,handles); 
        
    case 5
        [y,Fs]=audioread('samples/violant.wav');
        handles.y1=y;
        handles.y2=y;
        handles.Fs=Fs;
        handles.Fs2=Fs;
        guidata(hObject,handles); 
        
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%AFFICHAGE TEMPOREL
% --- Executes on button press in temporal_display.
function temporal_display_Callback(hObject, eventdata, handles)
% hObject    handle to temporal_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Affichage des signaux en temporelle.
set(handles.frequencial_display,'Value',0); %On remet � 0 le boutton radio des affichages fr�quences
axes(handles.original_wave_axes)
plot(handles.y1);
xlabel('Time'); %On nomme les axes
ylabel('Amplitude');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);
axes(handles.modified_wave_axes)
plot(handles.y2);
xlabel('Time');
ylabel('Amplitude');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);
% Hint: get(hObject,'Value') returns toggle state of temporal_display


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_echo_Callback(hObject, eventdata, handles)
% hObject    handle to slider_echo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_echo,'Value');
s = num2str(value_slider);
set(handles.text_value_echo,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_echo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_echo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET ECHO
% --- Executes on button press in echo.
function echo_Callback(hObject, eventdata, handles)
% hObject    handle to echo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recup�ration des donn�es de la musique
y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_echo,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = echoEffect(y2, handles.Fs ,value_slider);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

set(handles.text_echo,'String','ON');
set(handles.text_echo,'backgroundcolor',[0.1 .7 0]);

% --- Executes on slider movement.
function slider_distortion_Callback(hObject, eventdata, handles)
% hObject    handle to slider_distortion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_distortion,'Value');
s = num2str(value_slider);
set(handles.text_value_distortion,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_distortion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_distortion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET DISTORTION
% --- Executes on button press in distortion.
function distortion_Callback(hObject, eventdata, handles)
% hObject    handle to distortion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recup�ration des donn�es de la musique
y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_distortion,'Value');
value_slider2 = get(handles.slider_distortion2,'Value');

%Appel de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = distortion(y2, handles.Fs ,value_slider,value_slider2);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles);

set(handles.text_distortion,'String','ON');
set(handles.text_distortion,'backgroundcolor',[0.1 .7 0]);

% --- Executes on slider movement.
function slider_flanger_Callback(hObject, eventdata, handles)
% hObject    handle to slider_flanger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_flanger,'Value');
s = num2str(value_slider);
set(handles.text_value_flanger,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_flanger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_flanger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET FLANGER
% --- Executes on button press in flanger.
function flanger_Callback(hObject, eventdata, handles)
% hObject    handle to flanger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recup�ration des donn�es de la musique
y2 = handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_flanger,'Value');
value_slider2 = get(handles.slider_flanger2,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = flanger(y2, handles.Fs , value_slider , value_slider2);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

set(handles.text_flanger,'String','ON');
set(handles.text_flanger,'backgroundcolor',[0.1 .7 0]);

%AFFICHAGE FREQUENTIEL
% --- Executes on button press in frequencial_display.
function frequencial_display_Callback(hObject, eventdata, handles)
% hObject    handle to frequencial_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.temporal_display,'Value',0);
%Courbe sans effet
n = length(handles.y1) -1;  
F=0:handles.Fs/n:handles.Fs; %sampling frequency
Y = abs(fft(handles.y1));%fourier transform en valeur absolu

axes(handles.original_wave_axes)
plot(F,Y); %On affiche l'affichage fr�quentielle
xlabel('Frequency in Hz');
ylabel('Magnitude in dB');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);

%Courbe avec effet
n = length(handles.y2) -1; 
F2=0:handles.Fs2/n:handles.Fs2;
Y2 = abs(fft(handles.y2));
%L'axe modifi� par l'effet
axes(handles.modified_wave_axes)
plot(F2,Y2); %idem que pour la premi�re courbe
xlabel('Frequency in Hz');
ylabel('Magnitude in dB');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);
%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 
% Hint: get(hObject,'Value') returns toggle state of frequencial_display

%EFFET TREMOLO
% --- Executes on button press in tremolo.
function tremolo_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recup�ration des donn�es de la musique
y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_tremolo,'Value');
value_slider2 = get(handles.slider_tremolo2,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = tremolo(y2, handles.Fs ,value_slider,value_slider2);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

set(handles.text_tremolo,'String','ON');
set(handles.text_tremolo,'backgroundcolor',[0.1 .7 0]);

% --- Executes on slider movement.
function slider_tremolo_Callback(hObject, eventdata, handles)
% hObject    handle to slider_tremolo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_tremolo,'Value');
s = num2str(value_slider);
set(handles.text_value_tremolo,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_tremolo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_tremolo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET AMPLIFICATION
% --- Executes on button press in amplification.
function amplification_Callback(hObject, eventdata, handles)
% hObject    handle to amplification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recup�ration des donn�es de la musique
y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_amplification,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = amplification(y2, value_slider);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

set(handles.text_amplification,'String','ON');
set(handles.text_amplification,'backgroundcolor',[0.1 .7 0]);

% --- Executes on slider movement.
function slider_amplification_Callback(hObject, eventdata, handles)
% hObject    handle to slider_amplification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_amplification,'Value');
s = num2str(value_slider);
set(handles.text_value_amplification,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_amplification_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_amplification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET ATTENUATION
% --- Executes on button press in attenuation.
function attenuation_Callback(hObject, eventdata, handles)
% hObject    handle to attenuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Recup�ration des donn�es de la musique

y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_attenuation,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = attenuation(y2, value_slider);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

%On change l'affichage en ON !
set(handles.text_attenuation,'String','ON');
set(handles.text_attenuation,'backgroundcolor',[0.1 .7 0]);



% --- Executes on slider movement.
function slider_attenuation_Callback(hObject, eventdata, handles)
% hObject    handle to slider_attenuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_attenuation,'Value');
s = num2str(value_slider);
set(handles.text_value_attenuation,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_attenuation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_attenuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in filter_2.
function filter_2_Callback(hObject, eventdata, handles)
% hObject    handle to filter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_filter2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_filter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_filter2,'Value');
s = num2str(value_slider);
set(handles.text_mid,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_filter2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_filter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_filter1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_filter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_filter1,'Value');
s = num2str(value_slider);
set(handles.text_low,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_filter1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_filter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%EFFET WOBBLE
% --- Executes on button press in wobble.
function wobble_Callback(hObject, eventdata, handles)
% hObject    handle to wobble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_wobble,'Value');
value_slider2 = get(handles.slider_wobble2,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = wobble(y2, handles.Fs, value_slider,value_slider2);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

set(handles.text_wobble,'String','ON');
set(handles.text_wobble,'backgroundcolor',[0.1 .7 0]);

% --- Executes on slider movement.
function slider_wobble_Callback(hObject, eventdata, handles)
% hObject    handle to slider_wobble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_wobble,'Value');
s = num2str(value_slider);
set(handles.text_value_wobble,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_wobble_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_wobble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%LOW MID ET HIGH FILTER (les 3 en meme temps)
% --- Executes on button press in filter_1.
function filter_1_Callback(hObject, eventdata, handles)
% hObject    handle to filter_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Recup�ration des donn�es de la musique
y2=handles.y2;
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_filter1,'Value');
value_slider2 = get(handles.slider_filter2,'Value');
value_slider3 = get(handles.slider_filter3,'Value');

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav.
value_data = filter1(y2, handles.Fs2 ,value_slider, value_slider2, value_slider3,handles);
%On recopie de nouveau dans les donn�es !
handles.y2= value_data;

%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles); 

%On change l'affichage en ON !
set(handles.text_filter1,'String','ON');
set(handles.text_filter1,'backgroundcolor',[0.1 .7 0]);

%BOUTTON SAUVEGARDE DU FICHIER WAV
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name,path_name]=uiputfile('.wave','Save the new sound file','new_music.wav');
wave_path=fullfile(path_name,file_name);
audiowrite(wave_path,handles.y2,handles.Fs2);

%NE MARCHE QUE SI ON A IMPORTE LA LIB DE MATLAB
%export_fig(handles.modified_wave_axes, 'modifiedWave.png');
%export_fig(handles.original_wave_axes, 'OriginalWave.png');
%export_fig(handles.bode_axes, 'bodeWave.png');

msgbox('The sound is Saved. Please select and play another sound.','Saved');

% --- Executes on slider movement.
function slider_tremolo2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_tremolo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_tremolo2,'Value');
s = num2str(value_slider);
set(handles.text_value_tremolo2,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_tremolo2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_tremolo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_distortion2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_distortion2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_distortion2,'Value');
s = num2str(value_slider);
set(handles.text_value_distortion2,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_distortion2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_distortion2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_flanger2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_flanger2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_flanger2,'Value');
s = num2str(value_slider);
set(handles.text_value_flanger2,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_flanger2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_flanger2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%SLIDER POUR LA DECELERATION DE LA MUSIQUE
% --- Executes on slider movement.
function slider_deceleration_Callback(hObject, eventdata, handles)
% hObject    handle to slider_deceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_deceleration,'Value');
value_slider = round(value_slider);
%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav. On prend FS cette fois ci ! 
value_data = filter(1,value_slider,handles.Fs);
%On recopie de nouveau dans les donn�es !
handles.Fs2= value_data;

s = num2str(value_slider);
s1 = strcat('Deceleration :','  /', s);
set(handles.text_deceleration,'String',s1);
%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_deceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_deceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%SLIDER DE LACCELERATION
% --- Executes on slider movement.
function slider_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to slider_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%R�cup�ration du positionnement du slider!
value_slider = get(handles.slider_acceleration,'Value');
value_slider = round(value_slider);

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav. IDem que pour la decceleation en utilisant Fs
value_data = filter(value_slider,1,handles.Fs);
%On recopie de nouveau dans les donn�es !
handles.Fs2= value_data;

s = num2str(value_slider);
s1 = strcat('Acceleration :','  x', s);
set(handles.text_acceleration,'String',s1);
%On enregistre toutes ses nouvelles donn�es!
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function slider_acceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_filter3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_filter3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_filter3,'Value');
s = num2str(value_slider);
set(handles.text_high,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_filter3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_filter3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_wobble2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_wobble2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value_slider = get(handles.slider_wobble2,'Value');
s = num2str(value_slider);
set(handles.text_value_wobble2,'String',s);

% --- Executes during object creation, after setting all properties.
function slider_wobble2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_wobble2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end