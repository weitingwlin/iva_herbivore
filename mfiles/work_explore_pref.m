%% Load data
    clear;clc
    TabPref = readtable('./data/TabPref.txt','Delimiter',' ');
% thead(TabPref)

%% lump all replicates and all blocks and types
% Display mean, SE using myplott
        mystyle = [];
        mystyle.DataPointsOn = 1;
%%
        figure
        myplott(TabPref, 'PI',{'cattreat','catsubject'},mystyle)
        hline(0,7, ':')
        xlabel('treatment')
        ylabel('PI (PI = 1 means control are favored)')
    % PI = 1 means control are favored, PI = -1 means damaged are favored;
    % PI = 0 means no preference
 
 %%
 figure
        myplott(TabPref, 'ratio',{'cattreat','catsubject'},mystyle)
        hline(0.5,7, ':')
        xlabel('treatment')
        ylabel('At/(At + Ac)')
 %% two stage method
  %  [p, tab, stats1] = anovan(TabPref.PI, {catblock});
  %  blcresid = stats1.resid;
  %  [p, tab, stats] = anovan(TabPref.PI, {cattreat  catsubject });
 
 