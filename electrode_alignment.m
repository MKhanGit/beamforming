%%Electrode Alignment
close all;
electrode_template = ft_read_sens('biosemi.txt');

load mri_vol_dipoli;

cfg = [];
cfg.method    = 'interactive';
cfg.elec      = electrode_template;
cfg.headshape = vol.bnd(1);
electrode_realign = ft_electroderealign(cfg);

save electrode_realign electrode_realign	%save output so you don't have to go through that again.

figure;hold on
ft_plot_sens(electrode_realign)
ft_plot_vol(vol)