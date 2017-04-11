# mir
Music Information Retrieval

This repository contains project code for CSC 475: Music Information Retrieval.

# Setup
This project depends on two MATLAB libraries:
[MIRtoolbox](https://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mirtoolbox),
and [PsySound3](https://github.com/athabasca/psysound3). The latter is a fork
of the original PsySound3 that we patched so that it would play nice with
MIRtoolbox, as we needed parts of each to extract certain features. Install the
libraries from the links provided here. We used MIRtoolbox 1.6.2, the latest at
the time of this project.

# Scripts
featurex.m extracts a feature vector from a single wav file in the current directory.

va.m extracts valence and arousal features from a folder of wav files.

plotva.m plots the results from va.m.

To create a valence-arousal plot of a directory of songs:
[v, a, dn] = va('.'); % or va('/home/user/mirsounds');
plotva(v, a, dn); % dn are the filenames
