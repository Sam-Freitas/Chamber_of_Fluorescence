% Created by Samuel Freitas 10/1/2019

function take_image_burst_new(session_num, exp_path, settings)
close all force hidden

%dependent on where number of images appears in settings .txt
num_images = str2double(settings{2,2});     %number of images you want to take 

vid=videoinput('tisimaq_r2013_64',1,'Y800 (5472x3648)');
src = getselectedsource(vid);
vid.FramesPerTrigger=str2double(settings{2,2});
% date_var=datestr(datetime('now'));

%based on settings file
src.AutoFunctionsROI = 'Disable';
src.ExposureAuto = 'Off';
src.Brightness = str2double(settings{5,2});
src.Contrast =  str2double(settings{6,2});
src.Denoise = 0;
src.Exposure = str2double(settings{4,2}); %1/96 % .5;
src.ExposureAuto = 'off';
src.Gain =  str2double(settings{7,2});
src.GainAuto = 'off';
src.Gamma = 100;

start(vid)
temp=getdata(vid);
y=cell(1,num_images);
for i=1:num_images
    y{i}=temp(:,:,i);
end

[~,n]=size(y);
% current_path=pwd;
% mkdir([current_path '\session' num2str(session_num)]);
mkdir(fullfile(exp_path, ['session' num2str(session_num)]));

for i=1:n
    img_path = fullfile(exp_path, ['session' num2str(session_num)],...
        [num2str(i) '.jpg']);
    imwrite(y{i},img_path);
   % imwrite(y{i}, [current_path '\session' num2str(session_num) '\' num2str(i) '.png']);
end

% closepreview(vid);
flushdata(vid);
delete(vid);
clear vid
close all;

close all;

end