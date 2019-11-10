function [ik,jk] = partition_block(i,j,n,block_k)
%Get patition of overlapping blocks
%   TODO: clean and check partitions for alpha>2 and n>3
    if block_k==1 % left-up
        ik = i-n;
        jk = j-n;
    elseif block_k==2 % left-up
        ik = i+n;
        jk = j-n;
    elseif block_k==3 % right-up
        ik = i-n;
        jk = j+n;
    elseif block_k==4 % right-down
        ik = i+n;
        jk = j+n;
    end
end

