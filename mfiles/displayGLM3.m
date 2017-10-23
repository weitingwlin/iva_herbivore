%% Effect of inter- and intra species competition on performance 

%% Cooccurrence competition: Aphid as responder
% Result stored in the structure mdlA
       mdlA 
      T =  mdlA.Coefficients(1:4,:);
      T.pValue(5) = mdlA.coefTest;
      T.Row{5} = 'model';
      writetable(T,'./glm_concurrent_A.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Cooccurrence competition: Paria as responder
% Result stored in the structure mdlP
       mdlP    
      T =  mdlP.Coefficients(1:4,:);
      T.pValue(5) = mdlP.coefTest;
      T.Row{5} = 'model';
       writetable( T,'./glm_concurrent_P.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Cooccurrence competition: Hesperotettix as responder
% Result stored in the structure mdlH
       mdlH  
      T =  mdlH.Coefficients(1:4,:);
      T.pValue(5) = mdlH.coefTest;
      T.Row{5} = 'model';
        writetable(mdlH.Coefficients(1:4,:),'./glm_concurrent_H.csv', ...
                      'Delimiter',',','WriteRowNames',true)
        clear T
%% Delayed competition: Aphid as responder
% Result stored in the structure mdldA
       mdldA 
      T =  mdldA.Coefficients(1:4,:);
      T.pValue(5) = mdldA.coefTest;
      T.Row{5} = 'model';
        writetable(T,'./glm_delayed_A.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T
%% Delayed competition: Paria as responder
% Result stored in the structure mdldP
       mdldP  
          T =  mdldP.Coefficients(1:4,:);
      T.pValue(5) = mdldP.coefTest;
      T.Row{5} = 'model';
         writetable(T,'./glm_delayed_P.csv', ...
                      'Delimiter',',','WriteRowNames',true)
%% Delayed competition: Hesperotettix as responder
% Result stored in the structure mdldH
       mdldH    
           T =  mdldH.Coefficients(1:4,:);
      T.pValue(5) = mdldH.coefTest;
      T.Row{5} = 'model';
         writetable(mdldH.Coefficients(1:4,:),'./glm_delayed_H.csv', ...
                      'Delimiter',',','WriteRowNames',true)
       clear T