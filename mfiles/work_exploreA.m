%% Set up
%  setupatlab
%  setupathome
%%
TabA= readtable('./data/TabA.txt','Delimiter',' ');

%%

 mycorrplot_1(TabA(:,[4: 10]))

%  dAphid2 = TabA.dAphid;
%  dAphid2(dAphid2==-1)=NaN;% kstest(nanzscore(dAphid2))
 %% Aphid
 % block residual
 [p,tbl,stats1] = anovan(TabA.dAphid,{TabA.blc})
 blcresidA = stats1. resid;
 %%
 
 [p,tbl,stats2] = anovan(blcresidA(TabA.compete==0),{TabA.pretreat(TabA.compete==0)})
     C= multcompare(stats2,'Dimension',[1],'CType','hsd')
     
 [p,tbl,stats2] = anovan(blcresidA(TabA.pretreat==0),{TabA.compete(TabA.pretreat==0)})
    C=  multcompare(stats2,'Dimension',[1],'CType','hsd')
%% plot
     myStyle = []; % place holder for [Styles]
    myStyle.DataPointsOn = 1;
    mytexts = [];
    myStyle.barcolor = mycolor(28);
    myStyle.pointcolor = mycolor(11);
%%
  mytexts.ylabel = 'Aphid growth (removed extinct colonies)';
  mytexts.xlabel = 'block (saperated in time)';
    A=castdata(TabA.dAphid, TabA.blc);
    figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidA(TabA.compete==0), TabA.pretreat(TabA.compete==0))
    mytexts.xlabels= {'control','Aphid*',' Hes.','Paria'};% use struct(field, value) for the first element
    mytexts.xlabel = 'treatment to plant';
        figure
myplot_bar(A, myStyle,mytexts)

    A=castdata(blcresidA(TabA.pretreat==0),TabA.compete(TabA.pretreat==0))
    mytexts.xlabels= {'control','Aphid*',' Hes.','Paria'};% use struct(field, value) for the first element
     mytexts.xlabel = 'competitor';
             figure
myplot_bar(A, myStyle,mytexts)
%% block X treatment plot
myStyle=[];
myStyle.jitter = 0.02;
TabAcomp = TabA (TabA.pretreat==0, :);
 TabAcomp.compcat = categorical(TabAcomp.compete,[0:3],{'control', 'A','P','H'})
 myplott(TabAcomp,'dAphid',{'blc', 'compcat'},myStyle)
xlabel('block (time)');ylabel('change in aphid population')
%% parameter estimation
subA = TabA(TabA.pretreat==0,:);

subA.loadP = zeros(36,1);
subA.loadH = zeros(36,1);
subA.loadA=subA.compete==1;
 subA.loadP(subA.compete==2)=subA.mdamage(subA.compete==2);
 subA.loadH(subA.compete==3)=subA.mdamage(subA.compete==3);
 subA.blccat = categorical(subA.blc);
%modelspec = 'dAphid ~ blccat + loadA + loadP + loadH';
%mdl = fitglm(subA,modelspec)

%%
 [p,tbl,stats1] = anovan(subA.dAphid,{subA.blc})
 blcresidA = stats1. resid;
  subA.blcresid= blcresidA;
  modelspec = 'blcresid~  loadA + loadP + loadH';
mdl = fitglm(subA,modelspec)
