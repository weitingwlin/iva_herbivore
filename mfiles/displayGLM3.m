%% Effect of inter- and intra species competition on performance 

%% Cooccurrence competition: Aphid as responder
% Result stored in the structure mdlA
       mdlA 
      T =  mdlA.Coefficients;
      T.pValue(10) = mdlA.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
    %  T.Row = {'(intercept)'; 'Uroleucon (self)'; 'Paria'; 'Hesperotettix'; 'Model' };
      writetable(T,'./glm_concurrent_A.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Cooccurrence competition: Paria as responder
% Result stored in the structure mdlP
       mdlP    
      T =  mdlP.Coefficients;
       T.pValue(10) = mdlP.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
       writetable( T,'./glm_concurrent_P.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Cooccurrence competition: Hesperotettix as responder
% Result stored in the structure mdlH
       mdlH  
      T =  mdlH.Coefficients;
       T.pValue(10) = mdlH.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
        writetable(T,'./glm_concurrent_H.csv', ...
                      'Delimiter',',','WriteRowNames',true)
        clear T
%% Delayed competition: Aphid as responder
% Result stored in the structure mdldA
       mdldA 
      T =  mdldA.Coefficients;
       T.pValue(10) = mdldA.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
        writetable(T,'./glm_delayed_A.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Delayed competition: Paria as responder
% Result stored in the structure mdldP
       mdldP  
          T =  mdldP.Coefficients;
          
     T.pValue(10) = mdldP.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
         writetable(T,'./glm_delayed_P.csv', ...
                      'Delimiter',',','WriteRowNames',true)
%% Delayed competition: Hesperotettix as responder
% Result stored in the structure mdldH
       mdldH    
           T =  mdldH.Coefficients;
        
    T.pValue(10) = mdldH.coefTest;
       T.Row{10} = 'model';
          for i = 1:4
           T{:, i + 4} = strtrim(cellstr(num2str(T{:,i}, 2)));
           end
         writetable(T,'./glm_delayed_H.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T