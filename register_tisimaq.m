
fclose all;
close all;
clear all;
clc;



path = '';
filename = 'TISImaq_R2013_';
adapter = 'tisimaq_r2013_';

b =  strfind(mexext, '64')

if isempty(b)
    path = 'C:\Program Files (x86)\TIS IMAQ for MATLAB R2013b\win32\';
    filename = strcat(path,filename,'32.dll');
    adapter = strcat(adapter,'32');
else
    path = 'C:\Program Files (x86)\TIS IMAQ for MATLAB R2013b\x64\';
    filename = strcat(path,filename,'64.dll');
    adapter = strcat(adapter,'64');
end

filename = replace(filename,"\","\\") 

try
    objs = imaqhwinfo(adapter);                % get installed imaq hardware info

    fprintf('Unegister DLL file:\n');
    fprintf(filename);
    fprintf( '\n' );
    imaqregister(filename,'unregister');
catch exception
    fprintf('Register DLL file:\n');
    fprintf(filename);
    fprintf( '\n' );
    imaqregister(filename);
    fprintf( ['Installed Adaptor: ', adapter, '\n'] );
end

fprintf( 'done.\n' );

    
