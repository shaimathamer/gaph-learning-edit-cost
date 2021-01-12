function Kv= Linear_Classier_learn_edit_costs_PALMPRINT_POINTS(data, Outlier)
 %    Outlier: Percentil. [1..99] 
 
    data1 = [];                
    for elem = 1:size(data,2)  
        display(floor(100*elem/size(data,2)));
        labelling = data{elem}.labelling;
        if(sum(labelling>0)>0)
            G1 = data{elem}.graph1;
            G2 = data{elem}.graph2;
 %         G1.nodes = Normalise_Coordinates(G1.nodes);
%         G2.nodes = Normalise_Coordinates(G2.nodes);
        %G1.nodes=houghTransform(G1.nodes,G2.nodes);
            for label = 1:length(labelling)
            % calcultating Substitution points (first option)
                if(labelling(label)>0)
                    data1(end+1)= Dist_Minutia(G1.nodes(label,:),G2.nodes(labelling(label),:)); % ***
                end
            end
        end
    end
% Outlier rejection
percntiles = prctile(data1,[Outlier 100-Outlier]); %5th and 95th percentile
outlierIndexA = data1 < percntiles(1) | data1 > percntiles(2);
data1(outlierIndexA) = [];
Kv=0.5*mean(data1);
end
