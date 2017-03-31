function features = aafeaturex(song)

features = struct;

s = mirspectrum(song,'Frame');

% CENTROID
c = mircentroid(s);
%centroid = mirmean(c)
% WHY THE SHIT DOESN'T THIS WORK AS EXPECTED
stats = mirstat(c);
features.centroid = stats.Mean;

% CHORD
% who the fuck knows. polyphonic pitch detection reduced to a single value
% somehow? emailed Georgeo

% LOUDNESS
% VOLUME
% TIMBRAL WIDTH
% SPECTRAL DISSONANCE
% all come from psysound3 loudnessMG analyser
%fh = readData(song);
%fh.calCoeff = 1; % "multiplier which is applied to the data as each window is read" -PsySound3 User Manual
%obj = LoudnessMG(fh); % construct loudness analyser
%obj = process(obj, fh, []); % analyse
%features.loudness = obj.output{5};
%features.timbralwidth = obj.output{8};
%features.volume = obj.output{9};
%features.dissonance = obj.output{12};

% TONALITY
% major-minor modality
features.mode = mirgetdata(mirmode(song));

% BEAT SUM
% sum of beat histogram
% beat histogram is the autocorrelation of RMS
rms = mirrms(song,'frame');
bh = mirautocor(rms);
features.beatsum = sum(mirgetdata(bh));