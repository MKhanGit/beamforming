%%Define BDF file parameters
%File and trigger names
EEG_DATASET = 'mTBI_P05.bdf';
EVENT_TYPE = 'STATUS';

%Define trial triggers
PRESTIM = 0.5;			%prestim latency (seconds)
EVENTSTIM_TRIGGER = 30;	%deviant tone trigger, see notes
POSTSTIM = 1;			%poststim latency (seconds)

electrode_template = ft_read_sens('biosemi.txt');	%this was custom made using data available from Biosemi
electrode_template = electrode_realign;
%%Run ft_definetrial and ft_preprocessing
cfg = [];
cfg.dataset = EEG_DATASET;

cfg.trialdef.eventtype  = EVENT_TYPE;
cfg.trialdef.eventvalue = EVENTSTIM_TRIGGER;
cfg.trialdef.prestim    = PRESTIM;
cfg.trialdef.poststim   = POSTSTIM;
cfg = ft_definetrial(cfg); 
cfg.trl(6:end,:) = [];
cfg.channel   = {'EEG'};      
cfg.demean    = 'yes'; 
data_raw = ft_preprocessing(cfg);

%Relabel electrode sites to match electrode template file
elecs = {'Fp1','AF7','AF3','F1','F3','F5','F7','FT7','FC5','FC3','FC1'...
    ,'C1','C3','C5','T7','TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7'...
    ,'PO3','O1','Iz','Oz','POz','Pz','CPz','Fpz','Fp2','AF8','AF4','AFz','Fz'...
    ,'F2','F4','F6','F8','FT8','FC6','FC4','FC2','FCz','Cz','C2','C4','C6','T8'...
    ,'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'};
data_raw.hdr.label(1:64) = elecs';

% Use only eeg channels
cfg = [];
cfg.channel = 'eeg';
cfg.elec = electrode_template;
data_raw = ft_preprocessing(cfg, data_raw);


%%Set up Time Windows of Interest
cfg = [];                                           
cfg.toilim = [-0.5 0];                       
dataPre = ft_redefinetrial(cfg, data_raw);
   
cfg.toilim = [0 1];                       
dataPost = ft_redefinetrial(cfg, data_raw);

dataPost.hdr.label(1:64) = elecs';