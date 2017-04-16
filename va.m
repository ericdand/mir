function [ v, a, dn ] = va(folder)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Get filenames.
dd = dir([folder filesep '*.wav']);

% Compute valence and arousal for all songs in folder.
n = length(dd);
v = zeros(1,n); % valence
a = zeros(1,n); % arousal
dn = cell(1, n);
for i = 1:n
    name = [dd(i).folder filesep dd(i).name];
    f = featurex(name);
    v(i) = f.valence;
    a(i) = f.arousal;
    dn{i} = name;
end
end