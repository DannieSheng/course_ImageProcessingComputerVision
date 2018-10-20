close all
clc
dbstop if error
%%
% BW: input image
% r = 25:25:250;
% g = 0:25:225;
% b = 30:25:255;
[rows, cols] = size(I);
refImage = zeros(rows, cols);
outImage = zeros(rows, cols);
%%
[idx_obj(:,1),idx_obj(:,2)] = find(I==1); %find the index of objects

k = 1;
while ~isempty(idx_obj)
    p_traveled = findTravedP( idx_obj,I );
    outImage{1,k} = p_traveled;
    idx_obj = setdiff(idx_obj,p_traveled,'rows');
    k = k+1;
    %%
%     p_idx = randperm(size(idx_obj,1));
%     p = idx_obj(p_idx(1),:);
%     currentColor = I(p(1),p(2));
%     frontier = [];
%     neighbor(1,:) = [p(1)-1, p(2)]; %up
%     neighbor(2,:) = [p(1), p(2)-1]; %left
%     neighbor(3,:) = [p(1)+1, p(2)]; %down
%     neighbor(4,:) = [p(1)-1, p(2)]; %right
%     [idx,~] = find(neighbor == 0|neighbor(:,1) > rows | neighbor(:,2) > cols);
%     neighbor(idx,:) = [];
%     if ~isempty(neighbor)
%     for n = 1:size(neighbor,1)
%         if I(neighbor(n,1),neighbor(n,2)) ~= currentColor
%         neighbor(n,:) = [];    
%         end
%     end
%     end
%     frontier = neighbor;
%     p_traveled = [p;frontier];
%     clear neighbor
%     while ~isempty(frontier)
%         p_fromFidx = randperm(size(frontier,1));
%         p_fromF = frontier(p_fromFidx(1),:);
%         neighbor(1,:) = [p_fromF(1)-1, p_fromF(2)]; %up
%         neighbor(2,:) = [p_fromF(1), p_fromF(2)-1]; %left
%         neighbor(3,:) = [p_fromF(1)+1, p_fromF(2)]; %down
%         neighbor(4,:) = [p_fromF(1)-1, p_fromF(2)]; %right
%         [idx,~] = find(neighbor == 0|neighbor(:,1) > rows | neighbor(:,2) > cols);
%         neighbor(idx,:) = [];
%         if ~isempty(neighbor)
%             for n = 1:size(neighbor,1)
%                 if length(find(p_traveled(:,1) == neighbor(n,1) & p_traveled(:,2) == neighbor(n,2))) ~= 0
%                 neighbor(n,:) = [];
%                 end
%             end
%         end
%         if ~isempty(neighbor)
%             for n = 1:size(neighbor,1)
%                 if I(neighbor(n,1),neighbor(n,2)) ~= currentColor
%                 neighbor(n,:) = [];    
%                 end
%             end
%         end
%         frontier = neighbor;
%         p_traveled = [p;frontier];
%     end
    %%
end   
    
