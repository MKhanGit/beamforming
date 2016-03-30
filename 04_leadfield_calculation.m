%Computing Lead field
cfg                 = [];
cfg.elec            = electrode_template;
cfg.channel         = 'eeg';
cfg.headmodel       = headmodel;
cfg.reducerank      = 2;
cfg.grid.resolution = 1;   % use a 3-D grid with a 1 cm resolution
cfg.grid.unit       = 'cm';
[grid] = ft_prepare_leadfield(cfg);