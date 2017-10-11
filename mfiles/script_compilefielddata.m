%%
M = csvread('data/bugdata2014.csv', 5, 8); % insect count data
M2 = csvread('data/bugdata2014.csv', 5, 2, [5, 2, 745, 3]); % insect count data

T = readtable('data/bugdata2014.csv');
Tname = T.Properties.VariableNames;
Date = datetime(T.Date(3: end), 'InputFormat', 'dd-MMM-yy');
insectnames = Tname(9: end);
patch_ind = unique(M2, 'rows');
%% index for the insect of interest
indP = find(strcmp(insectnames,  'Paria'  ));
indA =  find(strcmp(insectnames,  'Uroleucon'   ));
indH =  find(strcmp(insectnames,  'Hesperotettix'  ));
indL =  [11 12 13 16]; % three spceis of adult and larva
%  insectnames([11 12 13 16]) 
indS = find(strcmp(insectnames,  'Spider'  ));
%% compile data to matrix
% each row is TS of a patch
% each column is snapshot of a time
matA = zeros(38,19);
matP = zeros(38,19);
matH = zeros(38,19);
matL = zeros(38,19);
matS = zeros(38,19);
D = string(zeros(38,19));
for p=1:38
        patch = patch_ind(p,:); % [ site, patch] 
        temp1 = find(((M2(:,1) == patch(1)) + (M2(:,2) == patch(2)))==2); % index for this patch
        D(p,1:19) =string( Date(temp1(1:19)));
        matA(p,1:19) = M(temp1(1:19), indA);
        matP(p,1:19) = M(temp1(1:19), indP);% 
        matH(p,1:19) = M(temp1(1:19), indH);% 
        matL(p,1:19) = sum( M(temp1(1:19), indL), 2);% 
        matS(p,1:19) = M(temp1(1:19), indS);% 
end
%%
clear temp1 patch p T tname
