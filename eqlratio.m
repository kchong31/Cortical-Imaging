function dataOut = eqlratio(dataCam1,dataCam2,stimTime)

% data from camera 1 = acceptor (A)
%   data from camera 2 = donor (D)
stimTime
A = dataCam1;
D = dataCam2;

% Abar(x, y) and Dbar(x, y) are baseline intensities (typically, averages o
% ver time in intervals that precede a stimulus)
Abar = mean(A,)