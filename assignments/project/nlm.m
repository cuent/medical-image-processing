function [img_filter,img_filter2] = nlm(img, d, M, h, a)
% Apply Non local means filter
% img: 3D image
% d: length of local neighboorhod
% M: length of search volume
% h: smoothing parameter
% a: std of gaussian kernel
% img_filter2 : improvement 1 applied 
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
                       
                       % adjustment 1;
                       beta=0.9;                        %random value close to 1
                       omega=Ni*Nj;                     %cubic grid
                       sig = sigma(nlm_val,intensities, omega);                       
                       w2 = weight2(Ni - Nj, gauss_kernel, beta, sig, Ni)
                       weights2 =[weights2 w2];
                       
                   end
               end
               % normalize
               weights = weights / sum(weights);
               weight2=weight2/sum(weights2);           %improvement 1
               nlm_val = sum(weights.*intensities);               
               img_filter(i-d,j-d,p) = nlm_val;    
               nlm_val2 = sum(weights2.*intensities);   %improvement 1            
               img_filter2(i-d,j-d,p) = nlm_val2;       %improvement 1
           end
       end
    end
    img_filter = uint8(img_filter);
    img_filter2 = uint8(img_filter2);                   %improvement 1
end
