function [ O ] = regiongrow_seg( I, tau )
%UNTITLED2 Summary of this function goes here
%   input of this function: 
%   I: input images (intensity image)
%   output of this function:
%   L: label image 
label = 1;
[r,c] = size(I);% acquire the number of rows and colunms for the image
% L = reshape(randperm(r*c), r, c);
O = zeros(r,c);

I_set(:,1) = reshape(repmat(1:r,c,1),1,r*c);
I_set(:,2) = repmat([1:c]',r,1);
L_set = I_set;

while size(I_set,1)>0
    temp = randperm(size(I_set,1));
%     intens = xx(end,:);
%     cc(end,:) = cc(end,:)-1;
%     if cc(end,:) == 0
%         cc(end,:) = [];
%         xx(end,:) = [];
%     end
%     [candidate_p(:,1), candidate_p(:,2)] = find(I == intens);
    p = I_set(1,:); %coordinate of picked pixel
%     p = candidate_p(1,:);
%     clear candidate_p
    [O, I_set, label] = growSingleRegion(I, O, p, label, tau, r, c, I_set);
%     label = label+1;
end
end