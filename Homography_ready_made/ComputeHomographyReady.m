function [cropped_mosaic] = ComputeHomographyReady()
img1 = imread('yosemite1.jpg');
img2 = imread('yosemite2.jpg');
load('yosemite.mat');
p1 = [-x1(1) -y1(1) -1 0 0 0 x1(1)*x2(1) y1(1)*x2(1) x2(1);
       0 0 0 -x1(1) -y1(1) -1 x1(1)*y2(1) y1(1)*y2(1) y2(1)];
p2 = [-x1(2) -y1(2) -1 0 0 0 x1(2)*x2(2) y1(2)*x2(2) x2(2);
       0 0 0 -x1(2) -y1(2) -1 x1(2)*y2(2) y1(2)*y2(2) y2(2)];
p3 = [-x1(3) -y1(3) -1 0 0 0 x1(3)*x2(3) y1(3)*x2(3) x2(3);
       0 0 0 -x1(3) -y1(3) -1 x1(3)*y2(3) y1(3)*y2(3) y2(3)];
p4 = [-x1(4) -y1(4) -1 0 0 0 x1(4)*x2(4) y1(4)*x2(4) x2(4);
       0 0 0 -x1(4) -y1(4) -1 x1(4)*y2(4) y1(4)*y2(4) y2(4)];

P = [p1;p2;p3;p4];
[U, S, V] = svd(P);
s = V';
H = s(9, :)';
h = reshape(H, [3 3]);
h = h';

% Find lambda
p1 = [x1(1);y1(1);1];
h1 = h*p1; % applying homography
p2 = [x2(1);y2(1);1];

tform = projective2d(h');

R = imref2d(size(img1))
[img22, rb] = imwarp(img1, R, tform);

mosaic = [];
mosaic = stitch_image( img1(:, :, 1), img2(:, :, 1), h);
mosaic(:, :, 2) = stitch_image( img1(:, :, 2), img2(:, :, 2), h);
mosaic(:, :, 3) = stitch_image( img1(:, :, 3), img2(:, :, 3), h);

cropped_mosaic = [];
for i = 1:3
    mi = mosaic(:, :, i);
    [row,col] = find(mi);
    cropped=imcrop(mi, [1 1 max(col(:)) max(row(:))]);
    [row,col] = find(mi ~= 0);

    cropped=imcrop(cropped, [min(col(:)) min(row(:)) size(cropped,1) size(cropped,2)]);
    cropped_mosaic(:, :, i)= cropped;

end
cropped_mosaic = uint8(cropped_mosaic);
imshow(cropped_mosaic);
end
 

