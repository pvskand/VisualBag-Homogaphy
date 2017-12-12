total = csvread('fashion-mnist_train.csv', 1, 0);
M = csvread('fashion-mnist_train.csv', 1, 1);
label = total(:, 1);
samples = 60000;
A = reshape(M, [samples, 28, 28]);

k= 200;
min_ind = zeros(1, k);
min_ind(:) = -1;
min_score = zeros(1, k);
min_score(:) = 10^10;
for i =1:size(hog_feature, 1)
    j = idx(i, 1);
    
    score = MatchHistogram(C(j, :), hog_feature(i, :), 'euc');
    if score < min_score(1, j)
        min_score(1, j) = score;
        min_ind(1, j) = i;
    end
    
end
nearest_cluster = [];
for i =1:size(min_ind, 2)
    j = train_labels(min_ind(1, i), 1);
    nearest_cluster = [nearest_cluster;j];
end
nearest_cluster = sort(nearest_cluster);
for i=1:size(nearest_cluster, 1)
    B(:, :) = A(i, :, :);
    points = detectHarrisFeatures(B, 'MinQuality', 0.01);
    if points.Count>0
        x = round(points.Location(1, 1));
        y = round(points.Location(1, 2));
        patch = B(x-1:x+1, y-1:y+1);
        imwrite(patch, strcat('images/', num2str(i), '.png'));
    end
end

