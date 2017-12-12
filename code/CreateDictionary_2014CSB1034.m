function [idx,C,sumd, hog_feature, label] = CreateDictionary_2014CSB1034()

% Read FashionMnist Images

total = csvread('fashion-mnist_train.csv', 1, 0);
M = csvread('fashion-mnist_train.csv', 1, 1);
label = total(:, 1);
samples = 60000;
A = reshape(M, [samples, 28, 28]);
hog_feature = [];
train_labels = [];
for i=1:samples
    B(:, :) = A(i, :, :);
    points = detectHarrisFeatures(B, 'MinQuality', 0.01);
    [hog1] = extractHOGFeatures(B, points,'CellSize',[3 3]);
    hog_feature = [hog_feature; hog1];
    for j =1:size(hog1, 1)
        train_labels = [train_labels;i];
    end
end



% K-Means clustering on the features

% Applying elbow method to find the optimal cluster
    % ssd = zeros(15, 1);
    % for k = 1:2:250
    %     [idx,C,sumd] = kmeans_clustering(hog_feature,k);
    %     ssd(k, 1) = sum(sumd);
    %     save('ssd.mat', 'ssd')
    %     fprintf('Finished %d\n', k);
    % end
    % 
    % figure;
    % plot(1:15, ssd, 'b--o');

% Best representation at k = 200

[idx,C,sumd] = kmeans_clustering(hog_feature,200);


end