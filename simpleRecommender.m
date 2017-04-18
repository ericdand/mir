function recom = simpleRecommender(queryDir, songsetDir)
% Call va.m with the queryDir
[qa qv qn] = va(queryDir);
disp(qa);
disp(qv);
disp(qn);

% Call va.m with the songsetDir
[sa sv sn] = va(songsetDir);
disp(sa);
disp(sv);
disp(sn);

% Determine the distance between the query songs and each song in songset
% First, find the average v-a values for the query songs
qa = sum(qa)/size(qa,2);
qv = sum(qv)/size(qv,2);

% Initialize a distance array
dist = zeros(size(sn));

for i=1:size(sn,2)
    dist = euclideanDistance([qa qv],[sa(i) sv(i)]);
end

% Find minimum value
[minVal minIndex] = min(dist);
recom = sn(minIndex);
end

function ed = euclideanDistance(vec1, vec2)
    ed = pdist2(vec1,vec2);
end