% This function will generate a 100x100 matrix of z scores above the prestimulus "spontaneous period"
% (1 z score for each of 100x100 pixels in the image).

% INPUT ARGUMENTS:
% imgFFM: 100x100x256 matrix containing normalized (DeltaF/F%) image data.
% Fs: Sampling in Hertz of imaging
% calcwin: Time window for calculating "response" peak in seconds.

% OUTPUT VARIABLES
% zmatrix: Output variable, 100x100 matrix with z scores representing distance from spontaneous rate per pixel.

% z score is calculated as the number of standard deviations above the
% spontaneous period the PEAK fluorescence is over the 1 second following
% stimulus playback.

% Note stimulus playback occurs at 0.4s.

% For VSD imaging data (extracted using the function VSDcsvread.m)
%  Variable: imgFFM contains normalized (DeltaF / F %) image data.
%            imgFFM is a 100x100x256 size matrix, where 
%              x = x position
%              y = y position
%              z = Time slice.
%  NOTE that sampling rate is contained in original metadata!

function zs_zscore = VSDpeakzscore(imgFFM,Fs,calcwin)

%% Variable initialization
% calcwin = 1; % Number of seconds after stimulus 
% Fs = 200;

% 0.a) Find the number of frames during spontaneous period given Fs (Sampling
% rate); note that the stimulus appears at 0.4s or 400ms.
t_stimonset = 0.4 * Fs; % Time at stimulus onset.

f_spontstart = 2; % Second frame is start of spontaneous window, as first frame is always all 0s
f_spontend = round(t_stimonset)-1; % Frame before stimulus onset is end of spontaneous window

% 0.b) Find the number of frames for the calculation window (over which the peak intensity will be found)
% following stimulus playback.
f_calcstart = f_spontend+1; % calculation window starts at stimulus onset frame.
f_calcend = f_calcstart + (calcwin*Fs); % Ends at #seconds for window * Fs + starting place
if f_calcend > 255
    f_calcend = 255; % There are a maximum of 256 frames per acquisition; avoiding common signal spike at last frame of recording
end

% For each pixel:

for i = 1:100 % x 1~100, fixed
 for j = 1:100 % y 1~100, fixed
% 1) Calculate spontaneous period mean and standard deviation for pixel
  zs_spont_mean(i,j) = mean(imgFFM(i,j,f_spontstart:f_spontend));
  zs_spont_std(i,j) = std(imgFFM(i,j,f_spontstart:f_spontend));
  
% 2) Find the peak image intensity over the calculation window
  zs_peakint(i,j) = max(imgFFM(i,j,f_calcstart:f_calcend));
  
% 3) Find the z-score of the corresponding pixel for that peak intensity.
  zs_zscore(i,j) = (zs_peakint(i,j) - zs_spont_mean(i,j))/zs_spont_std(i,j);

 end
end

%% Figures
% % Plotting data: Comment this out if you do not wish to see the full plots.
% %  2x2 showing: 
% %   Top Left - Mean spontaneous rate over all pixels
% %   Top Right - Spontaneous Stdev over all pixels
% %   Bottom Left - Peak intensity post stimulus over all pixels
% %   Bottom Right - Z-score over all pixels
% 
% close all;
% figure;
% hold on;
% subplot(2,2,1);
% zs_spont_meanfig = (zs_spont_mean).*mask;
% % zs_spont_meanfig = (zs_spont_meanfig - min(min(zs_spont_meanfig))).*mask;
% imagesc(zs_spont_meanfig);
% title('Mean spontaneous intensity');
% colorbar;
% 
% subplot(2,2,2);
% zs_spont_stdfig = (zs_spont_std).*mask;
% % zs_spont_stdfig = (zs_spont_stdfig - min(min(zs_spont_stdfig))).*mask;
% imagesc(zs_spont_stdfig);
% title('Spontaneous intensity stdev');
% colorbar;
% 
% subplot(2,2,3);
% zs_peakintfig = (zs_peakint).*mask;
% % zs_peakintfig = (zs_peakintfig - min(min(zs_peakintfig))).*mask;
% imagesc(zs_peakintfig);
% title('Peak intensity level post-stimulus onset');
% colorbar;
% 
% subplot(2,2,4);
% zs_zscorefig = (zs_zscore).*mask;
% % zs_zscorefig = (zs_zscorefig - min(min(zs_zscorefig))).*mask;
% imagesc(zs_zscorefig);
% title('Z-score above mean spontaneous intensity');
% colorbar;
