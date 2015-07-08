function [out,outFilt,outROI,imagefilt,time] = batchVSFP(day,files)

% Function to perform some kind of calculation or processing on batches of
% VSFP image files.
% 
% Usage:
%   out = batchVSFP(fileNames, proc)
%
% fileNames must be 
%
% Options for proc
%   'avg' = average of (hopefully preprocessed image files
%   'div' = division of image files (not implemented) yet...
%   'pre' = preprocess included image files
%   'post' = post-process image files (detrending/demean)
%   'ROI1' = generate and ROI of window (based on precense of HR in signal)
%   'ROI2' = generates ROI based on user selected window


% Version Control (1.1 updated on 6/22/15 - AEM)
% out = struct('Version','v1.1','date',date);

%% Cases

% if strcmp(proc,'avg') == 1

    
%% 
disp('Processing 1st file')
 [imgs140, ~] = preProcVSFP(day,files(1));
 imageDR0 = imgs140.imgDivDetrend;
 imageDR0filt = imgs140.imgDivFilt;
 imageDR0ROI = imgs140.imgROI;
 clear imgs140
disp('Processing 2nd file')
 [imgs141, ~] = preProcVSFP(day,files(2));
 imageDR1 = imgs141.imgDivDetrend;
 imageDR1filt = imgs141.imgDivFilt;
 imageDR1ROI = imgs141.imgROI;
 clear imgs141
disp('Processing 3rd file')
 [imgs142, ~] = preProcVSFP(day,files(3));
 imageDR2 = imgs142.imgDivDetrend;
 imageDR2filt = imgs142.imgDivFilt;
 imageDR2ROI = imgs142.imgROI;
 clear imgs142
disp('Processing 4th file')
 [imgs143, ~] = preProcVSFP(day,files(4));
 imageDR3 = imgs143.imgDivDetrend;
 imageDR3filt = imgs143.imgDivFilt;
 imageDR3ROI = imgs143.imgROI;
 clear imgs143
disp('Processing 5th file')
 [imgs144, time] = preProcVSFP(day,files(5));
 imageDR4 = imgs144.imgDivDetrend;
 imageDR4filt = imgs144.imgDivFilt;
 imageDR4ROI = imgs144.imgROI;
 clear imgs144
 
 out = imageDR0+imageDR1+imageDR2+imageDR3+imageDR4;
 outFilt = imageDR0filt+imageDR1filt+imageDR2filt+imageDR3filt+imageDR4filt;
 outROI = imageDR0ROI+imageDR1ROI+imageDR2ROI+imageDR3ROI+imageDR4ROI;
 
 imagefilt(1,:) = squeeze(imageDR0filt(60,70,1:2000));
 imagefilt(2,:) = squeeze(imageDR1filt(60,70,1:2000));
 imagefilt(3,:) = squeeze(imageDR2filt(60,70,1:2000));
 imagefilt(4,:) = squeeze(imageDR3filt(60,70,1:2000));
 imagefilt(5,:) = squeeze(imageDR4filt(60,70,1:2000));
 
 
