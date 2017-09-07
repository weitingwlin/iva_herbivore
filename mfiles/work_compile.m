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
A_chl = NaN(6,9,2); % change in mean, 2 extreme data removed, 4 removed ;(block, treatment)
A_L = NaN(6,9,2); % change in number
A_Tou = NaN(6,9);
A_n = NaN(6,9);

% Treatment code
treatmentA = [ 2,1,1;  2,1,2;  2,1,3, ;  1,1,1; 1, 1,2; 1,1,3;  2,1,1;  2,2,1;  2,3,1] ;% column: [exp, sp1, sp2]
%% Grab data and filling out data sheet
for b = 1:6 % block
        for tr = 1:9 % treatment
        % Find data row (as indices) for before and after experiment
                if treatmentA (tr,1) == 1 % alpha experment; concurrent interaction
                        D1 = 1 ; D2 =7;
                else
                        if tr > 6 % beta experiment; delayed interaction
                                D1 = 7 ; D2 = 15;
                        else
                                D1 = 1 ; D2 =7; % low density control    
                        end
                end
                ind1 = find( ismember(data(:,3:5),treatmentA(tr,:),'rows') & data(:,2)==b & data(:,1)==D1);% before data
                ind2 = find( ismember(data(:,3:5),treatmentA(tr,:),'rows') & data(:,2)==b & data(:,1)==D2);% after data
        
                if isempty(ind1)+isempty(ind2)==0
                    % calculation
                        temp1 = sort(data(ind1,8:17)); % chl data sorted
                        temp2 = sort(data(ind2,8:17));
                        A_chl(b,tr,1) = mean(temp2)-mean(temp1);
                        A_chl(b,tr,2) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
                        A_L(b,tr,1) = data(ind2,6)-data(ind1,6); % change in number of leaves
                        A_L(b,tr,2) = A_L(b,tr,1)/data(ind1,6); % change of number of leaves in ratio
                        A_Tou(b,tr) = mean(data(ind2,18:20)) - mean(data(ind1,18:20)); % change in mean
                        if tr==4
                                A_n(b,tr) = (data(ind2,23)-60)/60; % change of number in ratio
                        else
                                A_n(b,tr) = (data(ind2,23)-30)/30; % change of number in ratio
                        end
                end
        end
end
%% Compile data by each responder: Paria
% data sheets
P_chl = NaN(6,9,2); % change in mean, 2 extreme data removed, 4 removed
P_L = NaN(6,9,2); % change in number
P_Tou = NaN(6,9); % toughness
P_w = NaN(6,9); % weight change
P_d = NaN(6,9); % damage 
% Treatment code
treatmentP =[  2,2,1;  2,2,2;  2,2,3; 1,1,2; 1, 2,2; 1,2,3;  2,1,2;  2,2,2;  2,3,2] % column: [exp, sp1, sp2]
%% Grab data and filling out data sheet
for b = 1:6 % block
    for tr = 1:9 % treatment
        % Find data row (as indices) for before and after experiment
            if treatmentP(tr,1) == 1 % alpha experment
            D1 = 1 ; D2 =7;  
            else % beta experiment
                 if tr>6% beta experiment
                       D1 = 7 ; D2 = 15;
                    else
                          D1 = 1 ; D2 =7; % low density control    
                    end
            end
            ind1 = find( ismember(data(:,3:5),treatmentP(tr,:),'rows') & data(:,2) == b & data(:,1) == D1);% "before" data
            ind2 = find( ismember(data(:,3:5),treatmentP(tr,:),'rows') & data(:,2) == b & data(:,1) == D2);% "after" data
            indB = find( ismember(data_bugs(:,2:4),treatmentP(tr,:),'rows') & data_bugs(:,1) == b); % index for the bug data
            indBid =[repmat(treatmentP(tr,2),1,2)  repmat(treatmentP(tr,3),1, 2)]; % id of bugs in data_bugs(indB,5:8) and
                                                                                                                    %                   data_bugs(indB,9:12)
        if isempty(ind1) + isempty(ind2) == 0 % if both before and after data exist, calculate result, otherwise, keep NaN
        % calculation
            temp1 = sort(data(ind1,8:17)); % chl data sorted
            temp2 = sort(data(ind2,8:17));
        P_chl(b,tr,1) = mean(temp2)-mean(temp1);
        P_chl(b,tr,2) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
        P_L(b,tr,1) = data(ind2,6)-data(ind1,6); % change in number of leaves
        P_L(b,tr,2) = P_L(b,tr,1)/data(ind1,6); % change of number of leaves in ratio
        P_Tou(b,tr) = mean(data(ind2,18:20)) - mean(data(ind1,18:20)); % change in mean
            temp3 = data_bugs(indB,5:8); % bug weight data "before"
            temp31 = temp3(indBid==2 & temp3 ~= 99); 
                                  % all and only paria data, no missing value
            temp4 = data_bugs(indB,9:12); % bug weight data "after"
            temp41 = temp4(indBid==2 & temp4 ~= 99);
                                  % for paria, I use average weight regardless of how many individual left
        if ~isempty(temp31) && ~isempty(temp41) 
        P_w(b,tr) = (mean(temp41)-mean(temp31))/mean(temp31);
        end
        % damage
         dmg1 = data(ind1,21); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
         dmg2 = data(ind2,21);
         P_d(b,tr) = dmg2-dmg1;% Temporally...
        % transfer to bite using my function, check time consumed
         
        end
    end
end

%% Compile data by each responder: Hesperotettix1
% data sheets
H_chl = NaN(6,9,2); % change in mean, 2 extreme data removed, 4 removed
H_L = NaN(6,9,2); % change in number
H_Tou = NaN(6,9); % toughness
H_w = NaN(6,9); % weight change
H_d = NaN(6,9); % damage 
% Treatment code
treatmentH = [ 2,3,1;  2,3,2;  2,3,3; 1,1,3; 1, 2,3; 1,3,3;  2,1,3;  2,2,3;  2,3,3] % column: [exp, sp1, sp2]
%% Grab data and filling out data sheet
for b = 1:6 % block
    for tr = 1:9 % treatment
        % Find data row (as indices) for before and after experiment
            if treatmentH(tr,1) == 1 % alpha experment
            D1 = 1 ; D2 =7;  
            else % beta experiment
             if tr>6% beta experiment
                       D1 = 7 ; D2 = 15;
                    else
                          D1 = 1 ; D2 =7; % low density control    
                    end
            end
            ind1 = find( ismember(data(:,3:5),treatmentH(tr,:),'rows') & data(:,2) == b & data(:,1) == D1);% "before" data
            ind2 = find( ismember(data(:,3:5),treatmentH(tr,:),'rows') & data(:,2) == b & data(:,1) == D2);% "after" data
            indB = find( ismember(data_bugs(:,2:4),treatmentH(tr,:),'rows') & data_bugs(:,1) == b); % index for the bug data
            indBid =[repmat(treatmentH(tr,2),1,2)  repmat(treatmentH(tr,3),1, 2)]; % id of bugs in data_bugs(indB,5:8) and
                                                                                                                    %                   data_bugs(indB,9:12)
        if isempty(ind1) + isempty(ind2) == 0 % if both before and after data exist, calculate result, otherwise, keep NaN
        % calculation
            temp1 = sort(data(ind1,8:17)); % chl data sorted
            temp2 = sort(data(ind2,8:17));
        H_chl(b,tr,1) = mean(temp2)-mean(temp1);
        H_chl(b,tr,2) = mean(inlier(temp2))-mean(inlier(temp1));% remove two extream data
        H_L(b,tr,1) = data(ind2,6)-data(ind1,6); % change in number of leaves
        H_L(b,tr,2) = P_L(b,tr,1)/data(ind1,6); % change of number of leaves in ratio
        H_Tou(b,tr) = mean(data(ind2,18:20)) - mean(data(ind1,18:20)); % change in mean
            temp3 = data_bugs(indB,5:8); % bug weight data "before"
            temp31 = temp3; temp31(indBid~=3)=NaN;temp31(temp3 == 99)=NaN; 
                                  % all and only hesperotettix data, no missing value
            temp4 = data_bugs(indB,9:12); % bug weight data "after"
            temp41 = temp4;temp41(indBid~=3)=NaN; temp41(temp4 == 99)=NaN;
                                  
        if  ~isempty(find(~isnan(temp41-temp31)))
        H_w(b,tr) = (nanmean((temp41-temp31)./temp31));
        end
        % damage
         dmg1 = data(ind1,22); if (dmg1 == 999), dmg1 = 0;  end % initially without damage data
         dmg2 = data(ind2,22);
         if  dmg2 ~= 999
         H_d(b,tr) = dmg2-dmg1;% Temporally...
        % transfer to bite using my function, check time consumed
         end
        end
    end
end
%%
save dataAPH A_chl A_L A_n A_Tou P_chl P_d P_L P_Tou P_w H_chl H_d H_L H_Tou H_w 