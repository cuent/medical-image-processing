clear all; close all
addpath(genpath('..'))

% Image
I=imread('data/test.jpg');
% I = rgb2gray(I);
subplot(1,2,1); imshow(I); title('Original');

I = imnoise(I,'gaussian',0,0.01);
subplot(1,2,2) ; imshow(I); title(['Noise ' num2str(0.01)]);
saveas(gcf,'results/test_bnlm.png')

% Execute BNLM
figure;
n_plots = 1;
time = zeros(8,1);
results=zeros([8 size(I)]);

% parameters BNLM
M = 5; a = 1;
alpha = 1; n = 2;
for h=1:14:100
    tic;        
    result=bnlm(I, alpha, M, n, h, a);
    time(n_plots) = toc;

    results(n_plots,:,:,:) = result;
    subplot(2,4,n_plots); imshow(result); title(['h = ' num2str(h)]);
    n_plots = n_plots + 1 ;
end

fprintf("NLM-filter took %.4f sec\n", mean(time))
saveas(gcf,'results/test_results_dh_bnlm.png')

% store environment
filename = 'env/test-bnlm.mat';
save(filename)

