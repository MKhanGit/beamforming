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
This step is very important as the locations of the electrodes relative to the headmodel are pivotal to the correct calculation of the leadield and subsequent source estimation. The code provided here offers an interactive method of aligning, scaling and rotating the electodes set by our template file (in this case "biosemi.txt") in order to align them to our head model. The interactive script provided also allows for a responsive visualization of the alignment, which can then be saved as a .mat file for further use. Be sure to edit the alignment script to accurately reflect the headmodel being used and the electrode setup described by the raw data.

![EEG alignment](https://raw.githubusercontent.com/MKhanGit/beamforming/master/img/alignment.png "EEG alignment")

##Headmodel Preparation
The code for headmodel preparation is fairly straightforward assuming that you already have a compiled headmodel. Inlcluded in the script is a comment for how to scale the headmodel, which is useful if the units for the electrode template and the headmodel are different. If you need to create your own headmodel, FieldTrip offers comprehensive documentation for the creation of BEM and FEM headmodels:

```
	http://www.fieldtriptoolbox.org/tutorial/headmodel_eeg_bem
	http://www.fieldtriptoolbox.org/tutorial/headmodel_eeg_fem
```

##Leadfield Calculation
Arguably the most important step in the analysis process, the leadfield consolidates the electrode template and headmodel in order to  define the matrix used for sourcespace in the inverse solution. This script produces a variable "[grid]" which defines the sourcespace leadfield matrix, used to estimate dipole source locations when related back to the temporal covariance matrix given by inverse Fourier transform of a time-frequency series vector.

##Source localization
Conveniently, FieldTrip offers a built-in source analysis function (ft_sourceanalysis). The configuration for this function offers flexibility over the method used (here we are using "lcmv", linearly constrained minimum variance). This function will take the predefined leadfield ('[grid]' in this case), the electrode template and the headmodel in order to estimate where sources should be located in the headmodel based on the covariance matricies. If you have MRI anatomy available, this script also offers the "ft_sourceinterpolate" function which can interpolate the sources onto the anatomy to display heat maps of where sources are located in brainspace. Taken verbatim from the FieldTrip documentation:
```
  FT_SOURCEINTERPOLATE interpolates source activity or statistical maps onto the
  voxels or vertices of an anatomical description of the brain.  Both the functional
  and the anatomical data can either describe a volumetric 3D regular grid, a
  triangulated description of the cortical sheet or an arbitrary cloud of points.
 
  The functional data in the output data will be interpolated at the locations at
  which the anatomical data are defined. For example, if the anatomical data was
  volumetric, the output data is a volume-structure, containing the resliced source
  and the anatomical volume that can be visualized using FT_SOURCEPLOT or written to
  file using FT_SOURCEWRITE.
```
![Source estimation](https://raw.githubusercontent.com/MKhanGit/beamforming/master/beamforming_MEG_example/source_nerual_activity_index.png "Source estimation")
