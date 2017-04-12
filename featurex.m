function features = aafeaturex(song)
% FEATUREX extracts audio features from a wav
% using MIRtoolbox and (patched) psysound3

features = struct;

s = mirspectrum(song,'Frame');

% CENTROID
c = mircentroid(s);
stats = mirstat(c);
features.centroid = stats.Mean;

% MODE (TONALITY)
% major-minor modality
features.mode = mirgetdata(mirmode(song));

% BEAT SUM
% sum of beat histogram
% beat histogram is the autocorrelation of RMS
rms = mirrms(song,'frame');
bh = mirautocor(rms);
features.beatsum = sum(mirgetdata(bh));

% CHORD
% Number of notes sounding at once, most likely.

% LOUDNESS
% VOLUME
% TIMBRAL WIDTH
% SPECTRAL DISSONANCE
% all come from psysound3 loudnessMG analyser
fh = readData(song);
fh.calCoeff = 1; % "multiplier which is applied to the data as each window is read" -PsySound3 User Manual
obj = LoudnessMG(fh); % construct loudness analyser
disp(obj)
obj = process(obj, fh, []); % analyse
disp(obj)
features.loudness = mean(obj.output{5}.Data);
features.timbralwidth = mean(obj.output{8}.Data);
features.volume = mean(obj.output{9}.Data);
features.dissonance = mean(obj.output{12}.Data);

disp(features)

function sig = sigmoid(n) 
    sig = 1 / (1 + exp(-n));
end

% AROUSAL
% arousal = sigmoid(centroid + chord) * loudness / mode
% Assuming sigmoid is the logistic function logsig(n) = 1 / (1 + exp(-n)
features.arousal = sigmoid(features.centroid) * features.loudness / features.mode;

% VALENCE
% valence = beat sum - dissonance / (timbral width + volume)
features.valence = (features.beatsum - features.dissonance) / (features.timbralwidth + features.volume);

disp(features)

end