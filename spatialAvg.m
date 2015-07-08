function outImg1 = spatialAvg(inImg,blurSize)

% Function to spatially blur images by a number of pixels specified in
% command

% Usage
%   outImg = spatialAvg(inImg, blurSize)
% 
% SUPER SLOW - READ MORE PROGRAMMING BOOKS AND REVISE - AEM 6/25/15
%
% just kidding ITS NOW FAST - Better programming... - AEM 7/7/15
% all old code moved to end under "old stuff"
% removed outImg2 from output variables 
%  

%% Check to make sure blursize is odd...
if mod(blurSize,2) ==  0
    error('blurSize must be an odd number...') 
end

%% Create required variables and data structures for processing
totalPix = blurSize^2;
bs = blurSize;
[d1, d2, lImg] = size(inImg);

if d1 ~= d2
    error('x and y dimensions of inImg must be the same');
end

newImg = zeros(d1+bs-1,d1+bs-1,lImg);
tic
offsets = zeros(totalPix,d1,d1,lImg);
C = zeros(bs);

%% Zero-Pad Edges of Image (for 3x3 averaging)
newImg(bs-1:(bs-1+99),bs-1:(bs-1+99),:) = inImg;
        
%% Build indexing matrix for offsetting images

for i = 1:bs
    C(i,1:bs) = ones(1,bs)*i;
end

A = reshape(C',1,bs^2);
B = reshape(C ,1,bs^2);
        
%% Now for the good stuff... (Fast Version 7/7/15)

for X = 1:totalPix    
    offsets(X,:,:,:) = newImg(A(X):A(X)+99,B(X):B(X)+99,:);
end

tempImg = mean(offsets);
outImg1 = reshape(tempImg,[100,100,lImg]); 

toc

end


% old stuff
% o = zeros(totalPix,lImg);
% %% Slow Version...
% for x = 1:100
%     for y = 1:100
%        i = i+1;
%         waitbar(i/(10000), progbar);
% 
% 
% % Calculate Average of Surrounding Pixels (currently 3x3 only)         
%         p = [x+1,y+1];
%         o(1,:) = squeeze(newImg(p(1),p(2),:));
%         o(2,:) = squeeze(newImg(p(1)-1,p(2),:));
%         o(3,:) = squeeze(newImg(p(1)-1,p(2)-1,:));
%         o(4,:) = squeeze(newImg(p(1)-1,p(2)+1,:));
%         o(5,:) = squeeze(newImg(p(1),p(2)-1,:));
%         o(6,:) = squeeze(newImg(p(1),p(2)+1,:));
%         o(7,:) = squeeze(newImg(p(1)+1,p(2),:));
%         o(8,:) = squeeze(newImg(p(1)+1,p(2)-1,:));
%         o(9,:) = squeeze(newImg(p(1)+1,p(2)+1,:));
%         oMean = mean(o);
% 
% % Store back in to outImg
%         outImg2(x,y,1:lImg) = oMean';
%         
%     end
% end
% toc
% isequal(outImg1(1,1,:),outImg2(1,1,:))
% close(progbar);
% outImg2 = ones(d1,d1,lImg);
% progbar = waitbar(0, 'Processing Images...');
% i=0;
%     offsets(2,:,:,:) = newImg(1:100,2:101,:);
%     offsets(3,:,:,:) = newImg(1:100,3:102,:);
%     offsets(4,:,:,:) = newImg(2:101,1:100,:);
%     offsets(5,:,:,:) = newImg(2:101,2:101,:);
%     offsets(6,:,:,:) = newImg(2:101,3:102,:);
%     offsets(7,:,:,:) = newImg(3:102,1:100,:);
%     offsets(8,:,:,:) = newImg(3:102,2:101,:);
%     offsets(9,:,:,:) = newImg(3:102,3:102,:);
