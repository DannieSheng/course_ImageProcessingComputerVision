function p_traveled = findTravedP( idx_obj,I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [rows, cols] = size(I);
    p_idx = randperm(size(idx_obj,1));
    p = idx_obj(p_idx(1),:);
    currentColor = I(p(1),p(2));
    frontier = [];
    neighbor(1,:) = [p(1)-1, p(2)]; %up
    neighbor(2,:) = [p(1), p(2)-1]; %left
    neighbor(3,:) = [p(1)+1, p(2)]; %down
    neighbor(4,:) = [p(1)-1, p(2)]; %right
    [idx,~] = find(neighbor == 0|neighbor(:,1) > rows | neighbor(:,2) > cols);
    neighbor(idx,:) = [];
    if ~isempty(neighbor)
    for n = 1:size(neighbor,1)
        if I(neighbor(n,1),neighbor(n,2)) == currentColor
            sameColor(n) = 1; % color is the same
        else 
            sameColor(n) = 0; % color is not the same
        end
    end
    end
    neighbor = neighbor(sameColor == 1,:);
    frontier = neighbor;
    p_traveled = [p;frontier];
    clear neighbor
    clear sameColor
    while ~isempty(frontier)
        p_fromFidx = randperm(size(frontier,1));
        p_fromF = frontier(p_fromFidx(1),:);
        neighbor(1,:) = [p_fromF(1)-1, p_fromF(2)]; %up
        neighbor(2,:) = [p_fromF(1), p_fromF(2)-1]; %left
        neighbor(3,:) = [p_fromF(1)+1, p_fromF(2)]; %down
        neighbor(4,:) = [p_fromF(1)-1, p_fromF(2)]; %right
        [idx,~] = find(neighbor == 0|neighbor(:,1) > rows | neighbor(:,2) > cols);
        neighbor(idx,:) = [];
        if ~isempty(neighbor)
            for n = 1:size(neighbor,1)
                if length(find(p_traveled(:,1) == neighbor(n,1) & p_traveled(:,2) == neighbor(n,2))) == 0
                    checkTraveled(n) = 1; %not traveled
                else
                    checkTraveled(n) = 0; %traveled
                end
            end
        end
        neighbor = neighbor(checkTraveled == 1,:);
        if ~isempty(neighbor)
            for n = 1:size(neighbor,1)
                if I(neighbor(n,1),neighbor(n,2)) == currentColor
                    sameColor(n) = 1; % color is the same
                else 
                    sameColor(n) = 0; % color is not the same
                end
            end
        end
        neighbor = neighbor(sameColor==1,:);
        frontier = neighbor;
        p_traveled = [p;frontier];
    end

end

