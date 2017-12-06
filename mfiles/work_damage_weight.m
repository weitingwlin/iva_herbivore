%% GLM: effect of inter- and intra species competition on performance 
%  1. Add block into analysis 
%  2. for cooccurrence and delayed competition
% 
% 2017/10/23
%% Set up: run one script from below
clear; clc
work_setup
%% load data
  TabA= readtable([datapath 'TabA.txt'],'Delimiter',' ');
    TabP= readtable([datapath 'TabP.txt'],'Delimiter',' ');
    TabH= readtable([datapath 'TabH.txt'],'Delimiter',' ');

%% cooccurrence competition: preparing data
%%% Aphid as responder
    subA = TabA(TabA.pretreat == 0,:); % subset with only the  cooccurrence competition data, without pre-treatment
    subA.Uroleucon = subA.compete == 1 ;     %  load of intra-species competitor is a factor
            subA.Paria = zeros(36,1);  % preparing data column   
    subA.Paria(subA.compete == 2)  =subA.mdamage( subA.compete == 2); % mean damage of competitor No.2 (i.e. Paria)
            subA.Hesperotettix = zeros(36,1); % preparing data column   
    subA.Hesperotettix(subA.compete == 3) = subA.mdamage( subA.compete == 3); % mean damage of competitor No.3 (i.e. Hesperotettix)
    subA.block = categorical(subA.blc); % change the block data into categorical, so it will be hadled properly in the matlab glm function
    % 1-way-ANOVA with block
     subA.Y = subA.dAphid;
         %   [p,tbl,stats1] = anovan(subA.dAphid,{subA.blc});
   % subA.blcresid = stats1. resid; % save block residual as a new variable
   
%%% Paria as responder   
    subP = TabP(TabP.pretreat == 0,:);
    subP.Paria = subP.compete == 2;
            subP.Uroleucon= zeros(36,1);
    subP.Uroleucon(subP.compete == 1) = subP.Aphid(subP.compete == 1);
            subP.Hesperotettix = zeros(36,1);
    subP.Hesperotettix(subP.compete == 3) = subP.mdamageH(subP.compete == 3);
    subP.block = categorical(subP.blc);
    % 1-way-ANOVA with block
    subP.Y = subP.ddamage;
    %        [p,tbl,stats1] = anovan(subP.ddamage,{subP.blc});
  %   subP.blcresid= stats1. resid;  % save block residual as a new variable
%%% Hespeprotettix as responder
    subH = TabH(TabH.pretreat == 0,:);
    subH.Hesperotettix = subH.compete == 3; %  load of intra-species competitor is a factor
            subH.Uroleucon = zeros(36,1);
    subH.Uroleucon(subH.compete == 1) = subH.Aphid(subH.compete == 1); % mean population of aphid (i.e. competitor No. 1)
            subH.Paria = zeros(36,1);
    subH.Paria(subH.compete == 2) = subH.mdamageP(subH.compete == 2);
    subH.block = categorical(subH.blc);
    % 1-way-ANOVA with block
     subH.Y = subH.ddamage;
     %       [p,tbl,stats1] = anovan(subH.ddamage,{subH.blc});
   %  subH.blcresid=  stats1. resid;
%% cooccurrence competition: GLM analysis
  modelspec = 'Y~  Uroleucon + Paria + Hesperotettix + block'; 
  mdlA = fitglm(subA,modelspec);
  mdlP = fitglm(subP,modelspec);
  mdlH = fitglm(subH,modelspec);
  
%% Delayed competition: preparing data
%%% Aphid as responder
    subdA = TabA(TabA.compete == 0,:); % subset with only the  Delayed competition data, without competition 
    subdA.Uroleucon = subdA.pretreat == 1 ;     %  load of intra-species competitor is a factor
            subdA.Paria  = zeros(36,1);  % preparing data column   
    subdA.Paria (subdA.pretreat == 2)  = subdA.mdamage( subdA.pretreat == 2); % mean damage of competitor No.2 (i.e. Paria)
            subdA.Hesperotettix = zeros(36,1); % preparing data column   
    subdA.Hesperotettix(subdA.pretreat == 3) = subdA.mdamage( subdA.pretreat == 3); % mean damage of competitor No.3 (i.e. Hesperotettix)
    subdA.block = categorical(subdA.blc); % change the block data into categorical, so it will be hadled properly in the matlab glm function
    % 1-way-ANOVA with block
        subdA.Y = subdA.dAphid;
         %   [p,tbl,stats1] = anovan(subdA.dAphid,{subdA.blc});
   % subdA.blcresid = stats1. resid'; % save block residual as a new variable
%%% Paria as responder   
    subdP = TabP(TabP.compete== 0,:);
    subdP.Paria = subdP.pretreat == 2;
            subdP.Uroleucon= zeros(36,1);
    subdP.Uroleucon(subdP.pretreat  == 1) = subdP.Aphid(subdP.pretreat  == 1);
            subdP.Hesperotettix = zeros(36,1);
    subdP.Hesperotettix(subdP.pretreat  == 3) = subdP.mdamageH(subdP.pretreat  == 3);
    subdP.block = categorical(subdP.blc);
    % 1-way-ANOVA with block
     subdP.Y = subdP.ddamage;
       %     [p,tbl,stats1] = anovan(subdP.ddamage,{subdP.blc});
   %  subdP.blcresid= stats1. resid';  % save block residual as a new variable
%%% Hespeprotettix as responder
    subdH = TabH(TabH.compete == 0,:);
    subdH.Hesperotettix = subdH.pretreat  == 3; %  load of intra-species competitor is a factor
            subdH.Uroleucon = zeros(36,1);
    subdH.Uroleucon(subdH.pretreat  == 1) = subdH.Aphid(subdH.pretreat  == 1); % mean population of aphid (i.e. competitor No. 1)
            subdH.Paria = zeros(36,1);
    subdH.Paria(subdH.pretreat  == 2) = subdH.mdamageP(subdH.pretreat  == 2);
    subdH.block = categorical(subdH.blc);
    % 1-way-ANOVA with block
         subdH.Y = subdH.ddamage;
        %    [p,tbl,stats1] = anovan(subdH.ddamage,{subdH.blc});
  %   subdH.blcresid=  stats1. resid';  
%% Delayed competition: GLM analysis
  modelspec = 'Y~  Uroleucon + Paria + Hesperotettix + block'; 
  mdldA = fitglm(subdA,modelspec);
  mdldP = fitglm(subdP,modelspec);
  mdldH = fitglm(subdH,modelspec);
  