%% Set up working folder and utility path

%% Get current machine name
[stt, strout] =system('hostname');

%%% set working directory and path
if strncmp(strout, 'weitingdeMacBook-Air.local',12)
    cd '/Users/weitinglin/Dropbox/PhD_projects/herbivore_SG_Iva'
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl/mfiles'
end

% PC; home
if strncmp(strout, 'wlin_pc',5)
        cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\herbivore_SG_Iva'
        addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\utility_wtl\mfiles'
end

% Lab; ASUS laptop
if strncmp(strout, 'ASUS-PC',5)
        cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
        addpath 'C:\Users\ASUS\Dropbox\DataCoding\utility_wtl\mfiles'
end
% cd 'C:\Users\ASUS\Dropbox\PhD_projects\Iva_field_sample\sample_2014'
% addpath 'C:\Users\ASUS\Dropbox\DataCoding\utility_wtl\mfiles'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stt strout