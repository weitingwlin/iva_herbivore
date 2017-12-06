%% Set up working folder and utility path

%% Get current machine name
[stt, strout] =system('hostname');

%%% set working directory and path
if strncmp(strout, 'weitingde',7)
    cd '/Users/weitinglin/Dropbox/PhD_projects/herbivore_SG_Iva/mfiles'
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl/mfiles'
    rdatapath =  '/Users/weitinglin/Dropbox/PhD_projects/herbivore_SG_Iva/Rfiles/data/';
    datapath = '/Users/weitinglin/Dropbox/PhD_projects/herbivore_SG_Iva/mfiles/data/';
end

% PC; home
if strncmp(strout, 'wlin_pc',5)
        cd  'C:\Users\Wei-Ting\Dropbox\PhD_projects\herbivore_SG_Iva\mfiles'
        addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\utility_wtl\mfiles'
        rdatapath =  'C:\Users\Wei-Ting\Dropbox\PhD_projects\herbivore_SG_Iva\Rfiles\data\';
        datapath =  'C:\Users\Wei-Ting\Dropbox\PhD_projects\herbivore_SG_Iva\mfiles\data\';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stt strout