% Xavier Sumba
% Student ID: 40086818
%
% Do not change the function name. You have to write your code here
% you have to submit this function
function segmentedImage = KMeans(featureImageIn, numberofClusters, clusterCentersIn)

% Get the dimensions of the input feature image
[M, N, noF] = size(featureImageIn);
% some initialization
% if no clusterCentersIn or it is empty, randomize the clusterCentersIn
% and run kmeans several times and keep the best one
if (nargin == 3) && (~isempty(clusterCentersIn))
    NofRadomization = 1;
else
    NofRadomization = 5;    % Should be greater than one
end


segmentedImage = zeros(M, N); %initialize. This will be the output

BestDfit = 1e10;  % Just a big number!

% run KMeans NofRadomization times
for KMeanNo = 1 : NofRadomization

    % randomize if clusterCentersIn was empty
    if NofRadomization>1
        clusterCentersIn = rand(numberofClusters, noF); %randomize initialization
    end

% ----------------------------------- % 
% -You have to write your code here-- %
% ----------------------------------- %
    % L2 distance
    distance = @(a, b) sqrt(sum((a-b).^2));
    
    % convergece variables
    maxIter = 10e5;
    oldTotDistance = 0;
    it = 1;
    diff = inf;
    tolerance = 1e-9;
    
    % cluster assignments
    clusterAssignments = zeros(M, N);
    
    tic % k-means algorithm
    while diff > tolerance && it<=maxIter
        
        % For each data point x
        totDistance = 0;
        for i = 1 : M
            for j = 1 : N
                x = squeeze(featureImageIn(i,j,:))';
                % Find nearest centroid
                distances = zeros(numberofClusters, 1);
                for c = 1 : numberofClusters
                    distances(c) = distance(x, clusterCentersIn(c,:));
                end
                [minDistance, centroid] = min(distances);
                totDistance = totDistance + minDistance;
                % Assign point x to min centroid
                clusterAssignments(i,j) = centroid;
            end
        end
        
        % re-compute centroids
        for c = 1 : numberofClusters
            ind = clusterAssignments==c;
            for f = 1 : noF
                featImgChannel = featureImageIn(:,:,f);
                clusterCentersIn(c,f) = mean(featImgChannel(ind));
            end
        end
        diff = abs(oldTotDistance - totDistance);
        oldTotDistance = totDistance;
        % verbose
        % fprintf("Iteration %d total distance %0.4f diff %0.4f\n", it, totDistance, diff);
        it = it + 1;
    end
    elapsed = toc;
    
    % Model selection
    fprintf("(%d) converged (%0.2f sec) after %d ", KMeanNo, elapsed, it-1);
    fprintf("iterations with total distance %0.4f(%0.4f)\n", totDistance, diff);
    if totDistance < BestDfit
        BestDfit = totDistance;
        segmentedImage = clusterAssignments;
        fprintf("Selecting model %d with a total distance of %0.4f\n", KMeanNo, BestDfit);
    end
    fprintf("\n")
end
