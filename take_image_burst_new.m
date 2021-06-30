% Created by Samuel Freitas 10/1/2019

function take_image_burst_new(num_images, session_num, exp_path)
close all force hidden

vid=videoinput('tisimaq_r2013_64',1,'Y800 (5472x3648)');
src = getselectedsource(vid);
vid.FramesPerTrigger=num_images;
% date_var=datestr(datetime('now'));

src.AutoFunctionsROI = 'Disable';
src.ExposureAuto = 'Off';
src.Brightness = 72;
src.Contrast = 30;
src.Denoise = 0;
src.Exposure = 1/96; % .5;
src.ExposureAuto = 'off';
src.Gain = 3.96;
src.GainAuto = 'off';
src.Gamma = 100;

start(vid)
temp=getdata(vid);
y=cell(1,num_images);
for i=1:num_images
    y{i}=temp(:,:,i);
end

[~,n]=size(y);
current_path=pwd;
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