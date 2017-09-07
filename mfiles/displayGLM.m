%% Effect of inter- and intra species competition on performance 
% This script will display the result from *work_GLM.m*, using matlab *PUBLISH*  function to create this html documents.
%
%% Steps of analysis
% The analysis was done using code in [work_GLM.m], following steps below.
%
%  1. do one-way ANOVA for performance with blocks;  
%  2. use the residual from step 1. as response, do glm analysis on the effect of three species on the response.
%  3. do step 1 ~ 2 for cooccurrence and delayed competition
%
% For response of Paria and Hesperotettix, use number of damage. For Aphid
% use number of individual.
% 
% For the load of intra-species competitor, the independent variable is a
% factor (0 or 1); as inter-species competitor, the load of Paria and
% Hesperotettix is the mean of damage,  the load of Aphid is mean
% population.
%% Cooccurrence competition: Aphid as responder
% Result stored in the structure mdlA
       mdlA 
%% Cooccurrence competition: Paria as responder
% Result stored in the structure mdlP
       mdlP       
%% Cooccurrence competition: Hesperotettix as responder
% Result stored in the structure mdlH
       mdlH             
%% Delayed competition: Aphid as responder
% Result stored in the structure mdldA
       mdldA 
%% Delayed competition: Paria as responder
% Result stored in the structure mdldP
       mdldP       
%% Delayed competition: Hesperotettix as responder
% Result stored in the structure mdldH
       mdldH            