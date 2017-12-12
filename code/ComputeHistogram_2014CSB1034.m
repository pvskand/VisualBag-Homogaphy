function histogram = ComputeHistogram_2014CSB1034(feature, idx, C, k)

    histogram = zeros(k ,1);
    for i= 1:k
        for j = 1:size(feature, 1)
            histogram(i, 1) = histogram(i, 1) + sum(sqrt((feature(j, :) - C(i, :)).*(feature(j, :) - C(i, :))));
        end
    end
    histogram = histogram';
    
    histogram = 1./histogram;
    
    sum_hist = sum(histogram);
    histogram = histogram/sum_hist;

%     max_val = max(histogram);
%     histogram = max_val - histogram;
end
