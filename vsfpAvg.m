function avgVSFP = vsfpAvg(vsfp_data, numDiv)

% Generates example traces and plots from region averages based on number of
% divisions of vsfp imaging area
%
%   Usage outTraces = vsfpPlot(vsfp_data, numDiv, plotOn)
%
%   * Must use divisions that play nicely with 100 (eg 25,50,5,10,etc)

%% create temp data for faster operations 

[d1,~,d3] = size(vsfp_data);

totalDiv = floor(d1/numDiv);
I = zeros(100,100,totalDiv);
avgVSFP = zeros(totalDiv, totalDiv, d3);
%
% if mod(numDiv,d1) ~= 0 
%     error('Number of divisions must be divisible by 100')
% end

%% Divide and Conquer

% Assuming 9 divisions 20x20
tic
i = 1;
for x = 1:totalDiv
    for y = 1:totalDiv
        avgVSFP(x,y,1:d3) = mean(mean(vsfp_data(numDiv*(x-1)+1:(numDiv*x),numDiv*(y-1)+1:(numDiv*y),:)));
%         I(numDiv*(x-1)+1:(numDiv*x),numDiv*(y-1)+1:(numDiv*y),i) = ones(numDiv);
%         i = i+1;
%         for z = 1:d3
%             avgVSFP(x,y,z) = mean(vsfp_data(:,:,z).*I(1:100,1:100,i));
%         end
    end
end
toc


