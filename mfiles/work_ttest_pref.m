%% Load data
    clear;clc
    TabPref = readtable('./data/TabPref.txt','Delimiter',' ');
    Results = [];
%% working within subsets, 
 % Subsetting data: treatment: H; subject: H
 HH = all([TabPref.treatment == 3 , TabPref.subject==3],2);
    PI_HH = TabPref{HH, { 'PI'}}; R_HH = TabPref{HH, 'ratio'};
   % type_HH = TabPref{HH, { 'cattype'}};
    % Check the effect of subject type
      %  [p, tab, stat] = anovan(PI_HH, {type_HH}); % if the effect of type is not important, lump the data
 %
 [h, stat] = explore_ttest(PI_HH); Result.HH = h; Result.HH_P=stat.p_value;
 [hr, statr] = explore_ttest(R_HH,0.5,'arcsinsqrt');
%% treatment: H; subjest: P
  HP = all([TabPref.treatment == 3 , TabPref.subject==2],2);
    PI_HP = TabPref{HP, { 'PI'}};
    R_HP = TabPref{HP, 'ratio'};
    %type_HP = TabPref{HP, { 'cattype'}};
    % Check the effect of subject type
    %[p, tab, stat] = anovan(PI_HP, {type_HP}); % if the effect of type is not important, lump the data
  % asin transform and t-test
  [h, stat] = explore_ttest(PI_HP);Result.HP = h; Result.HP_P=stat.p_value;
   [hr, statr] = explore_ttest(R_HP,0.5,'arcsinsqrt')
%% treat P; subjest: H
  PH = all([TabPref.treatment == 2 , TabPref.subject==3],2);
    PI_PH = TabPref{PH, { 'PI'}};
     R_PH = TabPref{PH, 'ratio'};
    %type_PH = TabPref{PH, { 'cattype'}};
    % Check the effect of subject type
    % [p, tab, stat] = anovan(PI_PH, {type_PH}); % if the effect of type is not important, lump the data
  % asin transform and t-test
  [h, stat] = explore_ttest(PI_PH);Result.PH = h; Result.PH_P=stat.p_value;
   [hr, statr] = explore_ttest(R_PH,0.5,'arcsinsqrt')
%% treat P; subjest: P
  PP = all([TabPref.treatment == 2 , TabPref.subject==2],2);
    PI_PP = TabPref{PP, { 'PI'}};
         R_PP = TabPref{PP, 'ratio'};
    %type_PP = TabPref{PP, { 'cattype'}};
    % Check the effect of subject type
  %  [p, tab, stat] = anovan(PI_PP, {type_PP}); % if the effect of type is not important, lump the data
  % asin transform and t-test
  [h, stat] = explore_ttest(PI_PP); Result.PP = h; Result.PP_P=stat.p_value;
  [hr, statr] = explore_ttest(R_PP,0.5,'arcsinsqrt')
%% treat A; subjest: H
  AH = all([TabPref.treatment == 1 , TabPref.subject==3],2);
    PI_AH = TabPref{AH, { 'PI'}};
    R_AH = TabPref{AH, 'ratio'};
    %type_AH = TabPref{AH, { 'cattype'}};
    % Check the effect of subject type
   % [p, tab, stat] = anovan(PI_AH, {type_AH}); % if the effect of type is not important, lump the data
  % asin transform and t-test
  [h, stat] = explore_ttest(PI_AH); Result.AH = h; Result.AH_P=stat.p_value;
  [hr, statr] = explore_ttest(R_AH,0.5,'arcsinsqrt')
 %% treat A; subjest: P
  AP = all([TabPref.treatment == 1 , TabPref.subject==2],2);
    PI_AP = TabPref{AP, { 'PI'}};
    R_AP = TabPref{AP, { 'ratio'}};
    % type_AP = TabPref{AP, { 'cattype'}};
    % Check the effect of subject type
   % [p, tab, stat] = anovan(PI_AP, {type_AP}); % if the effect of type is not important, lump the data
  [h, stat] = explore_ttest(PI_AP);Result.AP = h; Result.AP_P=stat.p_value;
  [hr, statr] = explore_ttest(R_AP,0.5,'arcsinsqrt'); 
  %%
  Result
  