function [assi_index,centroids, sumd] = kmeans_clustering_2014CSB1034(hog_feature,k)
    
    [centroids] = datasample(hog_feature,k);
    assi_index = zeros(size(hog_feature, 1), 1);
    
    while 1
        for i=1:size(hog_feature, 1)
            % find minimum cluster
            min_score = 10^10;
            cluster = -1;
            for j = 1:size(centroids, 1)
                euc = (hog_feature(i, :) - centroids(j, :)).*(hog_feature(i, :) - centroids(j, :));
                euc = sum(euc);
                euc = sqrt(euc);
                if euc < min_score
                    min_score = euc;
                    cluster = j; 
                end
            end
            assi_index(i, 1) = cluster;

        end
        % update clusters
        count_updates = 0;
        threshold = 0.001;
        for i = 1:k
            clus = find(assi_index == i);
            temp = zeros(1, size(centroids, 2));
            for j = 1:size(clus)
                temp = temp + hog_feature(clus(j), :);
            end
            temp = temp / size(clus, 1);
%             MatchHistogram(centroids(i, :), temp, 'euc')
            if MatchHistogram(centroids(i, :), temp, 'euc') <= threshold
                count_updates = count_updates + 1;
            end
            centroids(i, :) = temp;
        end
        if count_updates == k
            break;
        end
    end
    % find sumd - sum of distances between each cluster
    sumd = zeros(k, 1);
    for i = 1:k
        clus = find(assi_index == i);
        dist = 0;
        for j=1:size(clus, 1)
            dist = dist + MatchHistogram(centroids(i, :), hog_feature(clus(j), :), 'euc')
        end
        sumd(i, 1)  = dist;
    end
    
end