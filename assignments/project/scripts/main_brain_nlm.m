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

saveas(gcf,'results/brain_nlm.png')

% Execute NLM
figure;
n_plots = 1;
time = zeros(1,1);
results=zeros([1 size(I)]);

% parameters NLM
M = 5; a = 1;
d=1;
% for d=2:5
    for h=1:29:100
        tic;
        result=nlm(I, d, M, h, a);
        time(n_plots) = toc;
        
        results(n_plots,:,:,:) = result;
        subplot(2,2,n_plots); imshow(result); title(['h = ' num2str(h)]);% ' d = ' num2str(d)]);
        n_plots = n_plots + 1 ;
    end
% end
fprintf("NLM-filter took %.4f sec\n", mean(time))
saveas(gcf,'results/brain_results_dh_nlm.png')

% store environment
filename = 'env/brain_nlm.mat';
save(filename)
