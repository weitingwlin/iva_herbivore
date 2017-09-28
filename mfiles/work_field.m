% script_downloadfielddata
% (re-)download the data from LTER partal
clear;clc
script_compilefielddata
%%
mystyle = [];
 mystyle.datafacecolor = [0.6    0.6   0.6];% mycolor(5,:);
  mystyle.datawidth = 2;
% mystyle.sigcolor = [0.8000    0.2000    0.2000];% 
  mystyle.sigfacecolor = [0    0   0];% = mycolor(2,:);
 mystyle.limcolor =  [0.6    0.6   0.6];
 mystyle.limwidth = 5;
 mystyle.midmarker = 'd';
 mystyle.midcolor =  [0.6    0.6   0.6];
  mystyle.midsize = 1 ;
  txt=[];
Frames = 2:19;
 temp = num2cellstr((Frames - 1)* 3);
temp(2:2:end) = {''};
%% numeric interaction over time


%txt.xlabel = 'time lag (day)';
 txt.xmark = temp;
tic 
for F = 1:length(Frames)
     nullAP = numInteraction_bootstrap(matA, matP, 10000,1, Frames(F) );
     AonB(F) = nullAP.AonB;
     ciAonB(:, F) = nullAP.ciAonB;
     midAonB(F) = nullAP.medAonB;
     BonA(F) = nullAP.BonA;
     ciBonA(:, F) = nullAP.ciBonA;
     midBonA(F) = nullAP.medBonA;
end
toc
figure
txt.title ={ 'Uroleucon --> Paria'};
myplot_CI(AonB, ciAonB, midAonB,4, txt, mystyle)
figure
txt.title ={ 'Paria --> Uroleucon'};
myplot_CI(BonA, ciBonA, midBonA,4, txt, mystyle)
%%
clear AonB ciAonB midAonB clear nullAP


%% numeric interaction over time PH

tic 
for F = 1:length(Frames)
     nullPH = numInteraction_bootstrap(matP, matH, 10000,1, Frames(F) );
     AonB(F) = nullPH.AonB;
     ciAonB(:, F) = nullPH.ciAonB;
     midAonB(F) = nullPH.medAonB;
     BonA(F) = nullPH.BonA;
     ciBonA(:, F) = nullPH.ciBonA;
     midBonA(F) = nullPH.medBonA;
end
toc
figure
txt.title ={  'Paria --> Hesperotettix'};
myplot_CI(AonB, ciAonB, midAonB,4, txt, mystyle)
figure
txt.title ={  'Hesperotettix --> Paria'};
myplot_CI(BonA, ciBonA, midBonA,4, txt, mystyle)
%%
clear AonB ciAonB midAonB nullPH
%% numeric interaction over time PH

tic 
for F = 1:length(Frames)
     nullAH = numInteraction_bootstrap(matA, matH, 10000,1, Frames(F) );
     AonB(F) = nullAH.AonB;
     ciAonB(:, F) = nullAH.ciAonB;
     midAonB(F) = nullAH.medAonB;
     BonA(F) = nullAH.BonA;
     ciBonA(:, F) = nullAH.ciBonA;
     midBonA(F) = nullAH.medBonA;
end
toc
figure
txt.title ={  'Uroleucon --> Hesperotettix'};
myplot_CI(AonB, ciAonB, midAonB,4, txt, mystyle)
figure
txt.title ={ 'Hesperotettix --> Uroleucon'};
myplot_CI(BonA, ciBonA, midBonA,4, txt, mystyle)
%%
clear AonB ciAonB midAonB nullAH
%% effect on itself
%% numeric interaction over time PH

tic 
for F = 1:length(Frames)
     nullAA = numInteraction_bootstrap(matA, matA, 10000,1, Frames(F) );
        AonA(F) = nullAA.AonB;
        ciAonA(:, F) = nullAA.ciAonB;
        midAonA(F) = nullAA.medAonB;
     nullPP = numInteraction_bootstrap(matP, matP, 10000,1, Frames(F) );
        PonP(F) = nullPP.AonB;
        ciPonP(:, F) = nullPP.ciAonB;
        midPonP(F) = nullPP.medAonB;
     nullHH = numInteraction_bootstrap(matH, matH, 10000,1, Frames(F) );
        HonH(F) = nullHH.AonB;
        ciHonH(:, F) = nullHH.ciAonB;
        midHonH(F) = nullHH.medAonB;
end
toc
figure
    txt.title ={ 'Uroleucon --> Uroleucon'};
    myplot_CI(AonA, ciAonA, midAonA,4, txt, mystyle)
figure
    txt.title ={ 'Paria --> Paria'};
    myplot_CI(PonP, ciPonP, midPonP,4, txt, mystyle)
figure
    txt.title ={  'Hesperotettix --> Hesperotettix'};
    myplot_CI(HonH, ciHonH, midHonH,4, txt, mystyle)
%%
clear AonA ciAonA midAonA nullAA PonP ciPonP midPonP nullPP HonH ciHonH midHonH nullHH