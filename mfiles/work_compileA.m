%% Compiling data
% Organising data from herbivore competition experiment in summer 2015
%
% _Wei-Ting Lin 2015/9/4_
clear;clc
% laptop

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
chl0 = NaN(54,1);     % mean leaf chlorophyll at D1
chlin0 = NaN(54,1);     % mean leaf chlorophyll at D1; two extream data removed
tou0 = NaN(54,1);     % mean leaf toughness at D1
  % the three above serve as plan quality 
dAphid = NaN(54,1);  % change in number of aphid 
rgrAphid =  NaN(54,1); % relative growth rate of aphid ln(final/initial)
rgr1Aphid =  NaN(54,1);
rgr2Aphid =  NaN(54,1);
mdamage = NaN(54,1); % mean damage by competitor
mw = NaN(54,1); % mean weight of competitor

% Treatment code
    treatmentA =[ 2,1,1;  2,1,2;  2,1,3, ;  1,1,1; 1, 1,2; 1,1,3;  2,1,1;  2,2,1;  2,3,1]; % column: [exp, sp1, sp2]
    % the first 3 rows represent low density control
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
            ind0 = find( ismember(data(:,3:5),treatmentA(tr,:),'rows') & data(:,2)==b & data(:,1)==D0);% plant quality data
            ind1 = find( ismember(data(:,3:5),treatmentA(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data
            ind2 = find( ismember(data(:,3:5),treatmentA(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
            indB = find( ismember(data_bugs(:,2:4),treatmentA(tr,:),'rows') & data_bugs(:,1) == b); % index for the bug data
            indBid =[repmat(treatmentA(tr,2),1,2)  repmat(treatmentA(tr,3),1, 2)]; % id of bugs in data_bugs(indB,5:8) and
                                                                                                                    %                   data_bugs(indB,9:12)
        
        if isempty(ind1)+isempty(ind2)==0
        % calculation
        blc(rowid) = b;
                temp = sort(data(ind0,8:17));      % chl data D1 sorted (10 measurements)
        chl0(rowid) = mean(temp);
       
        chlin0(rowid) = mean(inlier(temp));       % remove two extream data
        L0(rowid) = data(ind0,6);                    % number of leaves
        tou0(rowid) = mean(data(ind0,18:20)); % mean leave toughness  (3 measurements)      
        if tr==4 % the high-density experiment
                 dAphid(rowid) = (data(ind2,23)-60)/60; % change of number of Aphid in ratio
                 rgrAphid(rowid) = log( (data(ind2, 23))/60  ); %
                 rgr1Aphid(rowid) = log( (data(ind2, 23) + 2)/60  ); %
                 rgr2Aphid(rowid) = log( (data(ind2, 23))/60 +1 ); %
        else
                 dAphid(rowid) = (data(ind2,23)-30)/30; % change of number in ratio
                 rgrAphid(rowid) = log( (data(ind2, 23) )/30); %
                 rgr1Aphid(rowid) = log( (data(ind2, 23)+1)/30 ); %
                 rgr2Aphid(rowid) = log( (data(ind2, 23))/30+1); %
        end
        
   % competing bug weight and damage
            temp3 = data_bugs(indB,5:8); % bug weight data "before"
            temp31 = temp3; temp31(temp3 == 99)=NaN; temp31(temp3 == 999)=NaN;
            temp4 = data_bugs(indB,9:12); % bug weight data "after"
            temp41 = temp4; temp41(temp4 == 99)=NaN; temp41(temp4 == 999)=NaN;  temp41(temp4 == 0)=NaN;

         if tr==5% 21 for paria damage
            dmg2 = data(ind2,21);            % dmg1==0   
            mdamage(rowid) = dmg2/2;% mean damage
             if ~isempty(temp31) && ~isempty(temp41) 
           mw(rowid) =nanmean([temp41,temp31]);
           end 
         end
         if tr==8% 21 for paria damage
            dmg1 = data(ind1,21);            % dmg1==0   
            mdamage(rowid) = dmg1;%damage
         end
          if tr==6% 22 for Hesperotettix damage
            dmg2 = data(ind2,22);            % dmg1==0   
            mdamage(rowid) = dmg2/2;% mean damage
              if  ~isempty(find(~isnan(temp41-temp31)))
             mw(rowid) = nanmean([temp41,temp31]);
                               % for Hesperotettix, I use geometric mean of growthrate of each grasshopper
             end
         end
         if tr==9% 22 for  Hesperotettix damage
            dmg1 = data(ind1,22);            % dmg1==0   
            mdamage(rowid) = dmg1;%  damage
         end
         
         

         
    end
    end
end
%% make table
           TabAphid = table(blc, pretreat, compete, L0, chl0, chlin0, tou0, mdamage,mw,dAphid, rgr2Aphid);
            Y = nanzscore(log(TabAphid.dAphid+2)); % to achive normality, see "test normality" section
            tabY = table(Y);
    TabA = [TabAphid tabY];
        writetable(TabA,'./data/TabA.txt','Delimiter',' ')
   % clear; clc
   % TabA= readtable('./data/TabA.txt','Delimiter',' ')

%% explore normality
subplot(2,2,1)
    qqplot(dAphid)
    title('change in population (ratio)')
subplot(2,2,2)
    qqplot(rgrAphid)
    title('RGR: ln(N2/N1)')
subplot(2,2,3)
    qqplot(rgr1Aphid)
    title('RGR: ln(N2/N1 + 1/30)')
subplot(2,2,4)
    qqplot(rgr2Aphid)
    title('RGR: ln(N2/N1 + 1)')



