%% GLM: effect of inter- and intra species competition on performance 
%  1. do one-way anova for performance with blocks
%  2. use the residual from step 1. as response, to do the analysis
%  3. do step 1 ~ 2 for cooccurrence and delayed competition
% 
% 2015/11/25
%% Set up: run one script from below
%   cd 'C:\Users\ASUS\Dropbox\PhD_projects\herbivore_SG_Iva'
%     setupatlab      % using the ASUS laptop, in the lab
%     setupathome   % using the PC, at home
%% load data
    TabA= readtable('./data/TabA.txt','Delimiter',' ');
    TabP= readtable('./data/TabP.txt','Delimiter',' ');
    TabH= readtable('./data/TabH.txt','Delimiter',' ');

%% cooccurrence competition: preparing data
%%% Aphid as responder
    subA = TabA(TabA.pretreat == 0,:); % subset with only the  cooccurrence competition data, without pre-treatment
    subA.loadA = subA.compete == 1 ;     %  load of intra-species competitor is a factor
            subA.loadP = zeros(36,1);  % preparing data column   
    subA.loadP(subA.compete == 2)  =subA.mdamage( subA.compete == 2); % mean damage of competitor No.2 (i.e. Paria)
            subA.loadH = zeros(36,1); % preparing data column   
    subA.loadH(subA.compete == 3) = subA.mdamage( subA.compete == 3); % mean damage of competitor No.3 (i.e. Hesperotettix)
    subA.blccat = categorical(subA.blc); % change the block data into categorical, so it will be hadled properly in the matlab glm function
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subA.dAphid,{subA.blc});
    subA.blcresid = stats1. resid; % save block residual as a new variable
%%% Paria as responder   
    subP = TabP(TabP.pretreat == 0,:);
    subP.loadP = subP.compete == 2;
            subP.loadA= zeros(36,1);
    subP.loadA(subP.compete == 1) = subP.Aphid(subP.compete == 1);
            subP.loadH = zeros(36,1);
    subP.loadH(subP.compete == 3) = subP.mdamageH(subP.compete == 3);
    subP.blccat = categorical(subP.blc);
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subP.ddamage,{subP.blc});
     subP.blcresid= stats1. resid;  % save block residual as a new variable
%%% Hespeprotettix as responder
    subH = TabH(TabH.pretreat == 0,:);
    subH.loadH = subH.compete == 3; %  load of intra-species competitor is a factor
            subH.loadA = zeros(36,1);
    subH.loadA(subH.compete == 1) = subH.Aphid(subH.compete == 1); % mean population of aphid (i.e. competitor No. 1)
            subH.loadP = zeros(36,1);
    subH.loadP(subH.compete == 2) = subH.mdamageP(subH.compete == 2);
    subH.blccat = categorical(subH.blc);
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subH.ddamage,{subH.blc});
     subH.blcresid=  stats1. resid;
%% cooccurrence competition: GLM analysis
  modelspec = 'blcresid~  loadA + loadP + loadH'; 
  mdlA = fitglm(subA,modelspec);
  mdlP = fitglm(subP,modelspec);
  mdlH = fitglm(subH,modelspec);
  
%% Delayed competition: preparing data
%%% Aphid as responder
    subdA = TabA(TabA.compete == 0,:); % subset with only the  Delayed competition data, without competition 
    subdA.loadA = subdA.pretreat == 1 ;     %  load of intra-species competitor is a factor
            subdA.loadP = zeros(36,1);  % preparing data column   
    subdA.loadP(subdA.pretreat == 2)  = subdA.mdamage( subdA.pretreat == 2); % mean damage of competitor No.2 (i.e. Paria)
            subdA.loadH = zeros(36,1); % preparing data column   
    subdA.loadH(subdA.pretreat == 3) = subdA.mdamage( subdA.pretreat == 3); % mean damage of competitor No.3 (i.e. Hesperotettix)
    subdA.blccat = categorical(subdA.blc); % change the block data into categorical, so it will be hadled properly in the matlab glm function
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subdA.dAphid,{subdA.blc});
    subdA.blcresid = stats1. resid'; % save block residual as a new variable
%%% Paria as responder   
    subdP = TabP(TabP.compete== 0,:);
    subdP.loadP = subdP.pretreat == 2;
            subdP.loadA= zeros(36,1);
    subdP.loadA(subdP.pretreat  == 1) = subdP.Aphid(subdP.pretreat  == 1);
            subdP.loadH = zeros(36,1);
    subdP.loadH(subdP.pretreat  == 3) = subdP.mdamageH(subdP.pretreat  == 3);
    subdP.blccat = categorical(subdP.blc);
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subdP.ddamage,{subdP.blc});
     subdP.blcresid= stats1. resid';  % save block residual as a new variable
%%% Hespeprotettix as responder
    subdH = TabH(TabH.compete == 0,:);
    subdH.loadH = subdH.pretreat  == 3; %  load of intra-species competitor is a factor
            subdH.loadA = zeros(36,1);
    subdH.loadA(subdH.pretreat  == 1) = subdH.Aphid(subdH.pretreat  == 1); % mean population of aphid (i.e. competitor No. 1)
            subdH.loadP = zeros(36,1);
    subdH.loadP(subdH.pretreat  == 2) = subdH.mdamageP(subdH.pretreat  == 2);
    subdH.blccat = categorical(subdH.blc);
    % 1-way-ANOVA with block
            [p,tbl,stats1] = anovan(subdH.ddamage,{subdH.blc});
     subdH.blcresid=  stats1. resid';  
%% Delayed competition: GLM analysis
  modelspec = 'blcresid~  loadA + loadP + loadH'; 
  mdldA = fitglm(subdA,modelspec);
  mdldP = fitglm(subdP,modelspec);
  mdldH = fitglm(subdH,modelspec);
  