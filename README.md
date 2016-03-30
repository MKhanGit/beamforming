# Dipole source localization from EEG signals using Beamforming analysis
Documentation and code for using the fieldtrip toolbox to peform beamforming analysis on EEG recordings for source localization of ERPs.

##Preprocessing
This code defines several key elements for the analysis. The "EEG_DATASET" variable notes the BDF file which contains the raw EEG data from the experiment of interest. If using the Actiview system for data collection the ERP stimulus triggers are often labelled by the 'STATUS' tag. The "EVENTSTIM_TRIGGER" variable refers to the decimal trigger value which labels the ERP stimulus for which we want to define the trials of interest. In the above code a trigger value of 30 is used, which corresponds to a deviant tone meant to invoke a P300 waveform.

Make note of the "biosemi.txt" electrode template being used, which is a custom generated electrode template file using the information found at 
```
	http://www.biosemi.com/headcap.htm
```
If you wish to verify this info or generate your own electrode positions, the above link offers an interactive Excel file which will calculate azimuth values based on head circumference (this is useful depending on the headmodel you choose to use).

Consolidating the above information, FieldTrip is able to preprocess our raw data into several trials of interest, making analysis in the next sections more organized. 

##Electrode Alignment

##Headmodel Preparation

##Leadfield Calculation

##Source localization

