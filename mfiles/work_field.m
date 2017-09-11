script_downloadfielddata
% (re-)download the data from LTER partal
clear;clc
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
%% compile data to matrix
% each row is TS of a patch
% each column is snapshot of a time
matA = zeros(38,19);
matP = zeros(38,19);
matH = zeros(38,19);
D = string(zeros(38,19));
for p=1:38
        patch = patch_ind(p,:); % [ site, patch] 
        temp1 = find(((M2(:,1) == patch(1)) + (M2(:,2) == patch(2)))==2); % index for this patch
        D(p,1:19) =string( Date(temp1(1:19)));
        matA(p,1:19) = M(temp1(1:19), indA);
        matP(p,1:19) = M(temp1(1:19), indP);% 
        matH(p,1:19) = M(temp1(1:19), indH);% 
end

%% per capita effect
% using numInteraction.m
Frame = 2;
% effAP = numInteraction(matA, matP, [], [], Frame);
% effAH = numInteraction(matA, matH, [], [], Frame);
% effPH = numInteraction(matP, matH, [], [], Frame);
% effAL = numInteraction(matA, matL, [], [], Frame);
tic
nullAP = numInteraction_bootstrap(matA, matP,10000,1, Frame );
nullAH = numInteraction_bootstrap(matA, matH,10000,1, Frame);
nullPH = numInteraction_bootstrap(matP, matH,10000,1, Frame);
% nullAL = numInteraction_bootstrap(matA, matL,10000,1, Frame);
toc
%%
figure
txt=[];
txt.xmark = {'A->P', 'P->A','A->H','H->A','P->H','H->P'}
txt.title ={ 'Numeric Interaction', ['lag: '  num2str((Frame-1)*3) ' (days)']};

points = [nullAP.AonB ,     nullAP.BonA,       nullAH.AonB,       nullAH.BonA,       nullPH.AonB,       nullPH.BonA];
CI =      [nullAP.ciAonB ,   nullAP.ciBonA,     nullAH.ciAonB,    nullAH.ciBonA,     nullPH.ciAonB,     nullPH.ciBonA];
mid =    [nullAP.medAonB ,nullAP.medBonA, nullAH.medAonB, nullAH.medBonA, nullPH.medAonB, nullPH.medBonA];

myplot_CI(points,CI,mid,4, txt)

%% numeric interaction over time
