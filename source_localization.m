%%Source Analysis
cfg              = []; 
cfg.method       = 'lcmv';
cfg.elec         = electrode_template;
cfg.channel         = 'eeg';
%cfg.frequency    = 18;  
cfg.grid         = grid; 
cfg.headmodel    = headmodel;
%cfg.dics.projectnoise = 'yes';
%cfg.dics.lambda       = 0;

sourcePost_nocon = ft_sourceanalysis(cfg, data_raw);

cfg = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourceNAIInt = ft_sourceinterpolate(cfg, sourceNAI , mri);

%Plot source estimates from NAI
cfg = [];
cfg.method        = 'slice';
cfg.funparameter  = 'avg.pow';
cfg.maskparameter = cfg.funparameter;
cfg.funcolorlim   = [4.0 6.2];
cfg.opacitylim    = [4.0 6.2]; 
cfg.opacitymap    = 'rampup';  
figure
ft_sourceplot(cfg, sourceNAIInt);