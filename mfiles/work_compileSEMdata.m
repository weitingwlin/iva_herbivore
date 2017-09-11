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
    [coeff, score,latent] = pca(M5(:, 7:10));
    pc1 = score(:, 1);
%% write to table
    tbl = array2table([M5(:,[3 5 6])  pc1], 'variablenames', {M3varname{[3 5 6]}, 'pc1'});
%%
    clear T2 M4 M3 tnames
%%
    writetable(tbl, [ rdatapath '/Env.csv']); % taxa data, by plant (sample, beat)
%%
script_compilefielddata
