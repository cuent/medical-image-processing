clear all; close all
addpath(genpath('..'));

load T1_T2_PD.mat;
img = zeros([size(pd), 3]);
img(:,:,1) = pd;
img(:,:,2) = t1;
img(:,:,3) = t2;

% % Image
I = img;
I = uint8(I*255);
subplot(1,2,1); imshow(I); title('Original');

% Add noise
I = imnoise(I,'gaussian',0,0.008);
subplot(1,2,2); imshow(I); title(['Noise ' num2str(0.08)]);

saveas(gcf,'results/brain_bnlm.png')

% Execute BNLM
figure;
n_plots = 1;
time = zeros(4,1);
results=zeros([4 size(I)]);

% parameters BNLM
M = 5; a = 1;
alpha = 1; n = 2;
% for d=2:5
    for h=1:29:100
        tic;
        result=bnlm(I, alpha, M, n, h, a);
        time(n_plots) = toc;
        
        results(n_plots,:,:,:) = result;
        subplot(2,2,n_plots); imshow(result); title(['h = ' num2str(h)]);% ' d = ' num2str(d)]);
        n_plots = n_plots + 1 ;
    end
% end

fprintf("BNLM-filter took %.4f sec\n", mean(time))
saveas(gcf,'results/brain_results_dh_bnlm.png')

% store environment
filename = 'env/brain_bnlm.mat';
save(filename)
