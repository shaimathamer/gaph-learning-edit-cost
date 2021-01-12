function F = editcosterror_FEATURES(x)
    global LEARNING_SET;   
    global LAMBDA;
    global ATTRIBUTES;
    
    Kn = x(1);
    Ke = x(2);          
    F = 0;
    
    for elem = 1:size(LEARNING_SET,2)    
        G1 = LEARNING_SET{elem}.graph1;
        G2 = LEARNING_SET{elem}.graph2;
        LabIdeal = LEARNING_SET{elem}.labelling;
        attributes=ATTRIBUTES;
        [distanceAuto,LabAuto]=BP_Clique_Centrality_h_Features(G1.nodes, G2.nodes,G1.edges, G2.edges, attributes,Kn, Ke);        
        distanceIdeal = Edit_Cost(G1.nodes(:,3:end), G2.nodes(:,3:end),G1.edges, G2.edges, Kn, Ke,LabIdeal);
        distanceAuto = Edit_Cost(G1.nodes(:,3:end), G2.nodes(:,3:end),G1.edges, G2.edges, Kn, Ke,LabAuto);       
        F = F + ((distanceAuto - distanceIdeal)/size(G1.nodes,1))^2;   
   
    end
    F = (F/ length(LEARNING_SET))+LAMBDA * (Kn^2 + Ke^2)
end