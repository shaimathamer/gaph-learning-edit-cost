function F = editcosterror_With_Weights_FEATURES(x)
    global LEARNING_SET;   
    global LAMBDA;
    global WEIGHTS;

    Kn = x(1);
    Ke = x(2);          
    F = 0;
    
    for elem = 1:size(LEARNING_SET,2)    
        G1 = LEARNING_SET{elem}.graph1;
        G2 = LEARNING_SET{elem}.graph2;
        LabIdeal = LEARNING_SET{elem}.labelling; 
        [distanceAuto,LabAuto]=BP_Clique_Centrality_h_With_Weights_Features(G1.nodes(:,3:end), G2.nodes(:,3:end),G1.edges, G2.edges, WEIGHTS,Kn, Ke);        
        distanceIdeal = Edit_Cost_Features_With_Weights(G1.nodes(:,3:end), G2.nodes(:,3:end),G1.edges, G2.edges,  WEIGHTS,Kn, Ke,LabIdeal);
        distanceAuto = Edit_Cost_Features_With_Weights(G1.nodes(:,3:end), G2.nodes(:,3:end),G1.edges, G2.edges,  WEIGHTS,Kn, Ke,LabAuto);       
        F = F + ((distanceAuto - distanceIdeal)/max(size(G1.nodes,2),size(G2.nodes,2)))^2;        
    end
    F = (F/ length(LEARNING_SET))+LAMBDA * (Kn^2 + Ke^2)
end