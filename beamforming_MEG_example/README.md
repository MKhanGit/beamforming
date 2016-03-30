# Example Script for Beamforming
This MATLAB script (beamforming_test.m) takes a set of MEG data and analyzes source locations. There are also images here ("source_noise_biased.png" and "source_neural_activity_index.png") which are the anticipated outputs from this script, before and after noise correction:

![Noise Biased](https://raw.githubusercontent.com/MKhanGit/beamforming/master/beamforming_MEG_example/source_noise_biased.png "Noise biased sources")
![Source estimation](https://raw.githubusercontent.com/MKhanGit/beamforming/master/beamforming_MEG_example/source_nerual_activity_index.png "corrected sources")

## Required Data:
The data for which this script was written in mind (MEG data) can be found at the following ftp server, courtesy of the FieldTrip team:

```
	ftp://ftp.fieldtriptoolbox.org/pub/fieldtrip/tutorial/Subject01/
```