%% Load the raw data
    data = xlsread('./data/rawdata/preference_data.xlsx',1);
% variable names in main data: InsectData and InsectData13
    fileID = fopen('./data/rawdata/preferenceName.txt');
            temp = textscan(fileID,'%s');
            prefNames = temp{1}'; % variable names for each column stored in  [Data]
    fclose(fileID); 
%% make table work with table
    tabpref = array2table(data,'variablenames',prefNames);
% ratio of preference: simple ratio of diet equal to 
    ratio = tabpref{:,'damagetreat'}./sum(tabpref{:,{'damagetreat','damagecontrol'}},2);
    PI = (tabpref{:,'damagecontrol'} - tabpref{:,'damagetreat'} ) ./sum(tabpref{:,{'damagetreat','damagecontrol'}},2);
    cattreat = categorical(tabpref.treatment,1:3,{'A','P','H'});
    catsubject = categorical(tabpref.subject,2:3,{'P','H'});
    catblock = categorical(tabpref.block,1:6,{'1','2','3','4','5','6'});
    cattype = categorical(tabpref.subjecttype,[0 1  3 4],{'F', 'M', 'small','medium'});
    tabtemp = table(cattreat,catsubject,catblock,cattype,ratio,PI);
    TabPref = [tabpref, tabtemp];
    
 %% Write table-form data
 writetable(TabPref,'./data/TabPref.txt','Delimiter',' ')


   
   