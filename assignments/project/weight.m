function w = weight(x, kernel, h)
% weight assigned for current voxel with smoothing parameter h
% x = conv2(x.^2, kernel, 'same');
x = x.^2 .* kernel;
num = sum(sum(x));
w = exp(-num / h.^2);
end

