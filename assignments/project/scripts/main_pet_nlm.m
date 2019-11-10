clear all; close all
addpath(genpath('..'))

% Image
I=imread('data/PET_image.jpg');
subplot(1,3,1); imshow(I); title('Original');

%resize
I = imresize(I, .2);
subplot(1,3,2); imshow(I); title('Resized');

% Add noise
I = imnoise(I,'gaussian',0,0.008);
subplot(1,3,3); imshow(I); title(['Noise ' num2str(0.08)]);

saveas(gcf,'results/pet_nlm.png')

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
saveas(gcf,'results/pet_results_dh_nlm.png')

% store environment
filename = 'env/pet_nlm.mat';
save(filename)
