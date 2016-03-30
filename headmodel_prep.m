%Head model
load mri_vol_dipoli;

cfg = [];
cfg.method='singlesphere';
%vol_mm = ft_convert_units(vol,'mm');
headmodel = ft_prepare_headmodel(cfg, vol);
