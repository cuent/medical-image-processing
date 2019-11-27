%3d mri denoising
% d: length of local neighboorhod
% M: length of search volume
% h: smoothing parameter
% a: std of gaussian kernel=sd
tic
clear;clc;
load T1_T2_PD.mat;
load r_meu.mat; load r_var.mat;

InIm(:,:,1) = t1;
InIm(:,:,2) = t2;
InIm(:,:,3) = pd;
sigmahat=0.002;
mu1=0.95;mu2=1/mu1;
sigma1=0.5;sigma2=1/sigma1;
[r,c,f] = size(InIm); %rows,columns,features
noisex = imnoise(InIm,'gaussian',0,sigmahat);%noisy image
beta=0.8;
d=4;            %neighbourhood windows index
h=0.085;         %smoothing factor, optiomal value 0.5-0.75
kernel=2*d+1;   %kernal size 5x5
a=1;
t=7;
filtered_image=zeros(r,c);
noisy=padarray(noisex,[d,d],'symmetric');% symmetrically padded noisy image
%intitiate gaussian kernel
% ker=zeros(kernel,kernel);
% for i=1:kernel
%     for j=1:kernel
%         x=i-d-1;                %centre pixel, moving
%         y=j-d-1;                %vertical pixel, moving
%         ker(i,j)=exp((x.^2)+(y.^2))/(-2*a*a);
%     end
% end
% ker=ker./sum(ker);
% r_meu=[];
% r_var=[];
cnt1=1;
cnt2=1;
%pixel calculation
for k=1:f
    for I=1:r
    
    for J=1:c
        I1=I+d;     % initial value of I
        J1=J+d;     % initial value of J
        window=noisy(I1-d:I1+d, J1-d:J1+d,k);
        windowV1=window(:);         %vectorize windowV1 to find the eucliedean norm
%         window_mean1=mean(windowV1);window_var1=var(windowV1);
        v_i_min=max(I1-t, d+1); v_i_max=min(I1+t, r+d); %v_i limits
        v_j_min=max(J1-t, 1+d); v_j_max=min(J1+t, c+d); %v_J limits
        NL=0;Z=0;
        for v_i=v_i_min:v_i_max
            for v_j=v_j_min:v_j_max
                window2=noisy(v_i-d:v_i+d, v_j-d:v_j+d,k);
                windowV2=window2(:);
%                 window_mean2=mean(windowV2);
%                 window_var2=var(windowV2);
%                 ratio_meu=(window_mean1/window_mean2);
%                 r_meu(cnt1)=ratio_meu;                
%                 ratio_var=(window_var1/window_var2);
%                 r_var(cnt2)=ratio_var;
                if ((r_meu(cnt1)>mu1 && r_meu(cnt1)<mu2)&& (r_var(cnt2)>sigma1 && r_var(cnt2)<sigma2))
                    dist=norm(windowV1-windowV2);
                    distance=(dist/(2*beta*sigmahat*(2*d+1)^2));
                    weight=exp(-distance);
                else
                    weight=0;
                end
                cnt1=cnt1+1;cnt2=cnt2+1;
                Z=Z+weight;
                s_im=weight.*noisy(v_i,v_j,k); 
                NL=NL +s_im;
            end
        end        
        filtered_image(I,J,k)=NL/Z;    
    end
    
    end
end
   
figure(1), subplot(1,2,1), imshow(noisy);subplot(1,2,2), imshow(filtered_image);
toc
        
        
    