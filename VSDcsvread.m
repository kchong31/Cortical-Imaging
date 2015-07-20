% Reads Imaging files from .CSV exported via BV_Analyze files

% INPUT ARGUMENTS: VSDcsvread(filedir,noframes)
%  filedir = String containing the full file directory with extension.
%  Accepts .csv files.
%
%  noframes = number of trials averaged in one run (set during imaging).

% Generate blank matrix 100x100 x256.
% Each image frame is 100x100 pixels in size.
% Each recorded movie has exactly 256 frames (frames 0~255).

% After running this code, output:
%  Variable: imgFFM contains normalized (DeltaF / F %) image data.
%             imgFFM is a 100x100x256 size matrix, where 
%              x = x position
%              y = y position
%              z = Time slice.
%            backgroundM is a 100x100 size matrix which contains the background frame data that is
%             used to normalize each frame.
%            imgM is a 100x100x256 size matrix in the same format as imgFFM
%             containing the raw values before background subtraction.

function imgFFM = VSDcsvread(filedir,noframes)

% filedirectory = 'C:\Users\liulabuser\Documents\KKCTemp\VSD\Data\20141204\Processed(Division)\test\';
% filenames = {'test1204-529B(div)test1204-529A.csv'};

% noframes = 5; % Change this depending on how many trials were averaged in one run.
imgM = zeros(100,100,256); 
imgFFM = zeros(100,100,256);


 tempM = csvread(filedir); % Load the CSV file into one matrix. Note that this function ignores empty rows.
 tempM = tempM(:,1:100); % Cut off column of 0s on the right if it exists. BV_Analyze is weird.
 backgroundM = tempM(1:100,:); % Obtain background subtraction frame data
 tempM = tempM(101:end,:); % Cut off background subtraction data.
 imgM = reshape(transpose(tempM),100,100,256); % Keep individual values for each frame. Note this is PRE-background division.


for i = 1:256
 % Calculate the DeltaF / F (%) for each frame and store in imgFFM
 % The formula used by BV_Analyzer for dF/F%:
 %   dF/F% = -(Raw value)*100/(#frames averaged in trial*background value)
 imgM(:,:,i) = transpose(imgM(:,:,i));
 imgFFM(:,:,i) = -imgM(:,:,i)./backgroundM.*100./noframes;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you want to generate a saved PNG of each normalized matrix, uncomment
% the below code.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% arrayFFM = imgFFM(:);
% for i = 1:256
%     i = 131
%  close all;
%  varcolorsc = [median(arrayFFM)-iqr(arrayFFM) median(arrayFFM)+iqr(arrayFFM)]
% %f = figure('visible','off');
%  imagesc(imgFFM(:,:,i),varcolorsc);
%  saveas(1,[num2str(i) '.png'],'png');
% end

% To visualize individual frames, use the command:
% imagesc(imgM(:,:,FRAMENUMBER (1~256)));
% Pixels should be in the same orientation as original VSD imaging.
