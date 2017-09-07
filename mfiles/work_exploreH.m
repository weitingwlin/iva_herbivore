clear;clc
% laptop
cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_stat'
%%
%TabA= readtable('./data/TabA.txt','Delimiter',' ');
% TabP= readtable('./data/TabP.txt','Delimiter',' ');
TabH= readtable('./data/TabH.txt','Delimiter',' ');
%TabPlant= readtable('./data/TabPlant.txt','Delimiter',' ');
%%
% mycorrplot_1(TabP(:,[4 6 7 8 9]))
% mycorrplot_1(TabA(:,[4 7 8 10]))
 mycorrplot_1(TabH(:,[4:9 11:14])) % almost sig. effect of toughness
           mdl = fitlm(TabH,'dwH~tou0 + Lend')
 resid_dwH = TabH.dwH-predict(mdl,TabH);

 %% damage
 % block residual
 [p,tbl,stats1] = anovan(TabH.ddamage,{TabH.blc})
 blcresidH = stats1. resid;
 
 [p,tbl,stats2] = anovan(blcresidH(TabH.compete==0),{TabH.pretreat(TabH.compete==0)})
     C= multcompare(stats2,'Dimension',[1],'CType','hsd')
     
 [p,tbl,stats2] = anovan(blcresidH(TabH.pretreat==0),{TabH.compete(TabH.pretreat==0)})
    C=  multcompare(stats2,'Dimension',[1],'CType','hsd')
%% plot
     myStyle = []; % place holder for [Styles]
    myStyle.DataPointsOn = 1;
    mytexts = [];
    myStyle.barcolor = mycolor(28);
    myStyle.pointcolor = mycolor(11);
%%
  mytexts.ylabel = 'Hesperotettix demage';
  mytexts.xlabel = 'block (saperated in time)';
    A=castdata(TabH.ddamage, TabH.blc);
    figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidH(TabH.compete==0), TabH.pretreat(TabH.compete==0))
    mytexts.xlabels= {'control','Aphid',' Hes.*','Paria'};% use struct(field, value) for the first element
    mytexts.xlabel = 'treatment to plant';
        figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidH(TabH.pretreat==0),TabH.compete(TabH.pretreat==0))
    mytexts.xlabels= {'control','Aphid',' Hes.*','Paria'};% use struct(field, value) for the first element
     mytexts.xlabel = 'competitor';
             figure
myplot_bar(A, myStyle,mytexts)
%% weight change
 % block residual
 [p,tbl,stats1] = anovan(TabH.dwH,{TabH.blc})
 blcresidH = stats1. resid;
 
 [p,tbl,stats2] = anovan(blcresidH(TabH.compete==0),{TabH.pretreat(TabH.compete==0)})
     C= multcompare(stats2,'Dimension',[1],'CType','hsd')
     
 [p,tbl,stats2] = anovan(blcresidH(TabH.pretreat==0),{TabH.compete(TabH.pretreat==0)})
    C=  multcompare(stats2,'Dimension',[1],'CType','hsd')
    
%%
  mytexts.ylabel = 'Hesperotettix growth';
   mytexts.xlabels=[];
  mytexts.xlabel = 'block (saperated in time)';
    A=castdata(TabH.dwH, TabH.blc);
    figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidH(TabH.compete==0), TabH.pretreat(TabH.compete==0))
    mytexts.xlabels= {'control','Aphid',' Hes.*','Paria'};% use struct(field, value) for the first element
    mytexts.xlabel = 'treatment to plant';
        figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidH(TabH.pretreat==0),TabH.compete(TabH.pretreat==0))
    mytexts.xlabels= {'control','Aphid',' Hes.*','Paria'};% use struct(field, value) for the first element
     mytexts.xlabel = 'competitor';
             figure
myplot_bar(A, myStyle,mytexts)
%%  block X treatment plot
myStyle.jitter = 0.02;
TabHcomp = TabH (TabH.pretreat==0, :);
 TabHcomp.compcat = categorical(TabHcomp.compete,[0:3],{'control', 'A','P','H*'})
 
 figure
 myplott(TabHcomp,'dwH',{'blc', 'compcat'},myStyle)
xlabel('block (time)');ylabel('change in Hesperotettix weight')

figure
myplott(TabHcomp,'ddamage',{'blc', 'compcat'},myStyle)
xlabel('block (time)');ylabel('change in Hesperotettix  damage')

%%
subH = TabH(TabH.pretreat==0,:)
subH.loadH =subH.compete==2;
subH.loadP = zeros(36,1);
subH.loadA = zeros(36,1);

 subH.loadA(subH.compete==1) = subH.Aphid(subH.compete==1);
 subH.loadP(subH.compete==2) = subH.mdamageP(subH.compete==2);
 subH.blccat = categorical(subH.blc);
 %%
modelspec = 'dwH ~ blccat + loadA + loadP + loadH';
mdl = fitglm(subH,modelspec)

modelspec = 'ddamage ~ blccat + loadA + loadP + loadH';
mdl = fitglm(subH,modelspec)
%%
 [p,tbl,stats1] = anovan(subH.ddamage,{subH.blc})
 blcresidH = stats1. resid;
  subH.blcresid= blcresidH;
  modelspec = 'blcresid~  loadA + loadP + loadH';
mdl = fitglm(subH,modelspec)

%% Growth/Damage
TabH.GD=TabH.dwH./TabH.ddamage;
 myplot_ls(TabH.touend, TabH.GD)
   modelspec = 'GD~  loadA + loadP + loadH';
mdl = fitglm(subH,modelspec)