clear;clc
% laptop

%%

TabP= readtable('./data/TabP.txt','Delimiter',' ');

%%
 mycorrplot_1(TabP(:,[4:8 10:13]))


 %% Aphid
 % block residual
 [p,tbl,stats1] = anovan(TabP.ddamage,{TabP.blc})
 blcresidP = stats1. resid;
 
 [p,tbl,stats2] = anovan(blcresidP(TabP.compete==0),{TabP.pretreat(TabP.compete==0)})
     C= multcompare(stats2,'Dimension',[1],'CType','hsd')
     
 [p,tbl,stats2] = anovan(blcresidP(TabP.pretreat==0),{TabP.compete(TabP.pretreat==0)})
    C=  multcompare(stats2,'Dimension',[1],'CType','hsd')
%% plot
     myStyle = []; % place holder for [Styles]
    myStyle.DataPointsOn = 1;
    mytexts = [];
    myStyle.barcolor = mycolor(28);
    myStyle.pointcolor = mycolor(11);
%%
  mytexts.ylabel = 'Paria demage';
  mytexts.xlabel = 'block (saperated in time)';
    A=castdata(TabP.ddamage, TabP.blc);
    figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidP(TabP.compete==0), TabP.pretreat(TabP.compete==0))
    mytexts.xlabels= {'control','Aphid',' Hes.','Paria*'};% use struct(field, value) for the first element
    mytexts.xlabel = 'treatment to plant';
        figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidP(TabP.pretreat==0),TabP.compete(TabP.pretreat==0))
    mytexts.xlabels= {'control','Aphid',' Hes.','Paria*'};% use struct(field, value) for the first element
     mytexts.xlabel = 'competitor';
             figure
myplot_bar(A, myStyle,mytexts)

%%  block X treatment plot
myStyle.jitter = 0.02;
TabPcomp = TabP (TabP.pretreat==0, :);
 TabPcomp.compcat = categorical(TabPcomp.compete,[0:3],{'control', 'A','P*','H'})
 myplott(TabPcomp,'dwP',{'blc', 'compcat'},myStyle)
xlabel('block (time)');ylabel('change in Paria weight')

figure
myplott(TabPcomp,'ddamage',{'blc', 'compcat'},myStyle)
xlabel('block (time)');ylabel('change in Paria damage')
%%
subP = TabP(TabP.pretreat==0,:);
subP.loadP =subP.compete==2;
subP.loadH = zeros(36,1);
subP.loadA= zeros(36,1);
 subP.loadA(subP.compete==1) = subP.Aphid(subP.compete==1);
 subP.loadH(subP.compete==3) = subP.mdamageH(subP.compete==3);
 subP.blccat = categorical(subP.blc);
 %%
modelspec = 'dwP ~ blccat + loadA + loadP + loadH';
mdl = fitglm(subP,modelspec)

modelspec = 'ddamage ~ blccat + loadA + loadP + loadH';
mdl = fitglm(subP,modelspec)
%%
 [p,tbl,stats1] = anovan(subP.ddamage,{subP.blc})
 blcresidP = stats1. resid;
  subP.blcresid= blcresidP;
  modelspec = 'blcresid~  loadA + loadP + loadH';
mdl = fitglm(subP,modelspec)