function recom = RecommendSimilarMusic(query, songsetDir)
% Get parts of query
[folder,name,ext] = fileparts(query);

% Determine if the query consists of a single file
if size(ext, 2) ~= 0
    fQuery = featurex(query);
else
    % If there isn't a file, get features for all .wav files in current dir
    files = dir([query filesep '*.wav']);
    n = length(files);
    fQuery = cell(1, n);
    for i = 1:n
        name = [files(i).folder filesep files(i).name];
        fQuery{i} = featurex(name);
    end
end

% Iterate through .wav files in songsetDir
songset = dir([songsetDir filesep '*.wav']);
nSongset = length(songset);
dist = zeros(1,nSongset); % dist to query cluster valence
filename = cell(1, nSongset);
for i=1:nSongset
    name = [songset(i).folder filesep songset(i).name];
    f = featurex(name);
    % Calculate EMD dist here
    filename{i} = name;
end
end

function emd = EarthMoversDistance()
% p_i (cluster)  = {(u_i, sigma_i, w_i),...},  u = mean, sigma = covariance, w = weight

% d_pq (distance) = (sigma_pi/sigma_qj) + (sigma_qj/sigma_pi) + (u_pi - u_qj)^2 * ((1/sigma_pi) + (1/sigma_qj)) 
% f_qp is flow, need to min W (cost) = sum(i=1 to m)(sum(j=1 to n)(d_pq*f_pq))
% EMD(P,Q) = (sum(i=1 to m)(sum(j=1 to n)(d_pq*f_pq)))/(sum(i=1 to m)(sum(j=1 to n)(f_pq))) 
end

function weight = ClusterWeight(x)
    hist = mirhisto(x);
    weight = get(hist, 'Weight');
end