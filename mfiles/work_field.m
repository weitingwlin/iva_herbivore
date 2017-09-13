% script_downloadfielddata
% (re-)download the data from LTER partal
clear;clc
script_compilefielddata

%% numeric interaction over time
Frames = 2:19;
txt=[];

txt.xmark = num2cellstr((Frames - 1)* 3);
txt.xlabel = 'time lag (day)';
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
txt.title ={ 'Numeric Interaction', 'Aphid --> Paria'};
myplot_CI(AonB, ciAonB, midAonB,4, txt)
figure
txt.title ={ 'Numeric Interaction', 'Paria --> Aphid'};
myplot_CI(BonA, ciBonA, midBonA,4, txt)
%%
clear AonB ciAonB midAonB clear nullAP

%% numeric interaction over time PH
Frames = 2:19;
txt=[];

txt.xmark = num2cellstr((Frames - 1)* 3);
txt.xlabel = 'time lag (day)';
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
txt.title ={ 'Numeric Interaction', 'Paria --> Hesperotettix'};
myplot_CI(AonB, ciAonB, midAonB,4, txt)
figure
txt.title ={ 'Numeric Interaction', 'Hesperotettix --> Paria'};
myplot_CI(BonA, ciBonA, midBonA,4, txt)
%%
clear AonB ciAonB midAonB nullPH
%% numeric interaction over time PH
Frames = 2:19;
txt=[];

txt.xmark = num2cellstr((Frames - 1)* 3);
txt.xlabel = 'time lag (day)';
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
txt.title ={ 'Numeric Interaction', 'Aphid --> Hesperotettix'};
myplot_CI(AonB, ciAonB, midAonB,4, txt)
figure
txt.title ={ 'Numeric Interaction', 'Hesperotettix --> Aphid'};
myplot_CI(BonA, ciBonA, midBonA,4, txt)
%%
clear AonB ciAonB midAonB nullAH
%% effect on itself
%% numeric interaction over time PH
Frames = 2:19;
txt=[];

txt.xmark = num2cellstr((Frames - 1)* 3);
txt.xlabel = 'time lag (day)';
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
    txt.title ={ 'Numeric Interaction', 'Aphid --> Aphid'};
    myplot_CI(AonA, ciAonA, midAonA,4, txt)
figure
    txt.title ={ 'Numeric Interaction', 'Paria --> Paria'};
    myplot_CI(PonP, ciPonP, midPonP,4, txt)
figure
    txt.title ={ 'Numeric Interaction', 'Hesperotettix --> Hesperotettix'};
    myplot_CI(HonH, ciHonH, midHonH,4, txt)
%%
clear AonA ciAonA midAonA nullAA PonP ciPonP midPonP nullPP HonH ciHonH midHonH nullHH