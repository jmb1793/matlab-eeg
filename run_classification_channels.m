function run_classification()
% Scripts to manipulate EEG data
%
% by Bruno Melo (bruno.raphael@gmail.com)

% Preparing components (eeglab, matlab-utils)
includeDeps;
clc;

%% Setup of processing
config = setup('neutral_length', 10);

config.ignore = {
    1,  [48]
    2,  [18 48]
    3,  [49]
    4,  [9 10 20 31 44 45 54 59]
    5,  [31 34]
    6,  [32 41 63]
    9,  [48]
    10, [13 59]
    13, [27]
    14, [29 56]
};

config.patts = {'eeg_feats' 'power_feats' 'erders_feats' 'dens_feats'};
config.features = {'median' 'max' 'min' 'rms' 'std'};

config.cross.type = 'montecarlo';
config.cross.k = 4;
config.cross.repetitions = 100;

% For feature selection
config.featselection = 1;

config.subjs = [1 2 3 8 9];
config.outdir = 'STATS/CLASSIFICATION/ANN/CHANNELS';

auxchs = load('channels');
auxchs = auxchs.channels;
for k=4:31
    config.prefix = sprintf('%02d_%s_', k, auxchs{k});
    
    config.channels = {
        [8 13],  {auxchs{k}}
        [13 26], {auxchs{k}}
        [26 45], {auxchs{k}}
    };
    
    neural_network(config);
end
%neural_network_intersubjs(config);


