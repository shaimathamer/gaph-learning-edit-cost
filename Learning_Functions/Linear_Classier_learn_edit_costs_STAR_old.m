function [Kv, Ke, data1, data2] = Linear_Classier_learn_edit_costs_STAR(data, Outlier,Imposed_Kv,Imposed_Ke)
 %    Outlier: Percentil. [1..99] 
 
    x1 = [];
    y1 = [];
    x2 = [];
    y2 = [];  
    for elem = 1:size(data,2)  
        elem
        labelling = data{elem}.labelling;
        if(sum(labelling>0)>0)
            G1 = data{elem}.graph1;
            G2 = data{elem}.graph2;
               xx1=[];
               yy1=[];

        for label = 1:length(labelling)
         
            % calcultating Substitution points (first option)
            if(labelling(label)>0)
                n = sum(G1.edges(label,:));
                m = sum(G2.edges(labelling(label),:));
                [costStar , nn]  = computeCostStar(G1, G2, label, labelling(label));
                %[costStar , nn]  = computeCostStar_with_lab(G1, G2, label, labelling(label), labelling);
                %DDD=m-2*nn-1;
                DDD=n-abs(n-m)+1;
                if (DDD ~= 0)
                    yy1(end+1) = (sqrt(sum((G1.nodes(label,:)-G2.nodes(labelling(label),:)).^2))+costStar) / DDD; 
                    xx1(end+1) = (DDD-1)  / DDD; 
                end
            else
  
            % calculating deletion points (second option)
                n = sum(G1.edges(label,:));
                xx2=[];
                yy2=[];
  
                for k = 1:length(G2.nodes(:,1))
                    m = sum(G2.edges(k,:));
                    
                    [costStar , nn]  = computeCostStar(G1, G2, label, k);
                    %[costStar , nn]  = computeCostStar_with_lab(G1, G2, label, k, labelling);
                    %DDD=m-2*nn-1;
                    DDD=n-abs(n-m)+1;
                    
                    if (DDD ~= 0)
                         yy2(end+1) = (sqrt(sum((G1.nodes(label,:)-G2.nodes(k,:)).^2))+ costStar) / DDD; 
                         xx2(end+1) = (DDD-1) / DDD; 
                    end
               end
               if(~isempty(yy2))
                    
                    
%                     if (mod(length(yy2),2)==0)
%                         yy2(end+1) = yy2(end);
%                         xx2(end+1) = xx2(end);
%                     end
%                     yyy2  = median(yy2);
%                     pos=find(yyy2==yy2);
%                     xxx2 = xx2(pos(1));
                    
                    yyy2  = mean(yy2);
                    xxx2 = mean(xx2);
                    
                    
                    
                    y2=[y2 , yyy2];
                    x2=[x2 , xxx2];
               end
            end
        end
        y1=[y1 , yy1];
        x1=[x1 , xx1];
        
%         if(~isempty(yy1))
%               y1(end+1) = mean(yy1);
%               x1(end+1) = mean(xx1);
%         end
%         if(~isempty(yy2))
%               y2(end+1) = mean(yy2);
%               x2(end+1) = mean(xx2);
%         end
    end
    end
        data1 = [x1;y1]';
        data2 = [x2;y2]';

% Outlier rejection
if Outlier >0
    percntiles = prctile(data1,[Outlier 100-Outlier]); %5th and 95th percentile
    outlierIndexA(:,1) = data1(:,1) < percntiles(1,1) | data1(:,1) > percntiles(2,1);
    outlierIndexA(:,2) = data1(:,2) < percntiles(1,2) | data1(:,2) > percntiles(2,2);
    outlierIndexA(:,1) = outlierIndexA(:,2) | outlierIndexA(:,1);
    data1(outlierIndexA(:,1),:) = [];

    percntiles = prctile(data2,[Outlier 100-Outlier]); %5th and 95th percentile
    outlierIndexB(:,1) = data2(:,1) > percntiles(2,1) | data2(:,1) < percntiles(1,1);
    outlierIndexB(:,2) = data2(:,2) > percntiles(2,2) | data2(:,2) < percntiles(1,2);
    outlierIndexB(:,1) = outlierIndexB(:,2)| outlierIndexB(:,1);
    data2(outlierIndexB(:,1),:) = [];
end
% outliers have been removed           
        
        if (length(data1) == 0)
            Kv = -Inf;
            Ke = -Inf;
        elseif(length(data2) == 0)
            Kv = Inf;
            Ke = Inf;
        else 

            x1=data1(:,1)';
            y1=data1(:,2)';
            x2=data2(:,1)';
            y2=data2(:,2)';

            trueDecision = [-ones(length(x1),1);ones(length(x2),1)];
            Training = [x1' y1' ; x2' y2'];

            [Ke, Kv] = Linear_Coefficients_2D (Training,trueDecision,Imposed_Kv,Imposed_Ke);
        end
end
