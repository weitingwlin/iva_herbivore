%% load data
clear; clc
TabA= readtable('./data/TabA.txt', 'Delimiter', ' ');
TabP = readtable('./data/TabP.txt', 'Delimiter', ' ');
TabH= readtable('./data/TabH.txt', 'Delimiter', ' ');
%% treatment
comset =  [0 0; 0 1; 0 2; 0 3; 1 0; 2 0; 3 0 ]; % combination set, each row correspond to catnames
valset = comset(:, 1) * 10 + comset(:, 2); % value set, correspond to catnames
catnames = {'control', 'con_A', 'con_P', 'con_H', 'delay_A', 'delay_P', 'delay_H'};

A = [TabA.compete TabA.pretreat]; % 2-column treatment from data
Aval = A(:, 1) * 10 + A(:, 2); % treatment value
Atreatcat = categorical(Aval, valset,catnames); 

P = [TabP.compete TabP.pretreat]; % 2-column treatment from data
Pval = P(:, 1) * 10 + P(:, 2); % treatment value
Ptreatcat = categorical(Pval, valset,catnames); 

H = [TabH.compete TabH.pretreat]; % 2-column treatment from data
Hval = H(:, 1) * 10 + H(:, 2); % treatment value
Htreatcat = categorical(Hval, valset, catnames); 
%%
 Ablockcat = categorical(TabA.blc);
 Pblockcat = categorical(TabP.blc);
 Hblockcat = categorical(TabH.blc);
%% The effect of block
 [pA,tblA,statsA] = anovan(TabA.dAphid,{ Ablockcat , Atreatcat}, 'model','interaction');
 [pP,tblP,statsP] = anovan(TabP.ddamage,{ Pblockcat , Ptreatcat}, 'model','interaction');
 [pH,tblH,statsH] = anovan(TabH.ddamage,{ Hblockcat , Htreatcat}, 'model','interaction');
%% Save
xlswrite('anova_A.xlsx', tblA);
xlswrite('anova_P.xlsx', tblP);
xlswrite('anova_H.xlsx', tblH);