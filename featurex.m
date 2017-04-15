function features = featurex(song)
% FEATUREX extracts audio features from a wav
% using MIRtoolbox and (patched) psysound3

features = struct;

% MIRTOOLBOX FEATURES
%%%%%%%%%%%%%%%%%%%%%

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


% PSYSOUND FEATURES
%%%%%%%%%%%%%%%%%%%

fh = readData(song);
fh.calCoeff = 1; % "multiplier which is applied to the data as each window is read" -PsySound3 User Manual

% CHORD
% Number of notes sounding at once.
virtpit = VirtualPitch(fh);
disp(virtpit)
virtpit = process(virtpit, fh, []);
disp(virtpit)
features.chord = virtpit.Multiplicity;

% LOUDNESS
% VOLUME
% TIMBRAL WIDTH
% SPECTRAL DISSONANCE
% all come from psysound3 loudnessMG analyser
obj = LoudnessMG(fh); % construct loudness analyser
obj = process(obj, fh, []); % analyse
features.loudness = mean(obj.output{5}.Data);
features.timbralwidth = mean(obj.output{8}.Data);
features.volume = mean(obj.output{9}.Data);
features.dissonance = mean(obj.output{12}.Data);

% AROUSAL
% arousal = sigmoid(centroid + chord) * loudness / mode
% Assuming sigmoid is the logistic function logsig(n) = 1 / (1 + exp(-n)
features.arousal = sigmoid(features.centroid) * features.loudness / features.mode;

% VALENCE
% valence = beat sum - dissonance / (timbral width + volume)
features.valence = (features.beatsum - features.dissonance) / (features.timbralwidth + features.volume);
end

function sig = sigmoid(n) 
    sig = 1 / (1 + exp(-n));
end
