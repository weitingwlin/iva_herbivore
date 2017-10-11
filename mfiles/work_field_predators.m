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
%%
 txt.xmark = temp;
 it = 10000; % number of iteration
%% Add ladybeetle

tic 
for F = 1:length(Frames)
     nullAL = numInteraction_bootstrap(matA, matL, it, 1, Frames(F) );
        AonL(F) = nullAL.AonB;
        ciAonL(:, F) = nullAL.ciAonB;
        midAonL(F) = nullAL.medAonB;
        LonA(F) = nullAL.BonA;
        ciLonA(:, F) = nullAL.ciBonA;
        midLonA(F) = nullAL.medBonA;
     nullLL = numInteraction_bootstrap(matL, matL, it,1, Frames(F) );
        LonL(F) = nullLL.AonB;
        ciLonL(:, F) = nullLL.ciAonB;
        midLonL(F) = nullLL.medAonB;
end
toc
figure
    txt.title ={ 'Uroleucon --> Ladybeetles'};
    myplot_CI(AonL, ciAonL, midAonL,4, txt, mystyle)
figure
    txt.title ={  'Ladybeetles --> Uroleucon'};
    myplot_CI(LonA, ciLonA, midLonA,4, txt, mystyle)
figure
    txt.title ={ 'Ladybeetles --> Ladybeetles'};
    myplot_CI(LonL, ciLonL, midLonL,4, txt, mystyle)

%% Spider on Paria
tic 
for F = 1:length(Frames)
     nullPS = numInteraction_bootstrap(matP, matS, it, 1, Frames(F) );
        PonS(F) = nullPS.AonB;
        ciPonS(:, F) = nullPS.ciAonB;
        midPonS(F) = nullPS.medAonB;
        SonP(F) = nullPS.BonA;
        ciSonP(:, F) = nullPS.ciBonA;
        midSonP(F) = nullPS.medBonA;
     nullSS = numInteraction_bootstrap(matS, matS, it,1, Frames(F) );
        SonS(F) = nullSS.AonB;
        ciSonS(:, F) = nullSS.ciAonB;
        midSonS(F) = nullSS.medAonB;
end
toc
figure
    txt.title ={ 'Paria --> Spider'};
    myplot_CI(PonS, ciPonS, midPonS,4, txt, mystyle)
figure
    txt.title ={  'Spider --> Paria'};
    myplot_CI(SonP, ciSonP, midSonP,4, txt, mystyle)
figure
    txt.title ={ 'Spider --> Spider'};
    myplot_CI(SonS, ciSonS, midSonS,4, txt, mystyle)
    
%% spider and heperotettix

    tic 
for F = 1:length(Frames)
     nullHS = numInteraction_bootstrap(matH, matS, it, 1, Frames(F) );
        HonS(F) = nullHS.AonB;
        ciHonS(:, F) = nullHS.ciAonB;
        midHonS(F) = nullHS.medAonB;
        SonH(F) = nullHS.BonA;
        ciSonH(:, F) = nullHS.ciBonA;
        midSonH(F) = nullHS.medBonA;
end
toc
figure
    txt.title ={ 'Hesperotettix --> Spider'};
    myplot_CI(HonS, ciHonS, midHonS,4, txt, mystyle)
figure
    txt.title ={  'Spider --> Hesperotettix'};
    myplot_CI(SonH, ciSonH, midSonH,4, txt, mystyle)

    