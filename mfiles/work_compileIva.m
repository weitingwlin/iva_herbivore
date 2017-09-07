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
 treatment = [controlPlant; treatmentPlant];
 ind_attack = [0; repmat(1,9,1); repmat(2,15,1)]; % number of attack correspond to treatment
  ind_order = [repmat(-1,10,1); repmat(0,6,1); (1:9)']; %
 order_code = { 'na','sim','AA', 'AP','AH','PP','PA', 'PH','HH','HA','HP'}; % correspond to code (-1~9) 
 ind_bugs = [0  1 1 1 2 2 2 3 3 3 4 5 6 7 8 9 4 5 6 7 5 8 9 6 8];
  bugs_code = { 'na','A','P','H','AA', 'AP','AH','PP', 'PH','HH'};
                                   % the first stage of beta experiment will serve as low density control
 %% Data sheets

 L0 = NaN(150,1);
Chlin0 = NaN(150,1);
tou0 = NaN(150,1);

blc =NaN(150,1);
attack =NaN(150,1);
 bugs = NaN(150,1);
 order = NaN(150,1);
 
 dL = NaN(150,1);
 dLratio =NaN(150,1);
 endL = NaN(150,1);
dChlin = NaN(150,1);
endChlin = NaN(150,1);
dtou = NaN(150,1);
endtou = NaN(150,1);
damage = NaN(150,1);

 %% Treatment 
 for b = 1:6 % block
    for tr = 1:25 % treatment
            if tr <= 16 % 0~1 attack or simultaneouse attack
                D1 = 1 ; D2 =7;
            else % tr= 17~25 beta experiment, accumulated effect of 2 attacked
                D1 = 1 ; D2 = 15; 
            end
            rowid = (b-1)*25+tr; % which row in this 150-row data table
            ind1 = find( ismember(data(:,3:5),treatment(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data, plant quality data
            ind2 = find( ismember(data(:,3:5),treatment(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
            
            blc(rowid) = b;
            attack(rowid) =ind_attack(tr);
            bugs(rowid) = ind_bugs(tr);
           order(rowid) = ind_order(tr);
            
            
            if isempty(ind1)+isempty(ind2)==0
            % calculation
                temp1 = sort(data(ind1,8:17)); % chl data sorted
                temp2 = sort(data(ind2,8:17));
            Chlin0(rowid) =mean(inlier(temp1));
            dChlin(rowid) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
            endChlin(rowid) = mean(inlier(temp2));
             L0(rowid) = data(ind1,6); %
            dL(rowid) = data(ind2,6)-data(ind1,6); % change in number of leaves
            endL(rowid) =  data(ind2,6);
                                     tough1=data(ind1,18:20);tough1(tough1==999)=NaN;% toughness data, remove missing
                                     tough2=data(ind2,18:20);tough2(tough2==999)=NaN;
            tou0(rowid)  =  nanmean(tough1);
            dtou(rowid) = nanmean(tough2) - nanmean(tough1); % change in mean
            endtou(rowid) = nanmean(tough2); % change in mean
           %  dmgP1 = data(ind1,21); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
             dmgP2 = data(ind2,21);if (dmgP2 == 999), dmgP2 = 0; end
         %    dmgH1 = data(ind1,22); if (dmg2 == 999), dmg2 = 0;  end % initially without damage data
             dmgH2 = data(ind2,22);if (dmgH2 == 999), dmgH2 = 0; end
            damage(rowid) = dmgH2+dmgP2;
        end
    end
 end
 %%
bugs = categorical(bugs,[0:9],bugs_code)
order = categorical(order,[-1:9],order_code)
 %%
 damage(damage==0)=NaN;
 TabPlant = table(blc, attack, bugs, order, L0,Chlin0, tou0, dL, endL, dChlin, endChlin, dtou, endtou, damage);
 writetable(TabPlant,'./data/TabPlant.txt','Delimiter',' ')
   % clear; clc
   % TabPlant= readtable('./data/TabPlant.txt','Delimiter',' ')
 %% test normality
% hist(TabPlant.damage);kstest(TabPlant.damage) 
% tdamage = TabPlant.damage; tdamage(tdamage<=0)=NaN
%   hist(tdamage); kstest(nanzscore(tdamage))
%   kstest(Y) % test for normality, 0 is good
%   hist(TabAphid.chlin0)
%   kstest(nanzscore(TabA.chlin0)) 
%   kstest(nanzscore(TabA.chl0)) 
%   kstest(nanzscore(TabA.tou0)) 
%   kstest(nanzscore(TabA.L0)) 