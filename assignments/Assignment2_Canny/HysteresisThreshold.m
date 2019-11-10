
function BinaryEdgeImage = HysteresisThreshold(magnitudeImage,minThresh,maxThresh)

% Write your function here
img_th = magnitudeImage > minThresh; % select points above min thresh
[row, col] = find(magnitudeImage > maxThresh); % coords for points max thresh
% track connected points from above thresh and add the points above min thresh
% bwselect: returns a binary image containing the objects that overlap the pixel (R,C)
BinaryEdgeImage = bwselect(img_th, col, row, 8);
