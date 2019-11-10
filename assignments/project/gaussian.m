function G_2D = gaussian(sigma,d)
% Obtain gaussian filter with std sigma and size |2d+1|
%     length_G = 2*d + 1; 
    G_v = -d:d ; 
    G = 100.*exp(-G_v.^2/2/sigma^2); 
    G = G/sum(G);
    G_2D = G'*G;
end

