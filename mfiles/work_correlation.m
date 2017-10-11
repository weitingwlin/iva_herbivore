clear; clc
work_setup % for the pathes
script_compilefielddata
%%
Aall = mean(matA, 2);
Pall = mean(matP, 2);
Hall = mean(matH, 2);
Sall = mean(matS, 2);
Lall = mean(matL, 2);

tblAPHSL = table(Aall,Pall, Hall, Sall, Lall);
tblAPHSL.Properties.VariableNames = {'Uroleucon', 'Paria', 'Hesperotettix', 'Spider', 'Ladybeetle';};
%%

 mycorrplot_1(tblAPHSL)
 %%
 mycorrplot_2(tblP, tblAPHSL)