clear;clc
% laptop
cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_stat'
%%
%TabA= readtable('./data/TabA.txt','Delimiter',' ');
% TabP= readtable('./data/TabP.txt','Delimiter',' ');
%TabH= readtable('./data/TabH.txt','Delimiter',' ');
TabPlant= readtable('./data/TabPlant.txt','Delimiter',' ');
mycorrplot_1(TabPlant(:,5:end))
%% Effects of A and H
indAH =  ismember(TabPlant.bugs,{'AH'});
TabAH = TabPlant(indAH,:)

 %% damage
   mdl = fitlm(TabAH,'dtou~tou0+L0+Chlin0+blc')
 resid = TabAH.dtou-predict(mdl,TabAH);
 
 [p,tbl,stats1] = anovan(resid,{TabAH.order});
     C= multcompare(stats1,'Dimension',[1],'CType','hsd')
 
     
%% plot
     myStyle = []; % place holder for [Styles]
    myStyle.DataPointsOn = 1;
    mytexts = [];
    myStyle.barcolor = mycolor(28);
    myStyle.pointcolor = mycolor(11);
%%
  mytexts.ylabel = 'Change in toughness';
  mytexts.xlabel = 'order';
    A=castdata(resid, TabAH.order);
    figure
myplot_bar(A, myStyle,mytexts)

%%
 [p,tbl,stats1] = anovan(TabPlant.damage,{TabPlant.bugs,TabPlant.blc});
     C= multcompare(stats1,'Dimension',[1],'CType','hsd')
 
%% Effect of one species on plant
TabPlant.bugs= categorical(TabPlant.bugs)
subA=TabPlant(TabPlant.bugs=='A',:)
subP=TabPlant(TabPlant.bugs=='P',:)
subH=TabPlant(TabPlant.bugs=='H',:)
%%
styles.DataPointsOn =1;
styles. pointcolor = mycolor(28);
    figure
    myplott(TabPlant, 'dChlin', 'bugs',styles); ylabel('d(Chlorophyll)')
    figure
    myplott(TabPlant, 'dL', 'bugs',styles); ylabel('d(# of Leave)')
        figure
    myplott(TabPlant, 'dtou', 'bugs',styles); ylabel('d(Toughness)')