close all
clear 
clc
I = imread('tools.pgm');
figure, imshow(I), title('Original Image')

I1 = imbinarize(I);
SE1 = strel('square', 6);
I2 = imopen(I1, SE1);
figure, imshow(I2), title('Binary Image')

% I1 = filter2(fspecial('average', 3), I);
% figure, imshow(I1, [])
% 
% I2 = imbinarize(uint8(I1));
% figure, imshow(I2, [])%, title('Thresholded Image')
% 
% SE1 = strel('square', 7);
% I3 = imopen(I2, SE1);
% figure, imshow(I3, []);
