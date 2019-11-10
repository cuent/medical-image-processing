function img_filter = bnlm(img, alpha, M, n, h, a)
% Apply Non local means filter
% img: 3D image
% alpha: length of block
% M: length of search volume
% n: distance between centers
% h: smoothing parameter
% a: std of gaussian kernel
    if (2*alpha < n) 
        fprintf("Error: Select a greater value for n\n")
        return; end;
    
    [r, c, f] = size(img); 
    
%     block_size = 2*alpha+1;
    img = double(img);
    img_pad = padarray(img, [n n]);
    img_filter = zeros(r,c,f);
    gauss_kernel = gaussian(a,alpha);
    
    for i = 1+n+1 : r+n
       for j = 1+n+1 : c+n
           for p = 1 : f
               max_blocks = 4; it=0;
               max_iter = (round((min(r+alpha, i+M) - max(alpha+1, i-M))/n)+1) .*   ...
               (round((min(c+alpha, j+M)-max(alpha+1, j-M))/n)+1);

               weights = zeros(max_blocks,max_iter);
               intensities = zeros(max_iter,1);
               A = zeros(max_blocks,1);
               
               for vi = max(alpha+1, i-M) : n : min(r+alpha, i+M)
                   for vj = max(alpha+1, j-M): n : min(c+alpha, j+M)
                       Bj = img_pad(vi-alpha:vi+alpha, vj-alpha:vj+alpha,p);
                       
                       it = it +1;
                       intensities(it) = img_pad(vi, vj, p);
                       for block_idx=1:max_blocks
                           [ik, jk] = partition_block(i,j,alpha,block_idx);
                          
                           Bik = img_pad(ik-alpha:ik+alpha, jk-alpha:jk+alpha,p);
                           
                           w = weight(Bik - Bj, gauss_kernel, h);
                           
                           weights(block_idx, it) = w;
                           
                       end
                   end
               end
               
               for b_ik=1:max_blocks
                   weights(b_ik,:) = weights(b_ik,:) / sum(weights(b_ik,:));
                   A(b_ik) = sum(weights(b_ik,:) .* intensities');
               end
               img_filter(i-n,j-n,p) = mean(A);
           end
       end
    end
    img_filter = uint8(img_filter);
end