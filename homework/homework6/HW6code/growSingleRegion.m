function [ O, I_set, label ] = growSingleRegion( I, O, p, label, tau, r, c, I_set )
% input:
%     I: input image
%     O: output image label image
%     p: seed pixel
%     label: new label
%     tau: 
% id = find(I_set(:,1)==p(1) & I_set(:,2)==p(2));
% I_set(id,:) = [];%delete the seed pixel from the list

% model initializtion 
% s = double(I(p(:,1), p(:,2)));
s = double(I(p(:,1), p(:,2)));
ss = double(I(p(:,1), p(:,2)))^2;
n = 1;
tauu = tau^2;

% frontier
frontier = [];

% new label
O(p(:,1), p(:,2)) = label;

% while size(frontier,1)>0
% temp = randperm(size(frontier,1));
% p_selected = frontier(temp,:);
candidateNeighbor(1,:) = [p(1)-1, p(2)];
candidateNeighbor(2,:) = [p(1), p(2)-1];
candidateNeighbor(3,:) = [p(1)+1, p(2)];
candidateNeighbor(4,:) = [p(1), p(2)+1];
%remove those candidateNeighbor out of the range of the image
[loca,~] = find(candidateNeighbor == 0 | candidateNeighbor(:,1)>r | candidateNeighbor(:,2)>c );
candidateNeighbor(loca,:) = [];
    
%check whether the candidateNeighbor is similar to the seed pixel
if ~isempty(candidateNeighbor)
    for t = 1:size(candidateNeighbor,1)
        checkSimilar(t) = isSimilar(candidateNeighbor(1,:), I, s, ss, n, tauu);
        if checkSimilar(t) == 1
            s = s+double(I(candidateNeighbor(t,1), candidateNeighbor(t,2)));
            ss = ss+(double(I(candidateNeighbor(t,1),candidateNeighbor(t,2))))^2;
            n = n+1;
        end
    end
candidateNeighbor = candidateNeighbor((checkSimilar == 1),:);    
end

%label those pixels in the output label image, and remove the coordinates from the "to be visited" set
if ~isempty(candidateNeighbor)
    O(candidateNeighbor(:,1), candidateNeighbor(:,2)) = label;
	for t = 1:size(candidateNeighbor,1)
        [temp,~] = find(I_set(:,1)==candidateNeighbor(t,1) & I_set(:,2)==candidateNeighbor(t,2));
        I_set(temp,:) = [];
	end
    frontier = candidateNeighbor;
end  

clear candidateNeighbor
clear checkSimilar
clear checkLabeled

while ~isempty(frontier)
	temp = randperm(size(frontier,1));
	px = frontier(temp(1),:); %coordinate of picked pixel
	frontier(temp(1),:) = [];
    candidateNeighbor(1,:) = [px(1)-1, px(2)];
    candidateNeighbor(2,:) = [px(1), px(2)-1];
    candidateNeighbor(3,:) = [px(1)+1, px(2)];
    candidateNeighbor(4,:) = [px(1), px(2)+1];  
    
    %remove those candidateNeighbor out of the range of the image
    [loca,~] = find(candidateNeighbor == 0 | candidateNeighbor(:,1)>r | candidateNeighbor(:,2)>c );
    candidateNeighbor(loca,:) = [];  
    
    %check whether the candidateNeighbor has been labeled
    if ~isempty(candidateNeighbor)
        for t = 1:size(candidateNeighbor,1)
            if length( find(I_set(:,1)== candidateNeighbor(t,1) & I_set(:,2)== candidateNeighbor(t,2))) == 0
                checkLabeled(t) = 1; %labeled
            else
                checkLabeled(t) = 0; %not labeled
            end
        end
        candidateNeighbor = candidateNeighbor((checkLabeled == 0),:);
    end

    %check whether the  candidateNeighbor is similar to the seed pixel
    if ~isempty(candidateNeighbor)
        for t = 1:size(candidateNeighbor,1)
            checkSimilar(t) = isSimilar(candidateNeighbor(t,:), I, s, ss, n, tauu);
            if checkSimilar(t) == 1
                s = s+double(I(candidateNeighbor(t,1), candidateNeighbor(t,2)));
                ss = ss+(double(I(candidateNeighbor(t,1),candidateNeighbor(t,2))))^2;
                n = n+1;
            end
        end
	candidateNeighbor = candidateNeighbor((checkSimilar == 1),:);
    end


    %label those pixels in the output label image, and remove the coordinates from the "to be visited" set
    if ~isempty(candidateNeighbor) 
        O(candidateNeighbor(:,1), candidateNeighbor(:,2)) = label;
        for t = 1:size(candidateNeighbor)
            [temp,~] = find(I_set(:,1)==candidateNeighbor(t,1) & I_set(:,2)==candidateNeighbor(t,2));
            I_set(temp,:) = [];
        end
    end
    frontier = [frontier; candidateNeighbor];
    clear candidateNeighbor
    clear checkSimilar
    clear checkLabeled 
end

label = label+1;

% end

end
