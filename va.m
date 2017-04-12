function [ v, a, dn ] = va(folder)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Switch to folder, switch back later.
prevd = pwd; 
cd(folder);

% Get filenames.
dd = dir('*.wav');
dn = {dd.name};
n = length(dd);
% Compute valence and arousal for all songs in folder.
v = zeros(1,n); % valence
a = zeros(1,n); % arousal
for i = 1:n
    f = featurex(dn{i});
    v(i) = f.valence;
    a(i) = f.arousal;
end
cd(prevd);
end