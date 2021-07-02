%Vanessa Silbar
%6/29/2021, Static imaging for fluorescence chamber 

clear all
close all
warning('off', 'MATLAB:MKDIR:DirectoryExists');

%read in txt file with name of exp, directory, etc
%find how many sessions are already completed 
%in a folder labeled session + 1, take 5 images

disp('Calculating Session...');
curr_path = pwd;

settings_txt = readtable('Settings.txt','Delimiter',':','format','auto');

exp_name = char(settings_txt{1,2});
mkdir(fullfile(curr_path, 'Data', exp_name));

exp_path = fullfile(curr_path, 'Data', exp_name);

exp_dir = dir(exp_path);
dirFlags = [exp_dir.isdir];
exp_dir = exp_dir(dirFlags);
exp_dir(ismember( {exp_dir.name}, {'.', '..'})) = [];

session = length(exp_dir) + 1;        %adding a new session

%turn on labjack, wait 10 seconds
LabJack_cycle(0,5);   %DAC0, 5 volts
pause(10);

%take images
take_image_burst_new(session, exp_path, settings_txt);

%turn off labjack
LabJack_cycle(0,0);   %DAC0, 0 volts


disp("Done")

