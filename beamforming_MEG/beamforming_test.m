% find the interesting segments of data
cfg = [];                                           % empty configuration
cfg.dataset                 = 'Subject01.ds';       % name of CTF dataset  
cfg.trialdef.eventtype      = 'backpanel trigger';
cfg.trialdef.prestim        = 1;
cfg.trialdef.poststim       = 2;
cfg.trialdef.eventvalue     = 3;                    % event value of FIC
cfg = ft_definetrial(cfg);            
  
% remove the trials that have artifacts from the trl
cfg.trl([15, 36, 39, 42, 43, 49, 50, 81, 82, 84],:) = [];

% preprocess the data
cfg.channel   = {'MEG', '-MLP31', '-MLO12'};        % read all MEG channels except MLP31 and MLO12
cfg.demean    = 'yes';                              % do baseline correction with the complete trial

dataFIC = ft_preprocessing(cfg);

save dataFIC dataFIC

%%Time Windows

load dataFIC

cfg = [];                                           
cfg.toilim = [-0.5 0];                       
dataPre = ft_redefinetrial(cfg, dataFIC);
   
cfg.toilim = [0.8 1.3];                       
dataPost = ft_redefinetrial(cfg, dataFIC);


%%adaptive spatial filtering
cfg = [];
cfg.method    = 'mtmfft';
cfg.output    = 'powandcsd';
cfg.tapsmofrq = 4;
cfg.foilim    = [18 18];
freqPre = ft_freqanalysis(cfg, dataPre);

cfg = [];
cfg.method    = 'mtmfft';
cfg.output    = 'powandcsd';
cfg.tapsmofrq = 4;
cfg.foilim    = [18 18];
freqPost = ft_freqanalysis(cfg, dataPost);

%%lead field matrix generation

mri = ft_read_mri('Subject01.mri');
cfg = [];
cfg.write      = 'no';
[segmentedmri] = ft_volumesegment(cfg, mri);

cfg = [];
cfg.method = 'singleshell';
headmodel = ft_prepare_headmodel(cfg, segmentedmri);

%generating the grid
cfg                 = [];
cfg.grad            = freqPost.grad;
cfg.headmodel       = headmodel;
cfg.reducerank      = 2;
cfg.channel         = {'MEG','-MLP31', '-MLO12'};
cfg.grid.resolution = 1;   % use a 3-D grid with a 1 cm resolution
cfg.grid.unit       = 'cm';
[grid] = ft_prepare_leadfield(cfg);

%create power estimates for each grid point
cfg              = []; 
cfg.method       = 'dics';
cfg.frequency    = 18;  
cfg.grid         = grid; 
cfg.headmodel    = headmodel;
cfg.dics.projectnoise = 'yes';
cfg.dics.lambda       = 0;

sourcePost_nocon = ft_sourceanalysis(cfg, freqPost);

save sourcePost_nocon sourcePost_nocon
load sourcePost_nocon

mri = ft_read_mri('Subject01.mri');
mri = ft_volumereslice([], mri);

cfg            = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourcePostInt_nocon  = ft_sourceinterpolate(cfg, sourcePost_nocon , mri);

%this plot should show activity near the center of the brain.
%This comes from 18Hz noise, so we need to unbias the data.
cfg              = [];
cfg.method       = 'slice';
cfg.funparameter = 'avg.pow';
figure
ft_sourceplot(cfg,sourcePostInt_nocon);

%Nerual Activity Index for removing head-center bias (normalized power)
sourceNAI = sourcePost_nocon;
sourceNAI.avg.pow = sourcePost_nocon.avg.pow ./ sourcePost_nocon.avg.noise;
 
cfg = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourceNAIInt = ft_sourceinterpolate(cfg, sourceNAI , mri);

%improved plot using NAI
cfg = [];
cfg.method        = 'slice';
cfg.funparameter  = 'avg.pow';
cfg.maskparameter = cfg.funparameter;
cfg.funcolorlim   = [4.0 6.2];
cfg.opacitylim    = [4.0 6.2]; 
cfg.opacitymap    = 'rampup';  
figure
ft_sourceplot(cfg, sourceNAIInt);



