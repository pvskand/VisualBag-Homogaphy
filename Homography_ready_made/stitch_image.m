
function mosaic = stitch_image( im1, im2, h)

mosaic = im1;
mosaic = padarray(mosaic, [0 size(im2, 2)], 'post');
mosaic = padarray(mosaic, [size(im2, 1) 0], 'both');
alpha = 1;
count = 1/(size(mosaic, 1)*size(mosaic, 2));
for i = 1:size(mosaic, 2)
    for j = 1:size(mosaic, 1)
        p1 = [i; j-round(size(im2, 1)); 1];
        
        p2 = h * p1;
        p2 = p2 ./ p2(3);

        x2 = round(p2(1));
        y2 = round(p2(2));

        if x2 > 0 && x2 <= size(im2, 2) && y2 > 0 && y2 <= size(im2, 1) && j-round(size(im2, 1))>0
            mosaic(j, i) = mosaic(j-round(size(im2, 1)), i)*(1-alpha) + (alpha)*im2(y2, x2);
            alpha = alpha - count;
        end
    end
    
end




