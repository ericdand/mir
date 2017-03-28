function features = aafeaturex(song)

features = mirstruct;

features.tmp.s = mirspectrum(song,'Frame');

% CENTROID
c = mircentroid(features.tmp.s);
features.centroid = mirmean(c');
% WHY THE SHIT DOESN'T THIS WORK AS EXPECTED
%stats = mirstat(c);
%features.centroid = stats.Mean;

% CHORD
% Number of notes sounding at once, most likely.

% LOUDNESS
% Loudness is measured on the ERB scale.

% TONALITY
% major-minor modality
features.mode = mirgetdata(mirmode(song));

% BEAT SUM
% sum of beat histogram
% beat histogram is the autocorrelation of RMS
rms = mirrms(song,'frame');
bh = mirautocor(rms);
features.beatsum = sum(mirgetdata(bh));

% SPECTRAL DISSONANCE
r = mirroughness(features.tmp.s);
features.dissonance =  mirgetdata(mirmean(r));

% VOLUME
% http://stackoverflow.com/questions/9018771/how-to-best-determine-volume-of-a-signal
% http://dsp.stackexchange.com/questions/290/getting-loudness-of-a-track-with-rms
% RMS
features.volume = mirgetdata(mirrms(song));