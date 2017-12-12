%
[idx,C,sumd, hog_feature, label] = CreateDictionary_2014CSB1034();

% Test images features
total = csvread('fashion-mnist_test.csv', 1, 0);
M = csvread('fashion-mnist_test.csv', 1, 1);
test_label = total(:, 1);
samples = 10000;
test = reshape(M, [samples, 28, 28]);
% Histogram and visual dict for test images
hog_feature_test = [];
visual_dict_test = []; %zeros(size(hog_feature_test, 1), k);
k =200;
for i=1:samples
    i
    B(:, :) = test(i, :, :);
    points = detectHarrisFeatures(B, 'MinQuality', 0.01);
    [hog1] = extractHOGFeatures(B, points,'CellSize',[3 3]);
    hog_feature_test = [hog_feature_test; hog1];
    hist = zeros(1, k);
    for j = 1:size(hog1)
        histogram = ComputeHistogram(hog_feature_test(j, :), idx, C, k);
        hist = hist + histogram;
        j = j+1;
    end

    visual_dict_test = [visual_dict_test; hist];
    
end

% Histogram of training images

visual_dict = [];
curr_clus = 1;
i = 1;
count =0;
while i <= size(hog_feature, 1)
    
    hist = zeros(1, k);
    i
    while train_labels(i, 1) == curr_clus && i <= size(hog_feature, 1)
        histogram = ComputeHistogram(hog_feature(i, :), idx, C, k);
        hist = hist + histogram;
        i=i+1;
        if i > size(hog_feature, 1)
            break;
        end
    end

    visual_dict = [visual_dict; hist];
    count = count + 1;
    if i <= size(hog_feature, 1)
        curr_clus = curr_clus + 1;
    end
   
end




% Match histograms of the test samples
predicted_test_score = zeros(size(visual_dict_test, 1), 1);
for i = 1:size(visual_dict_test, 1)
    i
    predicted_label = -1;
    min_score = 10^10;
    min_ind = -1;
    for j = 1:size(visual_dict, 1)
        score = MatchHistogram(visual_dict_test(i, :), visual_dict(j, :), 'euc');
        if score < min_score
            min_score = score;
            min_ind = j;
        end
        
    end
    fprintf('%d %d\n', label(min_ind), test_label(i));
     predicted_test_score(i, 1) = label(min_ind);
end

% Calculate accuracy
count =0;
confusion_matrix = zeros(10, 10);
for i =1:size(test_label, 1)
    confusion_matrix(test_label(i, 1)+1, predicted_test_score(i, 1)+1) =  confusion_matrix(test_label(i, 1)+1, predicted_test_score(i, 1)+1)+1;
    if test_label(i, 1) == predicted_test_score(i, 1)
        count = count + 1;
    end
end
fprintf('Accuracy is : %f\n', count/size(test_label, 1));

for i = 1:10
    precision = confusion_matrix(i, i)/sum(confusion_matrix(:, i));
    recall = confusion_matrix(i, i)/sum(confusion_matrix(i, :));
   fprintf('Accuracy of class %d is %f\n', i, confusion_matrix(i, i)/sum(confusion_matrix(:, i))); 
   fprintf('Precision of class %d is %f\n', i, precision); 
   fprintf('Recall of class %d is %f\n', i, recall); 
end

