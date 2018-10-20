function indicate = isSimilar(pixel, I, s, ss, n, tauu)
[r,c] = size(I);
if n == 1
	neighbor(1,:) = [pixel(1)-1, pixel(2)];
    neighbor(2,:) = [pixel(1), pixel(2)-1];
    neighbor(3,:) = [pixel(1)+1, pixel(2)];
    neighbor(4,:) = [pixel(1), pixel(2)+1];
    %remove those candidateNeighbor out of the range of the image
    [loca,~] = find(neighbor == 0 | neighbor(:,1)>r | neighbor(:,2)>c );
    neighbor(loca,:) = [];
    for i = 1:size(neighbor,1)
        s = s+double(I(neighbor(i,1), neighbor(i,2)));
        ss = ss+(double(I(neighbor(i,1), neighbor(i,2))))^2;
    end
    mu = s/(size(neighbor,1)+1);
    sigmaa = ss/(size(neighbor,1)+1)-mu^2;
else
    mu = s/n;
    sigmaa = ss/n-mu^2;
end

dd = (double(I(pixel(1), pixel(2)))-mu)^2;
if dd <= tauu*sigmaa
    indicate = 1;
else
    indicate = 0;   
end
end
