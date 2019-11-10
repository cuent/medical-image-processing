function img_filter = nlm(img, d, M, h, a)
% Apply Non local means filter
% img: 3D image
% d: length of local neighboorhod
% M: length of search volume
% h: smoothing parameter
% a: std of gaussian kernel
    [r, c, f] = size(img); 
    
    img = double(img);
    img_pad = padarray(img, [d d]);
    img_filter = zeros(r,c,f);
    gauss_kernel = gaussian(a,d);
    
    for i = d + 1 : r + d
       for j = d + 1 : c + d
           for p = 1 : f
               weights = [];
               intensities = [];

               Ni = img_pad(i-d:i+d,j-d:j+d,p);
               for vi = max(d+1, i-M) : min(r+d, i+M)
                   for vj = max(d+1, j-M):min(c+d, j+M)
                       if(vi==i && vj==j) continue; end;
                       
                       Nj = img_pad(vi-d:vi+d,vj-d:vj+d,p);

                       w = weight(Ni - Nj, gauss_kernel, h);

                       weights = [weights w];
                       intensities = [intensities img_pad(vi, vj, p)];
                   end
               end
               % normalize
               weights = weights / sum(weights);
               nlm_val = sum(weights.*intensities);
%                fprintf("%.2f/%d/%d \n",nlm_val,uint8(nlm_val),img_pad(i,j,p))
               img_filter(i-d,j-d,p) = nlm_val;
           end
       end
    end
    img_filter = uint8(img_filter);
end