%%
clear; clc
work_setup % for the pathes
script_compilefielddata
%% read, compile patch variables
    M3 = csvread('data/patchdata2014.csv', 5, 6); % insect count data
    T2 = readtable('data/patchdata2014.csv');
    M4 = cellstr2num([T2.Location_Code(3: end)  T2.Patch_ID(3: end)]);
    tnames = T2.Properties.VariableNames;
    M3varname = tnames(7:end);
%% trim M3 so it matches the insect data
    M5 = zeros(38, 10);
    for p=1:38
        patch = patch_ind(p,:); % [ site, patch] 
        temp1 = find(((M4(:,1) == patch(1)) + (M4(:,2) == patch(2)))==2); % index for this patch
        M5(p, :) = M3(temp1, :);
    end
%%
  %  [coeff, score, latent, t2, perc_exp] = pca(M5(:, 7:10));
  %  pc1 = score(:, 1);
%%
    [coeff, score, latent, t2, perc_exp] = pca(M5(:, 6:10));
    PC1 = score(:, 1);
    M3varname(6:10)
%% write to table
    tblP = array2table([M5(:,[3 5 ])  PC1], 'variablenames', {'Area', 'DtN','PC1'});
    % M3varname{[3 5 ]}
%%
    clear T2 M4 M3 tnames
%%
    writetable(tblP, [ rdatapath '/Env.csv']); % taxa data, by plant (sample, beat)

%%
Aall = mean(matA, 2);
Pall = mean(matP, 2);
Hall = mean(matH, 2);
%Sall = mean(matS, 2); % spider
%Lall = mean(matL, 2); % ladybeetle

%Ajun = mean(matA(:,1:9), 2);
%Ajul = mean(matA(:,11:end), 2);
%Pjun = mean(matP(:,1:9), 2);
%Pjul = mean(matP(:,11:end), 2);
%Hjun = mean(matH(:,1:9), 2);
%Hjul = mean(matH(:,11:end), 2);
tblAPH = table(Aall,Pall, Hall);
writetable(tblAPH, [ rdatapath '/APH.csv']); % taxa data, by plant (sample, beat)