%% Compiling data
% Organising data from herbivore competition experiment in summer 2015
%
% _Wei-Ting Lin 2015/9/4_
clear;clc
% laptop
%cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
%addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_stat'
% home
%     cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\herbivore_SG_Iva'
%     addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_plot'
%     addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_stat'
%% Load data
% * [data_aph.txt]: detail see the excel file
% columns: 1.day  2.block  3.exp  4. sp1  5. sp2  6.#L  7. #D   
%          8~17. chl    18~20. tough   
%          21. P    22. H    23.A 
 data=load('./data/data_aph.txt');  
% * [data_bugs.txt]
% columns: 1.block   2.exp  3.sp1  4 sp2
%        5~8 weight before experiment, 5. sp1-1  6.sp1-2  7.sp2-1  8. sp2-2
%        9~12       after            , 9         10       11       12  
 data_bugs= load('./data/data_bugs.txt');
%% Compile data by each responder: Aphids
% data sheets
blc = NaN(54,1); % block; repetition, but also time; to be filled in 
pretreat = repmat([0 0 0 0 0 0 1 2 3]', 6,1); % treatment to plant before focal aphids added; 1: aphid, 2: Paria, 3; Hesperotettix
compete = repmat([ 0 0 0 1 2 3 0 0 0]',6,1); % competitors added with facal aphids
L0 = NaN(54,1);       % leaf number at D1
Lend = NaN(54,1);       % leaf number at D1
chl0 = NaN(54,1);     % mean leaf chlorophyll at D1
chlin0 = NaN(54,1);     % mean leaf chlorophyll at D1; two extream data removed
tou0 = NaN(54,1);     % mean leaf toughness at D1
  % the three above serve as plan quality 
dwP = NaN(54,1);  % change in weight 
ddamage = NaN(54,1);  % change in damged leave
dbite = NaN(54,1);  % chage in number of bite, back calculated from damage
mdamageH = NaN(54,1);
mwH = NaN(54,1);
Aphid = NaN(54,1);
% Treatment code
    treatmentP =[  2,2,1;  2,2,2;  2,2,3; 1,1,2; 1, 2,2; 1,2,3;  2,1,2;  2,2,2;  2,3,2] % column: [exp, sp1, sp2]
%% Grab data and filling out data sheet
for b = 1:6 % block
    for tr = 1:9 % treatment
        % Find data row (as indices) for before and after experiment
                D0=1; % day that plant quality matters          
                if tr>6% beta experiment
                 D1 = 7 ; D2 = 15;
                else
                 D1 = 1 ; D2 =7; % low density control    
                 end
            rowid = (b-1)*9+tr; % which row in this 54-row data table
            ind0 = find( ismember(data(:,3:5),treatmentP(tr,:),'rows') & data(:,2)==b & data(:,1)==D0);% plant quality data
            ind1 = find( ismember(data(:,3:5),treatmentP(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data
            ind2 = find( ismember(data(:,3:5),treatmentP(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
            indB = find( ismember(data_bugs(:,2:4),treatmentP(tr,:),'rows') & data_bugs(:,1) == b); % index for the bug data
            indBid =[repmat(treatmentP(tr,2),1,2)  repmat(treatmentP(tr,3),1, 2)]; % id of bugs in data_bugs(indB,5:8) and
                                                                                                                    %                   data_bugs(indB,9:12)
        if isempty(ind1)+isempty(ind2)==0
        % calculation
        blc(rowid) =b;
                temp = sort(data(ind0,8:17));      % chl data D1 sorted
        chl0(rowid) = mean(temp);
        chlin0(rowid) = mean(inlier(temp));       % remove two extream data
        L0(rowid) = data(ind0,6);                    % number of leaves
         Lend(rowid) = data(ind2,6);      
        tou0(rowid) = mean(data(ind0,18:20)); % mean leave toughness             
        
          % change in bug weights
            temp3 = data_bugs(indB,5:8); % bug weight data "before"
            temp31 = temp3; temp31(indBid~=2)=NaN;temp31(temp3 == 99)=NaN;
                                  % all and only Paria data, no missing value
            temp4 = data_bugs(indB,9:12); % bug weight data "after"
            temp41 = temp4;temp41(indBid~=2)=NaN; temp41(temp4 == 99)=NaN;  temp41(temp4 == 0)=NaN;
                                  % all and only hesperotettix data, no missing value, missing bug (99) or
                                  % dead (0)
                                if tr==3 % for control, ignore the second introduced individuals
                                        temp31([3 4])=NaN;
                                end
                                if tr==9 % for the effect of pretreated plants
                                         temp31([1 2])=NaN;
                                end
          if ~isempty(temp31) && ~isempty(temp41) 
           dwP(rowid) = (nanmean(temp41)-nanmean(temp31))/nanmean(temp31);
         end                         
      
        % damage
         dmg1 = data(ind1,21); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
         dmg2 = data(ind2,21);
         if  dmg2 ~= 999
                 if tr ==5
                 ddamage(rowid) = (dmg2-dmg1)/2; % high density treatment
                 else
                  ddamage(rowid) = dmg2-dmg1;% Temporally...
        % transfer to bite using my function, check time consumed
                 end
         end
         if tr==6 % mean Hesperotettix competing
                mdamageH(rowid) = data(ind2,22)/2;
                    temp42=temp4; temp42(indBid~=3)=NaN; temp42(temp4 == 99)=NaN;  temp42(temp4 == 0)=NaN;
                    temp32 = temp3; temp32(indBid~=3)=NaN;temp32(temp3 == 99)=NaN;
                 if  ~isempty(find(~isnan(temp42-temp32)))
                    mwH(rowid) = nangeomean([temp42,temp32]);
                               % for Hesperotettix, I use geometric mean of growthrate of each grasshopper
                end
         end

          if tr==9 % mean Hesperotettix competing
                mdamageH(rowid) = data(ind1,22)/2;
          end
         if tr==4 % mean aphid competing
             Aphid(rowid) = (data(ind2,23)+30)/2;
         end
         if tr==7 % mean aphid in treatment
             Aphid(rowid) = (data(ind1,23)+30)/2;
         end     

    end
    end
end
%% make table
    TabP = table(blc,pretreat, compete, L0, chl0, chlin0, tou0,Lend,Aphid,mdamageH, mwH, dwP, ddamage)
    writetable(TabP,'./data/TabP.txt','Delimiter',' ')
   % clear; clc
   %TabP= readtable('./data/TabP.txt','Delimiter',' ')
%% test normality
%   hist(TabP.dwP); kstest(nanzscore(TabP.dwP))
                           %   kstest(X) % test for normality, 0 is good
%   hist(TabP.ddamage); kstest(nanzscore(TabP.ddamage))
%   hist(TabP.chlin0)
%   kstest(nanzscore(TabP.chlin0)) 
%   kstest(nanzscore(TabP.chl0)) 
%   kstest(nanzscore(TabP.tou0)) 
%   kstest(nanzscore(TabP.L0)) 
%% 

 mdl = fitlm(TabP,'dwP~tou0+L0')
 resid = TabP.dwP-predict(mdl,TabP);
 
 [p,tbl,stats1] = anovan(resid,{TabP.blc})
 blcresid = stats1. resid;
 [p,tbl,stats2] = anovan(TabP.dwP,{TabP.blc})
 blcresid = stats2. resid;
%% 
     myStyle = []; % place holder for [Styles]
    myStyle.DataPointsOn = 1;
    mytexts = [];
    mytexts.ylabel = 'Paria growth (residual)';
    mytexts.title = 'Paria response';
    myStyle.barcolor = mycolor(28);
    myStyle.pointcolor = mycolor(11);
% to pre-treatment
%castdata(blcresid, TabH.blc)
A=castdata(blcresid(TabP.compete==0), TabP.pretreat(TabP.compete==0))
    pretreats={'control','Aphid',' Hes.','Paria*'};
    mytexts.xlabels= pretreats;% use struct(field, value) for the first element
    mytexts.xlabel = 'treatment to plant';
      [p,tbl,stats2] = anovan(blcresid(TabP.compete==0),{TabP.pretreat(TabP.compete==0)})
    %  [p,tbl,stats] = kruskalwallis(blcresid(TabP.compete==0),TabP.pretreat(TabP.compete==0))
     C= multcompare(stats2,'Dimension',[1],'CType','hsd')
figure
myplot_bar(A, myStyle,mytexts)
% to competition
   compete={'control','Aphid',' Hes.','Paria*'};
    mytexts.xlabels= compete;% use struct(field, value) for the first element
     mytexts.xlabel = 'competitor';
B=castdata(blcresid(TabP.pretreat==0), TabP.compete(TabP.pretreat==0))
      [p,tbl,stats2] = anovan(blcresid(TabP.pretreat==0),{TabP.compete(TabP.pretreat==0)})
 %       [p,tbl,stats3] = kruskalwallis(blcresid(TabP.pretreat==0),TabP.compete(TabP.pretreat==0))
    C=  multcompare(stats2,'Dimension',[1])
figure
myplot_bar(B, myStyle,mytexts)