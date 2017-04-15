# mir
Music Information Retrieval

This repository contains project code for CSC 475: Music Information Retrieval.

# Setup
This project depends on
[MIRtoolbox](https://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mirtoolbox).
You will need to install it from the link provided here.We used MIRtoolbox
1.6.2, the latest at the time of this project.

After hours wasted trying to patch
[PsySound3](https://github.com/densilcabrera/psysound3) so that it would play
nice with MIRtoolbox (spoiler: they do *not* like each other), we eventually
just added the necessary components of PsySound3 directly to this project's
repo. You may still need to install the Signal Processing Toolkit add-on to
make the PsySound3 code.

# Scripts
featurex.m extracts a feature vector from a single wav file in the current directory.

va.m extracts valence and arousal features from a folder of wav files.

plotva.m plots the results from va.m.

To create a valence-arousal plot of a directory of songs:

  [v, a, dn] = va('.'); % or va('/home/user/mirsounds');
  plotva(v, a, dn); % dn are the filenames
