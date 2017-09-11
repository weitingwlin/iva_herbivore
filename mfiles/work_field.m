% script_downloadfielddata
% (re-)download the data from LTER partal
clear;clc
script_compilefielddata

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
