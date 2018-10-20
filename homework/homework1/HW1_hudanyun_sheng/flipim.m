function flipedImage = flipim( mImage )
% Hudanyun Sheng, HW1
%   Input: an image stored as a matrix
            
%   Output: the matrix of the fliped image

figure
imshow(mImage)
title('Original Image')

sizeImage = size(mImage); % get the size of the original image
indexRow = sizeImage(1)/2; % the index of half the rows or the original image
indexCol = sizeImage(2)/2; % the index of half the columns or the original image
flipedImage = mImage; % set the initial value of the matrix of the fliped
                      % image as the same as the original one, which will
                      % autometically set, if applicable, the middle row
                      % or column unchanged (when the of number row or col 
                      % or both are odd nums)

flipedImage(1:floor(indexRow), 1:floor(indexCol), :) = ...
    mImage(ceil(indexRow+1):sizeImage(1), ceil(indexCol+1):sizeImage(2), :); % the 1st quadrant of the output is the 4th quadrant of the input

flipedImage(1:floor(indexRow), ceil(indexCol+1):sizeImage(2), :) = ...
    mImage(ceil(indexRow+1):sizeImage(1), 1:floor(indexCol), :); % the 2nd quadrant of the output is the 3rd quadrant of the input

flipedImage(ceil(indexRow+1):sizeImage(1), 1:floor(indexCol), :) = ...
    mImage(1:floor(indexRow), ceil(indexCol+1):sizeImage(2), :); % the 3rd quadrant of the output is the 2nd quadrant of the input

flipedImage(ceil(indexRow+1):sizeImage(1), ceil(indexCol+1):sizeImage(2), :) = ...
    mImage(1:floor(indexRow), 1:floor(indexCol), :); % the 4th quadrant of the output is the 1st quadrant of the input

figure
imshow(flipedImage)
title('Fliped Image')

end

