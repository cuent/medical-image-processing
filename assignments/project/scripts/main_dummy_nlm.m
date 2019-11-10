clear all; close all
addpath(genpath('..'))

% Image
I=imread('data/test.jpg');
% I = rgb2gray(I);
subplot(1,2,1); imshow(I); title('Original');

I = imnoise(I,'gaussian',0,0.01);
subplot(1,2,2) ; imshow(I); title(['Noise ' num2str(0.01)]);
saveas(gcf,'results/test_nlm.png')

% Execute NLM
figure;
n_plots = 1;
time = zeros(8,1);
results=zeros([8 size(I)]);

% parameters NLM
M = 5; a = 1;
d=1;
% for d=2:5
    for h=1:14:100
        tic;
        result=nlm(I, d, M, h, a);
        time(n_plots) = toc;
        
        results(n_plots,:,:,:) = result;
        subplot(2,4,n_plots); imshow(result); title(['h = ' num2str(h)]);% ' d = ' num2str(d)]);
        n_plots = n_plots + 1 ;
    end
% end
fprintf("NLM-filter took %.4f sec\n", mean(time))
saveas(gcf,'results/test_results_dh_nlm.png')

% store environment
filename = 'env/test-nlm.mat';
save(filename)
