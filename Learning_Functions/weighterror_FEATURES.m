function F = weighterror_FEATURES(w)
    global LEARNING_SET;   
    global LAMBDA;
    
    F = 0;
    for elem = 1:size(LEARNING_SET,2)    
        G1 = LEARNING_SET{elem}.graph1;
        G2 = LEARNING_SET{elem}.graph2;
        
        LabIdeal = LEARNING_SET{elem}.labelling;
        Features_Distance_w=Compute_Features_Distance_weights(G1.nodes(:,3:end),G2.nodes(:,3:end),w);  
        Features_Distance=Compute_Features_Distance(G1.nodes(:,3:end),G2.nodes(:,3:end));  
        if not( size(Features_Distance_w,1)==size(Features_Distance_w,1)) % error
            LabIdeal(1)=-1;
        end
        LabAuto=Hungarian(Features_Distance_w);
        distanceIdeal = 0;
        for i = 1: size(G1.nodes,1)
            %if LabIdeal(i) > 0
                distanceIdeal=distanceIdeal+Features_Distance(i,LabIdeal(i));
            %end
        end
        distanceAuto = sum(sum(LabAuto.*Features_Distance_w));       
        F = F + ((distanceAuto - distanceIdeal)/size(Features_Distance_w,1))^2;        
    end
    F = (F/ length(LEARNING_SET))+LAMBDA *w'*w %(w'*w-1)^2
end