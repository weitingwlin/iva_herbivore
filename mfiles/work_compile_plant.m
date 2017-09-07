%% Compiling data using plant as responder
% Organising data from herbivore competition experiment in summer 2015
%
% _Wei-Ting Lin 2015/9/22_
clear;clc
%% Setting working directory
% laptop
cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_stat'
%% Load data
% * [data_aph.txt]: detail see the excel file
% columns: 1.day  2.block  3.exp  4. sp1  5. sp2  6.#L  7. #D   
%          8~17. chl    18~20. tough   
%          21. P    22. H    23.A 
 data=load('./data/data_aph.txt');  
 treatmentPlant  =  [1     1     1;  1     1     2;   1     1     3 ; 1     2     2;  1     2     3;  1     3     3; 
                      2     1     1;  2     1     2; 2     1     3;   2     2     2; 2     2     1;  2     2     3; 2     3     3;  2     3     1; 2     3     2];
 controlPlant = [0  0  0; 2     1     1;  2     1     2; 2     1     3;   2     2     2; 2     2     1;  2     2     3; 2     3     3;  2     3     1; 2     3     2]  ;
                                   % the first stage of beta experiment will serve as low density control
 %% Data sheets
 Plant_NofL = NaN(6,15);
 Plant_NofLratio = NaN(6,15);
 Plant_NofD = NaN(6,15);
 Plant_dChl = NaN(6,15);
 Plant_endChl = NaN(6,15);
 Plant_tough = NaN(6,15);
 
 PlantCtrl_NofL = NaN(6,15);
 PlantCtrl_NofLratio = NaN(6,15);
 PlantCtrl_NofD = NaN(6,15);
 PlantCtrl_dChl = NaN(6,15);
 PlantCtrl_endChl = NaN(6,15);
 PlantCtrl_tough = NaN(6,15);
 %% Treatment 
 for b = 1:6 % block
    for tr = 1:15 % treatment
            if treatmentPlant (tr,1) == 1 % alpha experment
                D1 = 1 ; D2 =7;
            else % beta experiment
                D1 = 1 ; D2 = 15; 
            end
            ind1 = find( ismember(data(:,3:5),treatmentPlant(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data
            ind2 = find( ismember(data(:,3:5),treatmentPlant(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
            
            if isempty(ind1)+isempty(ind2)==0
            % calculation
                temp1 = sort(data(ind1,8:17)); % chl data sorted
                temp2 = sort(data(ind2,8:17));
            Plant_dChl(b,tr) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
            Plant_endChl(b,tr) = mean(inlier(temp2));
            Plant_NofL(b,tr) = data(ind2,6)-data(ind1,6); % change in number of leaves
            Plant_NofLratio(b,tr)  = Plant_NofL(b,tr)/data(ind1,6); % change of number of leaves in ratio
                                     tough1=data(ind1,18:20);tough1(tough1==999)=NaN;% toughness data, remove missing
                                     tough2=data(ind2,18:20);tough2(tough2==999)=NaN;
            Plant_tough(b,tr) = nanmean(tough2) - nanmean(tough1); % change in mean
           %  dmgP1 = data(ind1,21); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
             dmgP2 = data(ind2,21);if (dmgP2 == 999), dmgP2 = 0; end
         %    dmgH1 = data(ind1,22); if (dmg2 == 999), dmg2 = 0;  end % initially without damage data
             dmgH2 = data(ind2,22);if (dmgH2 == 999), dmgH2 = 0; end
            Plant_NofD(b,tr) =  dmgH2+dmgP2;
        end
    end
 end
 %% control
 for b = 1:6 % block
    for tr = 1:10 % treatment
           % for control we only use data from the first stage
            D1 = 1 ; D2 =7;         
            ind1 = find( ismember(data(:,3:5),treatmentPlant(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data
            ind2 = find( ismember(data(:,3:5),treatmentPlant(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
            
            if isempty(ind1)+isempty(ind2)==0
            % calculation
                temp1 = sort(data(ind1,8:17)); % chl data sorted
                temp2 = sort(data(ind2,8:17));
            PlantCtrl_dChl(b,tr) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
            PlantCtrl_endChl(b,tr) = mean(inlier(temp2));
            PlantCtrl_NofL(b,tr) = data(ind2,6)-data(ind1,6); % change in number of leaves
            PlantCtrl_NofLratio(b,tr)  = Plant_NofL(b,tr)/data(ind1,6); % change of number of leaves in ratio
                                     tough1=data(ind1,18:20);tough1(tough1==999)=NaN;% toughness data, remove missing
                                     tough2=data(ind2,18:20);tough2(tough2==999)=NaN;
            PlantCtrl_tough(b,tr) = nanmean(tough2) - nanmean(tough1); % change in mean
           %  dmgP1 = data(ind1,21); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
             dmgP2 = data(ind2,21);if (dmgP2 == 999), dmgP2 = 0; end
         %    dmgH1 = data(ind1,22); if (dmg2 == 999), dmg2 = 0;  end % initially without damage data
             dmgH2 = data(ind2,22); if (dmgH2 == 999), dmgH2 = 0; end
            PlantCtrl_NofD(b,tr) =  dmgH2+dmgP2;
        end
    end
 end
 %%
 save dataPlants Plant_dChl Plant_endChl Plant_NofD Plant_NofL Plant_NofLratio Plant_tough  PlantCtrl_dChl PlantCtrl_endChl PlantCtrl_NofD PlantCtrl_NofL PlantCtrl_NofLratio PlantCtrl_tough treatmentPlant controlPlant
 